import 'package:apparence_kit/modules/authentication/providers/models/email.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recover_state.freezed.dart';

@freezed
sealed class RecoverState with _$RecoverState {
  const factory RecoverState({
    required Email email,
  }) = RecoverStateData;

  const factory RecoverState.sending({
    required Email email,
  }) = RecoverStateSending;

  const factory RecoverState.sent({
    required Email email,
  }) = RecoverStateSent;

  const RecoverState._();
}
