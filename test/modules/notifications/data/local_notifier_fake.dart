import 'package:apparence_kit/modules/notifications/api/local_notifier.dart';
import 'package:apparence_kit/modules/notifications/providers/models/notification.dart';
// ignore: depend_on_referenced_packages

class FakeLocalNotifier implements LocalNotifier {
  @override
  Future<void> show(NotificationSettings settings, Notification message) async {
    return;
  }

  @override
  Future<void> scheduleDailyAt({
    required String title,
    required String body,
    required DateTime date,
    String? payload,
    int notificationId = 0,
  }) {
    return Future.value();
  }

  @override
  Future<void> scheduleFromNow({
    required String title,
    required String body,
    required Duration duration,
    required String channel,
  }) {
    return Future.value();
  }

  @override
  Future<void> scheduleIn({
    required String title,
    required String body,
    required Duration duration,
    String? payload,
    int notificationId = 0,
  }) {
    return Future.value();
  }
}
