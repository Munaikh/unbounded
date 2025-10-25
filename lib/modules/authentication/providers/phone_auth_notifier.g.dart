// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_auth_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// This notifier is used to handle the phone number authentication flow
/// It is used to send the OTP code to the user's phone number
/// and to verify the OTP code
/// It is also used to link the phone number to the user
/// and to sign in the user with the phone number
///
/// -- if you enable anonymous mode we try to link the user to the phone number
/// -- if it fails we sign in the user with the phone number

@ProviderFor(PhoneAuthNotifier)
const phoneAuthProvider = PhoneAuthNotifierProvider._();

/// This notifier is used to handle the phone number authentication flow
/// It is used to send the OTP code to the user's phone number
/// and to verify the OTP code
/// It is also used to link the phone number to the user
/// and to sign in the user with the phone number
///
/// -- if you enable anonymous mode we try to link the user to the phone number
/// -- if it fails we sign in the user with the phone number
final class PhoneAuthNotifierProvider
    extends $NotifierProvider<PhoneAuthNotifier, PhoneAuthState> {
  /// This notifier is used to handle the phone number authentication flow
  /// It is used to send the OTP code to the user's phone number
  /// and to verify the OTP code
  /// It is also used to link the phone number to the user
  /// and to sign in the user with the phone number
  ///
  /// -- if you enable anonymous mode we try to link the user to the phone number
  /// -- if it fails we sign in the user with the phone number
  const PhoneAuthNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'phoneAuthProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$phoneAuthNotifierHash();

  @$internal
  @override
  PhoneAuthNotifier create() => PhoneAuthNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PhoneAuthState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PhoneAuthState>(value),
    );
  }
}

String _$phoneAuthNotifierHash() => r'69fe22b6a7adaca8027a6051f2f161f147927f30';

/// This notifier is used to handle the phone number authentication flow
/// It is used to send the OTP code to the user's phone number
/// and to verify the OTP code
/// It is also used to link the phone number to the user
/// and to sign in the user with the phone number
///
/// -- if you enable anonymous mode we try to link the user to the phone number
/// -- if it fails we sign in the user with the phone number

abstract class _$PhoneAuthNotifier extends $Notifier<PhoneAuthState> {
  PhoneAuthState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<PhoneAuthState, PhoneAuthState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PhoneAuthState, PhoneAuthState>,
              PhoneAuthState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
