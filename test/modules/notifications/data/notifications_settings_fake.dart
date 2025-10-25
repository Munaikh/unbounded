import 'package:apparence_kit/modules/notifications/api/local_notifier.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsSettingsFake implements NotificationSettings {
  @override
  AndroidNotificationChannel get androidChannel =>
      const AndroidNotificationChannel(
        // channel id - you can use different channels for different purposes (News, Messages, etc)
        'YourApp',
        // app id
        'YourApp',
        // this is the description of the channel that will be shown in the Android notification settings
        description: 'general YourApp channel',
        importance: Importance.max,
      );

  @override
  Future<void> init() async {}

  @override
  Future<void> redirectToPayload(NotificationResponse notificationResponse) {
    return Future.value();
  }

  @override
  Future<bool> askPermission() {
    return Future.value(true);
  }
}
