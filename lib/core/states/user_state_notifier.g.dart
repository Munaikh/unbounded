// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_state_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// This class is responsible for managing the state of the user over the app.
/// It will be used to know if the user is connected or not and to get the user

@ProviderFor(UserStateNotifier)
const userStateProvider = UserStateNotifierProvider._();

/// This class is responsible for managing the state of the user over the app.
/// It will be used to know if the user is connected or not and to get the user
final class UserStateNotifierProvider
    extends $NotifierProvider<UserStateNotifier, UserState> {
  /// This class is responsible for managing the state of the user over the app.
  /// It will be used to know if the user is connected or not and to get the user
  const UserStateNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userStateNotifierHash();

  @$internal
  @override
  UserStateNotifier create() => UserStateNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserState>(value),
    );
  }
}

String _$userStateNotifierHash() => r'294bd520005299f96356ba7a86e5e0267ad90c80';

/// This class is responsible for managing the state of the user over the app.
/// It will be used to know if the user is connected or not and to get the user

abstract class _$UserStateNotifier extends $Notifier<UserState> {
  UserState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<UserState, UserState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UserState, UserState>,
              UserState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
