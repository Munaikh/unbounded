import 'dart:convert';

import 'package:apparence_kit/core/initializer/onstart_service.dart';
import 'package:apparence_kit/modules/notifications/providers/models/notification.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universal_html/js.dart';
// ignore: depend_on_referenced_packages
import 'package:timezone/data/latest_all.dart' as tz;
// ignore: depend_on_referenced_packages
import 'package:timezone/timezone.dart' as tz;
import 'package:universal_io/io.dart';

final localNotifierProvider = Provider<LocalNotifier>((ref) {
  return LocalNotifier(
    notificationManager: FlutterLocalNotificationsPlugin(),
  );
});

const kAppName = 'YourAppName';

final notificationsSettingsProvider = Provider<NotificationSettings>((ref) {
  return NotificationSettings(
    notificationManager: FlutterLocalNotificationsPlugin(),
    androidChannel: const AndroidNotificationChannel(
      // channel id - you can use different channels for different purposes (News, Messages, etc)
      kAppName,
      // app id
      kAppName,
      // this is the description of the channel that will be shown in the Android notification settings
      description: 'general $kAppName channel',
      importance: Importance.max,
    ),
  );
});

/// Firebase shows automatically notifications when the app is in background
/// But when the app is in foreground, you have to show the notification yourself on iOS
/// Also with this you can schedule notifications
/// For more informations check the documentation: https://pub.dev/packages/flutter_local_notifications
///
/// As we don't rely on mocks we wrapped the flutter_local_notifications plugin for our needs
class LocalNotifier {
  final FlutterLocalNotificationsPlugin _notificationManager;

  LocalNotifier({
    required FlutterLocalNotificationsPlugin notificationManager,
  }) : _notificationManager = notificationManager;

  Future<void> show(NotificationSettings settings, Notification message) async {
    
    if (kIsWeb) {
      context.callMethod("showNotification", [
        message.title,
        message.body,
      ]);
      return;
    }
    
    _notificationManager.show(
      message.hashCode,
      message.title,
      message.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          settings.androidChannel.id,
          settings.androidChannel.name,
          importance: settings.androidChannel.importance,
          priority: Priority.high,
          channelDescription: settings.androidChannel.description ?? '',
        ),
      ),
      // you can add a payload to redirect the user to a specific page
      // payload: message.payload
    );
  }

  ////////////////////////
  /// Scheduling
  ////////////////////////

  Future<void> scheduleDailyAt({
    required String title,
    required String body,
    required DateTime date,
    String? payload,
    int notificationId = 0,
  }) async {
    await _notificationManager.cancel(notificationId);

    tz.initializeTimeZones();
    final scheduledDate = tz.TZDateTime.from(
      date.add(const Duration(days: 1)),
      tz.local,
    );

    const androidDetails = AndroidNotificationDetails(
      kAppName,
      kAppName,
      importance: Importance.max,
    );
    const iosDetails = DarwinNotificationDetails(
      threadIdentifier: kAppName,
    );
    const platformChannelSpecifics = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    await _notificationManager.zonedSchedule(
      notificationId,
      title,
      body,
      scheduledDate,
      platformChannelSpecifics,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  Future<void> scheduleIn({
    required String title,
    required String body,
    required Duration duration,
    String? payload,
    int notificationId = 0,
  }) async {
    await _notificationManager.cancel(notificationId);

    tz.initializeTimeZones();
    final now = DateTime.now();
    final scheduledDate = tz.TZDateTime.from(
      now.add(duration),
      tz.local,
    );

    const androidDetails = AndroidNotificationDetails(
      kAppName,
      kAppName,
      importance: Importance.max,
    );
    const iosDetails = DarwinNotificationDetails(
      threadIdentifier: kAppName,
    );
    const platformChannelSpecifics = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    await _notificationManager.zonedSchedule(
      notificationId,
      title,
      body,
      scheduledDate,
      platformChannelSpecifics,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }


  Future<void> scheduleFromNow({
    required String title,
    required String body,
    required Duration duration,
    required String channel,
  }) async {
    final List<PendingNotificationRequest> pendingNotificationRequests =
        await _notificationManager.pendingNotificationRequests();
    if (pendingNotificationRequests.isEmpty) {
      return;
    }

    final androidNotificationDetails = AndroidNotificationDetails(
      channel,
      channel,
      channelDescription: '$kAppName notification $channel',
    );
    final iosDetails = DarwinNotificationDetails(
      threadIdentifier: channel,
    );
    final notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosDetails,
    );
    await Future.delayed(
      duration,
      () => _notificationManager.show(
        0,
        title,
        body,
        notificationDetails,
      ),
    );
  }
}

/// This is the settings for the notifications
/// You could have this directly in LocalNotifier but it's better to separate the concerns
/// So now you can send different notifications with different settings
/// [init] method will be called automatically by the [Initializer] class
class NotificationSettings implements OnStartService {
  final FlutterLocalNotificationsPlugin _notificationManager;
  final AndroidNotificationChannel androidChannel;

  NotificationSettings({
    required FlutterLocalNotificationsPlugin notificationManager,
    required this.androidChannel,
  }) : _notificationManager = notificationManager;

  @override
  Future<void> init() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    _notificationManager.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) => redirectToPayload(payload),
    );
    await _notificationManager
        .resolvePlatformSpecificImplementation //
        <AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);
  }

  Future<bool> askPermission() async {
    if (Platform.isAndroid) {
      final result = await _notificationManager
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
      return result ?? false;
    } else if (Platform.isIOS) {
      final result = await _notificationManager
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, badge: true, sound: true);
      return result ?? false;
    }
    throw 'Platform not supported';
  }

  Future<void> redirectToPayload(
    NotificationResponse notificationResponse,
  ) async {
    if (notificationResponse.payload == null) {
      return;
    }
    final json = jsonDecode(
      notificationResponse.payload!,
    ) as Map<String, dynamic>;
    final notification = Notification.fromJson(json);
    await notification.onTap();
  }
}
