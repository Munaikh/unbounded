import 'dart:convert';

import 'package:apparence_kit/core/data/api/base_api_exceptions.dart';
import 'package:apparence_kit/core/data/api/http_client.dart';
import 'package:apparence_kit/core/data/entities/user_entity.dart';

import 'package:apparence_kit/environnements.dart';
import 'package:apparence_kit/modules/authentication/api/authentication_api_interface.dart';
import 'package:apparence_kit/modules/authentication/repositories/exceptions/authentication_exceptions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';


import 'package:supabase_flutter/supabase_flutter.dart';

final authenticationApiProvider = Provider<AuthenticationApi>(
  (ref) => SupabaseAuthenticationApi(
    client: Supabase.instance.client,
    environment: ref.watch(environmentProvider),
  ),
);

class SupabaseAuthenticationApi implements AuthenticationApi {
  final SupabaseClient client;
  final Environment environment;
  final Logger _logger = Logger();

  SupabaseAuthenticationApi({
    required this.client,
    required this.environment,
  });

  @override
  Future<void> init() async {}

  @override
  Future<void> recoverPassword(String email) {
    return client.auth.resetPasswordForEmail(email);
  }

  Future<Credentials?> get() async {
    final user = client.auth.currentUser;
    if (user == null) {
      return null;
    }
    return Credentials(id: user.id, token: '');
  }

  @override
  Future<Credentials> signup(String email, String password) async {
    if (client.auth.currentUser?.isAnonymous == true) {
      final res = await client.auth.updateUser(UserAttributes(email: email, password: password));
      if (res.user == null) {
        throw 'Error while updating user';
      }
      return Credentials(id: res.user!.id, token: '');
    }
    return client.auth
        .signUp(
          email: email,
          password: password,
        )
        .then(
          (value) => Credentials(
            id: value.user!.id,
            token: value.session?.accessToken ?? '',
          ),
          onError: (error) {
            Logger().e("Error while signup: $error");
            Logger().e('''
==============================================================
💡 Please check you enabled email authentication in Supabase 
  (Supabase dashboard > Authentication > Providers > Email (enable it))
  -> disable Confirm email as you are on mobile. You don't want a user to leave the app to confirm email.
Note: wait a minute after enabling before trying again. It takes a bit of time to propagate.
Second note: Ensure you installed database schema and policies : https://apparencekit.dev/docs/start/supabase-setup/
==============================================================
                ''');
            return error;
          },
        );
  }

  @override
  Future<Credentials> signin(String email, String password) {
    return client.auth
        .signInWithPassword(
          email: email,
          password: password,
        )
        .then(
          (value) => Credentials(
            id: value.user!.id,
            token: value.session?.accessToken ?? '',
          ),
        );
  }

  @override
  Future<Credentials> signinAnonymously() {
    return client.auth.signInAnonymously().then(
          (value) => Credentials(
            id: value.user!.id,
            token: value.session?.accessToken ?? '',
          ),
          onError: (error) {
            Logger().e("Error while signing in anonymously: $error");
            Logger().e('''
==============================================================
💡 Please check you enabled anonymous sign-in in Supabase 
  (Supabase dashboard > project settings > Authentication > Allow anonymous sign-in (don't enable captcha)
Note: wait a minute after enabling anonymous sign-in before trying again. It takes a bit of time to propagate.
==============================================================
                ''');
            return error;
          },
        );
  }

  @override
  Future<Credentials> signinWithApple() async {
    throw UnimplementedError();
  }

  @override
  Future<Credentials> signinWithFacebook() {
    // TODO: implement signinWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<Credentials> signinWithGoogle() async {
    throw UnimplementedError();
  }

  @override
  Future<Credentials> signinWithGooglePlay() {
    // TODO: implement signinWithGooglePlay
    throw UnimplementedError();
  }

  @override
  Future<void> signout() {
    return client.auth.signOut();
  }

  
  @override
  Future<Credentials> signupFromAnonymousWithApple() async {
    // final credential = await SignInWithApple.getAppleIDCredential(
    //   scopes: [ AppleIDAuthorizationScopes.email],
    // );
    // final response = await client.auth.linkIdentityWithIdToken(
    //   provider: OAuthProvider.apple,
    //   idToken: credential.identityToken!,
    // );
    // return Credentials(id: response.user!.id, token: response.session?.accessToken ?? '');
    // TODO: implement signinWithGooglePlay
    throw UnimplementedError();
  }

  @override
  Future<Credentials> signupFromAnonymousWithGoogle() async {
    // final scopes = ['email'];
    // // get the clientId your settings on google cloud console
    // // see : https://supabase.com/docs/guides/auth/social-login/auth-google?queryGroups=platform&platform=flutter-mobile
    // const iosClientId = '';
    // final googleSignIn = GoogleSignIn.instance;

    // await googleSignIn.initialize(clientId: iosClientId);
    // final googleUser = await googleSignIn.authenticate();
    // final googleAuth = googleUser.authentication;

    // final response = await client.auth.linkIdentityWithIdToken(
    //   provider: OAuthProvider.google,
    //   idToken: googleAuth.idToken!,
    // );
    // return Credentials(id: response.user!.id, token: response.session?.accessToken ?? '');
    // TODO: implement signinWithGooglePlay
    throw UnimplementedError();
  }
  

  @override
  Future<String> signinWithPhone(String phoneNumber) async {
    try {
      _logger.d('Requesting OTP for phone number: $phoneNumber');
      final normalizedPhone = _normalizePhoneNumber(phoneNumber);

      await client.auth.signInWithOtp(
        phone: normalizedPhone,
      );

      return normalizedPhone;
    } catch (e) {
      _logger.e('Error requesting phone authentication: $e');
      throw ApiError(
        code: 0,
        message: 'Failed to send verification code: $e',
      );
    }
  }

  @override
  Future<String> updateAuthPhone(String phoneNumber) async {
    final user = client.auth.currentUser;
    if (user == null) {
      throw ApiError(
        code: 401,
        message: 'User not found',
      );
    }
    try {
      final normalizedPhone = _normalizePhoneNumber(phoneNumber);
      await client.auth.updateUser(UserAttributes(phone: normalizedPhone));
      return normalizedPhone;
    } on AuthException catch (e) {
      final code = e.code;
      _logger.e('Error updating phone number: $code');
      if (code == 'phone_exists') {
        throw PhoneAlreadyLinkedException();
      }
      throw ApiError(
        code: 401,
        message: 'Failed to update phone number: $e',
      );
    } catch (e) {
      _logger.e('Error updating phone number: $e');
      throw ApiError(
        code: 0,
        message: 'Failed to update phone number: $e',
      );
    }
  }

  @override
  Future<Credentials> confirmLinkPhoneAuth(
    String verificationId,
    String otp,
  ) async {
    try {
      _logger.d('confirmLinkPhoneAuth OTP for phone: $verificationId');
      final phoneNumber = verificationId;

      final res = await client.auth.verifyOTP(
        phone: phoneNumber,
        token: otp,
        type: OtpType.phoneChange,
      );

      if (res.user == null) {
        throw ApiError(
          code: 401,
          message: 'Verification failed. Invalid OTP code.',
        );
      }

      return Credentials(
        id: res.user!.id,
        token: res.session?.accessToken ?? '',
      );
    } catch (e) {
      _logger.e('Error verifying phone OTP: $e');
      throw ApiError(
        code: 401,
        message: 'Failed to verify OTP: $e',
      );
    }
  }

  @override
  Future<Credentials> verifyPhoneAuth(String verificationId, String otp) async {
    try {
      _logger.d('Verifying OTP for phone: $verificationId');
      final phoneNumber = verificationId;

      final res = await client.auth.verifyOTP(
        phone: phoneNumber,
        token: otp,
        type: OtpType.sms,
      );

      if (res.user == null) {
        throw ApiError(
          code: 401,
          message: 'Verification failed. Invalid OTP code.',
        );
      }

      return Credentials(
        id: res.user!.id,
        token: res.session?.accessToken ?? '',
      );
    } catch (e) {
      _logger.e('Error verifying phone OTP: $e');
      throw ApiError(
        code: 401,
        message: 'Failed to verify OTP: $e',
      );
    }
  }

  String _normalizePhoneNumber(String phoneNumber) {
    String normalized = phoneNumber.replaceAll(RegExp(r'\D'), '');
    if (!normalized.startsWith('+')) {
      normalized = '+$normalized';
    }
    return normalized;
  }
}
