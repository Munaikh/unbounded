// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ads_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// ---------------------------------
/// ⚠ You first need to publish your app on the Play Store or App Store
/// then you will be able to get your ad unit ids.
/// publish a first version of your app without ads to get your app approved
/// then you will be able to add ads to your app.
/// see the guide on the ApparenceKit documentation
/// ---------------------------------

@ProviderFor(GoogleAdsNotifier)
const googleAdsProvider = GoogleAdsNotifierProvider._();

/// ---------------------------------
/// ⚠ You first need to publish your app on the Play Store or App Store
/// then you will be able to get your ad unit ids.
/// publish a first version of your app without ads to get your app approved
/// then you will be able to add ads to your app.
/// see the guide on the ApparenceKit documentation
/// ---------------------------------
final class GoogleAdsNotifierProvider
    extends $NotifierProvider<GoogleAdsNotifier, AdState> {
  /// ---------------------------------
  /// ⚠ You first need to publish your app on the Play Store or App Store
  /// then you will be able to get your ad unit ids.
  /// publish a first version of your app without ads to get your app approved
  /// then you will be able to add ads to your app.
  /// see the guide on the ApparenceKit documentation
  /// ---------------------------------
  const GoogleAdsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'googleAdsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$googleAdsNotifierHash();

  @$internal
  @override
  GoogleAdsNotifier create() => GoogleAdsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdState>(value),
    );
  }
}

String _$googleAdsNotifierHash() => r'c24a9476fbdfd490919d1cf20bab0bf26ebeb5c2';

/// ---------------------------------
/// ⚠ You first need to publish your app on the Play Store or App Store
/// then you will be able to get your ad unit ids.
/// publish a first version of your app without ads to get your app approved
/// then you will be able to add ads to your app.
/// see the guide on the ApparenceKit documentation
/// ---------------------------------

abstract class _$GoogleAdsNotifier extends $Notifier<AdState> {
  AdState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AdState, AdState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AdState, AdState>,
              AdState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
