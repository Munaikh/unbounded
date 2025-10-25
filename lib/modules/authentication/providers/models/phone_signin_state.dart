import 'package:freezed_annotation/freezed_annotation.dart';

part 'phone_signin_state.freezed.dart';

@freezed
sealed class PhoneAuthState with _$PhoneAuthState {
  const factory PhoneAuthState.inputPhone({
    @Default(false) bool isLoading,
    @Default('') String phoneNumber,
    String? error,
    @Default(false) bool linkPhoneToUser,
  }) = PhoneAuthInputPhoneState;

  const factory PhoneAuthState.verifyOtp({
    @Default(false) bool isLoading,
    @Default('') String phoneNumber,
    @Default('') String verificationId,
    String? error,
    @Default(false) bool linkPhoneToUser,
  }) = PhoneAuthVerifyOtpState;
}
