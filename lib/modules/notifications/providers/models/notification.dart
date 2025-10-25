// ignore_for_file: invalid_annotation_target, constant_identifier_names

import 'package:apparence_kit/core/bottom_menu/bottom_menu.dart';
import 'package:apparence_kit/modules/notifications/api/entities/notifications_entity.dart';
import 'package:apparence_kit/modules/notifications/api/local_notifier.dart';
import 'package:apparence_kit/modules/notifications/repositories/notifications_repository.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

part 'notification.freezed.dart';
part 'notification.g.dart';

@freezed
sealed class Notification with _$Notification {
  const Notification._();

  const factory Notification.withData({
    String? id,
    required String title,
    required String body,
    required DateTime createdAt,
    DateTime? readAt,
    @JsonKey(includeFromJson: false, includeToJson: false)
    LocalNotifier? notifier,
    @JsonKey(includeFromJson: false, includeToJson: false)
    NotificationSettings? notifierSettings,
    NotificationTypes? type,
    Map<String, dynamic>? data,
  }) = NotificationData;

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);

  factory Notification.from(
    Map<String, dynamic> json, {
    String? id,
    Map<String, dynamic>? data,
    LocalNotifier? notifierApi,
    NotificationSettings? notifierSettings,
  }) =>
      Notification.withData(
        id: id,
        title: json['title'] as String,
        body: json['body'] as String,
        type: data != null && data.containsKey('type')
            ? NotificationTypes.values.firstWhere(
                (e) => e.name == data['type'],
                orElse: () => NotificationTypes.OTHER,
              )
            : null,
        data: data,
        createdAt: DateTime.now(),
        notifier: notifierApi,
        notifierSettings: notifierSettings,
      );

  Future<void> show({NotificationSettings? settings}) async {
    if (notifier == null) {
      throw Exception(
        'You must provide a LocalNotifierApi to show a notification',
      );
    }
    if (notifierSettings != null) {
      await notifier!.show(notifierSettings!, this);
      return;
    } else if (settings != null) {
      await notifier!.show(settings, this);
      return;
    }
    throw Exception(
      'You must provide a NotificationSettings to show a notification',
    );
  }

  bool get seen => readAt != null;

  Future<void> onTap() async {
    // If you want to open a link when the notification is tapped
    if (type == NotificationTypes.LINK && data?.containsKey('url') == true) {
      try {
        launchUrl(Uri.parse(data!['url'] as String));
      } catch (e, s) {
        Logger().e("error $e");
        Sentry.captureException(e, stackTrace: s);
      }
      return;
    }
    // If you want to navigate to a specific page when the notification is tapped
    // if (bottomMenuRouterKey.currentContext != null) {
    //   Navigator.of(bottomMenuRouterKey.currentContext!)
    //       .pushReplacementNamed('notifications');
    // }
  }
}

sealed class NotificationPermission {
  /// ask for permission if needed
  Future<void> maybeAsk() async {
    final permission = this;
    switch (permission) {
      case NotificationPermissionWaiting():
        await permission.ask();
      case NotificationPermissionDenied():
        await permission.ask();
      case NotificationPermissionGranted():
      default:
    }
  }
}

/// we asked for permission and it was granted
class NotificationPermissionGranted extends NotificationPermission {
  NotificationPermissionGranted();
}

/// we asked for permission and it was denied
class NotificationPermissionDenied extends NotificationPermission {
  final NotificationSettings? _notificationSettings;
  final NotificationsRepository? _repository;

  NotificationPermissionDenied({
    NotificationSettings? notificationSettings,
    NotificationsRepository? repository,
  })  : _repository = repository,
        _notificationSettings = notificationSettings;

  Future<void> ask() async {
    if (_notificationSettings == null) {
      throw Exception("NotificationsApi is null");
    }
    final granted = await _notificationSettings.askPermission();
    NotificationPermission? permission;
    if (granted) {
      permission = NotificationPermissionGranted();
    } else {
      permission = NotificationPermissionDenied();
    }
    await _repository!.init();
  }

  Future<void> openSettings() async {
    await openAppSettings();
  }
}

/// we never asked for permission
class NotificationPermissionWaiting extends NotificationPermission {
  final NotificationSettings? _notificationSettings;

  NotificationPermissionWaiting({
    NotificationSettings? notificationSettings,
  }) : _notificationSettings = notificationSettings;

  Future<void> ask() async {
    if (_notificationSettings == null) {
      throw Exception("NotificationsApi is null");
    }
    final granted = await _notificationSettings.askPermission();
    NotificationPermission? permission;
    if (granted) {
      permission = NotificationPermissionGranted();
    } else {
      permission = NotificationPermissionDenied();
    }
  }
}
