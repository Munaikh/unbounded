import 'package:apparence_kit/core/states/notifications_dispatcher.dart';
import 'package:apparence_kit/modules/notifications/providers/models/notification.dart';
import 'package:apparence_kit/modules/notifications/repositories/notifications_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';

import '../data/local_notifier_fake.dart';
import '../data/notifications_api_fake.dart';
import '../data/notifications_settings_fake.dart';

void main() {
  final dispatcher = NotificationDispatcher();
  final fakeNotificationsApi = FakeNotificationsApi();
  final fakeLocalNotificationsApi = FakeLocalNotifier();
  final fakeNotificationsSettings = NotificationsSettingsFake();

  final repository = AppNotificationsRepository(
    notificationsApi: fakeNotificationsApi,
    notificationPublisher: dispatcher,
    localNotifier: fakeLocalNotificationsApi,
    notificationSettings: fakeNotificationsSettings,
  );

  test('on receive message, should dispatch as a notification', () async {
    await repository.init();

    Notification? receivedNotification;
    dispatcher.subscribe((notification) => receivedNotification = notification);
    fakeNotificationsApi.sendForegroundMessage(
      const RemoteMessage(
        notification: RemoteNotification(
          title: 'title',
          body: 'example body',
        ),
        data: {
          'type': 'my type',
        },
      ),
    );
    await Future.delayed(const Duration(milliseconds: 100));
    expect(receivedNotification, isNotNull);
    expect(receivedNotification!.title, 'title');
    expect(receivedNotification!.body, 'example body');
  });

  test('fetch notifications, should return 20 notifications', () async {
    final notifications = await repository.get('userId');
    expect(notifications.length, 20);
    final firstNotif = notifications.first;
    expect(firstNotif.id, isNotNull);
    expect(firstNotif.title, isNotNull);
    expect(firstNotif.body, isNotNull);
    expect(firstNotif.createdAt, isNotNull);
  });

  test('read notification', () async {
    final notifications = await repository.get('userId');
    final readNotification = await repository.read(
      'userId',
      notifications.first,
    );
    expect(readNotification, isNotNull);
    expect(readNotification.seen, isTrue);
  });

  test('listen to user notifications count', () async {
    final count$ = repository.listenToUnreadNotificationsCount('userId');
    final count = await count$.first;
    expect(count, 1);
  });
}
