import 'package:apparence_kit/core/data/models/user.dart';
import 'package:apparence_kit/core/states/user_state_notifier.dart';
import 'package:apparence_kit/core/widgets/toast.dart';
import 'package:apparence_kit/modules/authentication/api/authentication_api_interface.dart';
import 'package:apparence_kit/modules/authentication/providers/models/phone_signin_state.dart';
import 'package:apparence_kit/modules/authentication/repositories/authentication_repository.dart';
import 'package:apparence_kit/modules/authentication/repositories/exceptions/authentication_exceptions.dart';
import 'package:apparence_kit/router.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'phone_auth_notifier.g.dart';

/// This notifier is used to handle the phone number authentication flow
/// It is used to send the OTP code to the user's phone number
/// and to verify the OTP code
/// It is also used to link the phone number to the user
/// and to sign in the user with the phone number
///
/// -- if you enable anonymous mode we try to link the user to the phone number
/// -- if it fails we sign in the user with the phone number

@Riverpod(keepAlive: false)
class PhoneAuthNotifier extends _$PhoneAuthNotifier {
  late AuthenticationRepository _authRepository;

  @override
  PhoneAuthState build() {
    _authRepository = ref.read(authRepositoryProvider);
    final userState = ref.read(userStateNotifierProvider);

    final linkUser = switch (userState.user) {
      AuthenticatedUserData() => false,
      AnonymousUserData(:final id) when id != null => true,
      _ => false,
    };

    return PhoneAuthState.inputPhone(linkPhoneToUser: linkUser);
  }

  /// Send the OTP code to the user's phone number
  /// - If the phone number isn't linked to a user, we will link it to the current user
  /// - Otherwise, we will sign in the user with the phone number
  Future<void> sendOtp(String phoneNumber) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
      phoneNumber: phoneNumber,
    );

    try {
      Logger().i("Send OTP : linkPhoneToUser -> ${state.linkPhoneToUser}");
      final verificationId = switch (state.linkPhoneToUser) {
        true => await _authRepository.updateAuthPhone(phoneNumber),
        false => await _authRepository.signinWithPhone(phoneNumber),
      };

      state = PhoneAuthState.verifyOtp(
        phoneNumber: phoneNumber,
        verificationId: verificationId,
      );
    } on PhoneAlreadyLinkedException {
      final verificationId = await _authRepository.signinWithPhone(phoneNumber);
      state = PhoneAuthState.verifyOtp(
        phoneNumber: phoneNumber,
        verificationId: verificationId,
      );
    } on PhoneAuthException catch (e, stacktrace) {
      debugPrint(
        "Error while sending confirmation code, verify your phone number $e : $stacktrace",
      );
      state = state.copyWith(
        isLoading: false,
        error:
            "Error while sending confirmation code, verify your phone number",
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to send verification code: $e',
      );
    }
  }

  Future<void> verifyOtp(String otp) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final verificationId = switch (state) {
        PhoneAuthVerifyOtpState(:final verificationId) => verificationId,
        _ => throw Exception("Invalid state"),
      };

      final _ = switch (state.linkPhoneToUser) {
        true => await _authRepository.confirmLinkPhoneAuth(verificationId, otp),
        false => await _authRepository.verifyPhoneAuth(verificationId, otp),
      };

      ref
          .read(toastProvider)
          .success(
            title: "Success",
            text: "You are now signed in with your phone number",
          );
      await Future.delayed(const Duration(seconds: 2));
      ref.read(goRouterProvider).go("/");
    } on PhoneAuthException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } on PhoneAlreadyLinkedException {
      // on firebase, this is where this error is thrown
      // we can delete this when using Supabase
      state = state.copyWith(linkPhoneToUser: false);
      return sendOtp(otp);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to verify code: $e',
      );
    }
  }

  void reset() {
    state = const PhoneAuthState.inputPhone();
  }
}
