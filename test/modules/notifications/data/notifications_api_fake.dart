import 'package:apparence_kit/modules/notifications/api/entities/notifications_entity.dart';
import 'package:apparence_kit/modules/notifications/api/notifications_api.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// ignore: depend_on_referenced_packages
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';

class FakeNotificationsApi implements NotificationsApi {
  OnRemoteMessage? _backgroundHandler;
  OnRemoteMessage? _foregroundHandler;
  OnRemoteMessage? _onOpenNotificationHandler;

  @override
  Future<void> requestPermission() => Future.value();

  @override
  void setBackgroundHandler(OnRemoteMessage handler) {
    _backgroundHandler = handler;
  }

  @override
  void setForegroundHandler(OnRemoteMessage handler) {
    _foregroundHandler = handler;
  }

  @override
  void setOnOpenNotificationHandler(OnRemoteMessage handler) {
    _onOpenNotificationHandler = handler;
  }

  void sendBackgroundMessage(RemoteMessage message) {
    _backgroundHandler?.call(message);
  }

  void sendForegroundMessage(RemoteMessage message) {
    _foregroundHandler?.call(message);
  }

  void sendOnOpenNotificationMessage(RemoteMessage message) {
    _onOpenNotificationHandler?.call(message);
  }

  @override
  Future<void> read(String userId, String notificationId) {
    return Future.value();
  }

  @override
  Stream<int> unreadNotifications(String userId) {
    return Stream.value(1);
  }

  @override
  Future<List<NotificationEntity>> get(
    String userId, {
    DateTime? startDate,
    required int limit,
    int page = 0,
  }) {
    return Future.value(List.generate(
      20,
      (index) => NotificationEntity(
        id: '$index',
        title: 'title $index',
        body: 'body $index',
        creationDate: index > 2
            ? DateTime.now()
            : DateTime.now().subtract(const Duration(days: 4)),
        readDate: index > 2 ? DateTime.now() : null,
      ),
    ));
  }

  @override
  void registerTopic(String topic) {}

  @override
  void unregisterTopic(String topic) {}

  @override
  Future<PermissionStatus> getPermissionStatus() {
    return Future.value(PermissionStatus.granted);
  }
}
