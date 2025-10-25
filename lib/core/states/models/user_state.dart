import 'package:apparence_kit/core/data/models/subscription.dart';
import 'package:apparence_kit/core/data/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_state.freezed.dart';

@freezed
sealed class UserState with _$UserState {
  const factory UserState({
    required User user,
  }) = UserStateData;

  const UserState._();

  /// The subscription will be null if we don't use the Subscrption module
  /// Or the user is not loaded
  Subscription? get subscription => switch(user) {
    AuthenticatedUserData(:final subscription) => subscription,
    AnonymousUserData(:final subscription) => subscription,
    _ => null,
  };
}
