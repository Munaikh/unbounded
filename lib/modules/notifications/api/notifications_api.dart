import 'package:apparence_kit/core/data/api/base_api_exceptions.dart';
import 'package:apparence_kit/modules/notifications/api/entities/notifications_entity.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

final notificationsApiProvider = Provider<NotificationsApi>(
  (ref) => FirebaseNotificationsApi(
    messaging: FirebaseMessaging.instance,
    logger: Logger(),
    client: Supabase.instance.client,
  ),
);

/// This class is responsible for listening from firebase notifications
/// As I like repositories to not depend on external libraries
/// I wrapped some of the firebase messaging methods
///
/// You could use directly the firebase messaging methods but making a fake implementation
/// of this class would be harder.
abstract class NotificationsApi {
  /// Request permission to receive notifications
  Future<void> requestPermission();

  // Used to listen to notifications when the app is in foreground
  void setForegroundHandler(OnRemoteMessage handler);

  // Used to listen to notifications when the app is in background
  void setBackgroundHandler(OnRemoteMessage handler);

  // Used to listen to notifications when user clicks on the notification
  void setOnOpenNotificationHandler(OnRemoteMessage handler);

  // Used to get the past notifications from the server
  Future<List<NotificationEntity>> get(
    String userId, {
    DateTime? startDate,
    required int limit,
    int page = 0,
  });

  // Used to mark a notification as read
  Future<void> read(String userId, String notificationId);

  // Used to get the unread notifications count
  Stream<int> unreadNotifications(String userId);

  // Used to register to a topic
  void registerTopic(String topic);

  // Used to unregister from a topic
  void unregisterTopic(String topic);

  // Used to get the permission status
  Future<PermissionStatus> getPermissionStatus();
}

typedef OnRemoteMessage = Future<void> Function(RemoteMessage message);

class FirebaseNotificationsApi implements NotificationsApi {
  final FirebaseMessaging _messaging;
  final SupabaseClient _client;
  final Logger _logger;

  FirebaseNotificationsApi({
    required FirebaseMessaging messaging,
    required SupabaseClient client,
    required Logger logger,
  })  : _messaging = messaging,
        _client = client,
        _logger = logger;

  @override
  Future<void> requestPermission() async {
    try {
      await _messaging.requestPermission();
    } catch (e) {
      _logger.e(e);
    }
  }

  @override
  void setForegroundHandler(OnRemoteMessage handler) {
    FirebaseMessaging.onMessage.listen(handler);
  }

  @override
  void setBackgroundHandler(OnRemoteMessage handler) {
    FirebaseMessaging.onBackgroundMessage(handler);
  }

  @override
  void setOnOpenNotificationHandler(OnRemoteMessage handler) {
    FirebaseMessaging.onMessageOpenedApp.listen(handler);
  }

  @override
  void registerTopic(String topic) {
    _messaging.subscribeToTopic(topic);
  }

  @override
  void unregisterTopic(String topic) {
    _messaging.unsubscribeFromTopic(topic);
  }

  // Used to get the past notifications from the server
  Future<List<NotificationEntity>> get(
    String userId, {
    DateTime? startDate,
    required int limit,
    int page = 0,
  }) async {
    try {
      final response = await _client
          .from('notifications')
          .select()
          .eq('user_id', userId)
          .order('creation_date', ascending: false)
          .range(page * limit, (page + 1) * limit - 1);
      if (response.isEmpty) {
        return [];
      }
      return response
          .map((e) => NotificationEntity.fromJson(e)) //
          .toList();
    } catch (e, stacktrace) {
      throw ApiError(
        code: 0,
        message: '$e: $stacktrace',
      );
    }
  }

  @override
  Future<void> read(String userId, String notificationId) async {
    try {
      await _client
          .from('notifications')
          .update({'read_date': DateTime.now().toString()})
          .eq('user_id', userId)
          .eq('id', notificationId);
    } catch (e, stacktrace) {
      throw ApiError(
        code: 0,
        message: '$e: $stacktrace',
      );
    }
  }

  @override
  Stream<int> unreadNotifications(String userId) {
    try {
      return _client
          .from('notifications')
          .stream(primaryKey: ['id'])
          .eq('user_id', userId)
          .limit(10)
          .map((event) => event.length);
    } catch (e, stacktrace) {
      debugPrint('$e: $stacktrace');
      throw ApiError(
        code: 0,
        message: '$e: $stacktrace',
      );
    }
  }

  @override
  Future<PermissionStatus> getPermissionStatus() {
    return Permission.notification.status;
  }
}
