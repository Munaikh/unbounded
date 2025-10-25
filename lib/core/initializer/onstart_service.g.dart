// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onstart_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(OnStartNotifier)
const onStartProvider = OnStartNotifierProvider._();

final class OnStartNotifierProvider
    extends $NotifierProvider<OnStartNotifier, AppRunState> {
  const OnStartNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onStartProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onStartNotifierHash();

  @$internal
  @override
  OnStartNotifier create() => OnStartNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppRunState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppRunState>(value),
    );
  }
}

String _$onStartNotifierHash() => r'5354bc4bdbe3d859e2c431ca74ab1dfe162cc102';

abstract class _$OnStartNotifier extends $Notifier<AppRunState> {
  AppRunState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AppRunState, AppRunState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppRunState, AppRunState>,
              AppRunState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
