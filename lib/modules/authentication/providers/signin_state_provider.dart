import 'package:apparence_kit/core/states/user_state_notifier.dart';
import 'package:apparence_kit/modules/authentication/providers/models/email.dart';
import 'package:apparence_kit/modules/authentication/providers/models/password.dart';
import 'package:apparence_kit/modules/authentication/providers/models/signin_state.dart';
import 'package:apparence_kit/modules/authentication/providers/models/signup_state.dart';
import 'package:apparence_kit/modules/authentication/repositories/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'signin_state_provider.g.dart';

@Riverpod(keepAlive: false)
class SigninStateNotifier extends _$SigninStateNotifier {
  AuthenticationRepository get _authRepository =>
      ref.read(authRepositoryProvider);

  UserStateNotifier get _userStateNotifier =>
      ref.read(userStateNotifierProvider.notifier);

  @override
  SigninState build() {
    return SigninState(email: Email(""), password: Password(""));
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

  Future<void> signin() async {
    if (state is SignupStateSending) {
      return;
    }
    try {
      state.email.validate();
      state.password.validate();
      state = SigninState.sending(email: state.email, password: state.password);
      await _authRepository.signin(state.email.value, state.password.value);
      // lets fake a delay to prevent spamming the signup button
      await Future.delayed(const Duration(milliseconds: 1500));
      await _userStateNotifier.onSignin();
    } catch (e, trace) {
      debugPrint("Error while signing up: $e, $trace");
      state = SigninState(email: state.email, password: state.password);
      rethrow;
    }
  }

  Future<void> signinWithGoogle() async {
    if (state is SignupStateSending) {
      return;
    }
    try {
      state = SigninState.sending(email: state.email, password: state.password);
      await _authRepository.signinWithGoogle();
      // lets fake a delay to prevent spamming the signup button
      await Future.delayed(const Duration(milliseconds: 1500));
      await _userStateNotifier.onSignin();
    } catch (e, trace) {
      debugPrint("Error while signing up: $e, $trace");
      state = SigninState(email: state.email, password: state.password);
      rethrow;
    }
  }

  Future<void> signinWithGooglePlayGames() async {
    if (state is SignupStateSending) {
      return;
    }
    try {
      state = SigninState.sending(email: state.email, password: state.password);
      await _authRepository.signinWithGooglePlayGames();
      // lets fake a delay to prevent spamming the signup button
      await Future.delayed(const Duration(milliseconds: 1500));
      await _userStateNotifier.onSignin();
    } catch (e, trace) {
      debugPrint("Error while signing up: $e, $trace");
      state = SigninState(email: state.email, password: state.password);
      rethrow;
    }
  }

  Future<void> signinWithApple() async {
    if (state is SignupStateSending) {
      return;
    }
    try {
      state = SigninState.sending(email: state.email, password: state.password);
      await _authRepository.signinWithApple();
      // lets fake a delay to prevent spamming the signup button
      await Future.delayed(const Duration(milliseconds: 1500));
      await _userStateNotifier.onSignin();
    } catch (e, trace) {
      debugPrint("Error while signing up: $e, $trace");
      state = SigninState(email: state.email, password: state.password);
      rethrow;
    }
  }

  Future<void> signinWithFacebook() async {
    if (state is SignupStateSending) {
      return;
    }
    try {
      state = SigninState.sending(email: state.email, password: state.password);
      await _authRepository.signinWithFacebook();
      // lets fake a delay to prevent spamming the signup button
      await Future.delayed(const Duration(milliseconds: 1500));
      await _userStateNotifier.onSignin();
    } catch (e, trace) {
      debugPrint("Error while signing up: $e, $trace");
      state = SigninState(email: state.email, password: state.password);
      rethrow;
    }
  }
}
