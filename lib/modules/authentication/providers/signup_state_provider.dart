import 'package:apparence_kit/core/states/user_state_notifier.dart';
import 'package:apparence_kit/modules/authentication/providers/models/email.dart';
import 'package:apparence_kit/modules/authentication/providers/models/password.dart';
import 'package:apparence_kit/modules/authentication/providers/models/signup_state.dart';
import 'package:apparence_kit/modules/authentication/repositories/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'signup_state_provider.g.dart';

@Riverpod(keepAlive: false)
class SignupStateNotifier extends _$SignupStateNotifier {
  AuthenticationRepository get _authRepository =>
      ref.read(authRepositoryProvider);

  UserStateNotifier get _userStateNotifier =>
      ref.read(userStateNotifierProvider.notifier);

  @override
  SignupState build() {
    return SignupState(email: Email(''), password: Password(''));
  }

  void setEmail(String? value) {
    final email = Email(value ?? '');
    if (email == state.email) {
      return;
    }
    state = state.copyWith(email: email);
  }

  void setPassword(String? pwd) {
    final password = Password(pwd ?? '');
    if (password == state.password) {
      return;
    }
    state = state.copyWith(password: password);
  }

  Future<void> signup() async {
    if (state is SignupStateSending) {
      return;
    }
    try {
      state.email.validate();
      state.password.validate();
      state = SignupState.sending(email: state.email, password: state.password);
      await _authRepository.signup(state.email.value, state.password.value);
      // lets fake a delay to prevent spamming the signup button
      await Future.delayed(const Duration(milliseconds: 1500));
      await _userStateNotifier.onSignin();
    } catch (e, trace) {
      debugPrint("Error while signing up: $e, $trace");
      state = SignupState(email: state.email, password: state.password);
      rethrow;
    }
  }
}
