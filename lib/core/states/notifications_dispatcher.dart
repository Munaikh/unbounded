import 'dart:async';

import 'package:apparence_kit/modules/notifications/providers/models/notification.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationDipatcherProvider = Provider<NotificationDispatcher>((ref) {
  final dispatcher = NotificationDispatcher();
  ref.onDispose(() => dispatcher.dispose());
  return dispatcher;
});

/// Use this when you want to publish a notification inside the app
final notificationPublisherProvider = Provider<NotificationPublisher>((ref) {
  return ref.watch(notificationDipatcherProvider);
});

/// use this if you want to listen to notifications anywhere in the app
final notificationSubscriberProvider = Provider<NotificationSubscriber>((ref) {
  return ref.watch(notificationDipatcherProvider);
});

abstract class NotificationPublisher {
  void publish(Notification notification);
}

typedef OnNotificationEvent = void Function(Notification notification);

abstract class NotificationSubscriber {
  void subscribe(OnNotificationEvent onNotificationEvent);

  void unsubscribe(OnNotificationEvent onNotificationEvent);
}

/// This class is responsible for dispatching notifications to the app
/// It is also responsible for listening to notifications
class NotificationDispatcher
    implements NotificationPublisher, NotificationSubscriber {
  final StreamController<Notification> _controller;
  late final Stream<Notification> _stream;

  Stream<Notification> get stream => _stream;

  final List<OnNotificationEvent> _onNotificationEventsSubscriber;

  NotificationDispatcher()
      : _onNotificationEventsSubscriber = [],
        _controller = StreamController() {
    _stream = _controller.stream.asBroadcastStream();
    start();
  }

  void start() {
    stream.listen((event) async {
      // You can also check the notification type and do something specific
      for (final subscriber in _onNotificationEventsSubscriber) {
        subscriber(event);
      }
      await event.show();
    });
  }

  void dispose() {
    _onNotificationEventsSubscriber.clear();
    _controller.close();
  }

  @override
  void unsubscribe(OnNotificationEvent subscriber) {
    _onNotificationEventsSubscriber.remove(subscriber);
  }

  @override
  void publish(Notification event) {
    _controller.add(event);
  }

  @override
  void subscribe(OnNotificationEvent onNotificationEvent) {
    _onNotificationEventsSubscriber.add(onNotificationEvent);
  }
}
