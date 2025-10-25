// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NotificationsNotifier)
const notificationsProvider = NotificationsNotifierProvider._();

final class NotificationsNotifierProvider
    extends $AsyncNotifierProvider<NotificationsNotifier, NotificationsList> {
  const NotificationsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationsNotifierHash();

  @$internal
  @override
  NotificationsNotifier create() => NotificationsNotifier();
}

String _$notificationsNotifierHash() =>
    r'6e4bc0e813c64b0232578522ae56e399b3b45f36';

abstract class _$NotificationsNotifier
    extends $AsyncNotifier<NotificationsList> {
  FutureOr<NotificationsList> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<NotificationsList>, NotificationsList>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<NotificationsList>, NotificationsList>,
              AsyncValue<NotificationsList>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
