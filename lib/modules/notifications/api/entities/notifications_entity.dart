// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'notifications_entity.freezed.dart';
part 'notifications_entity.g.dart';

enum NotificationTypes { WELCOME, OTHER, LINK }

@freezed
sealed class NotificationEntity with _$NotificationEntity {
  const factory NotificationEntity({
    String? id,
    @JsonKey(name: 'user_id') String? userId,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'creation_date') required DateTime creationDate,
    @JsonKey(name: 'body') required String body,
    @JsonKey(name: 'read_date') DateTime? readDate,
    @JsonKey(name: 'type') NotificationTypes? type,
    @JsonKey(name: 'data') Map<String, dynamic>? data,
  }) = NotificationData;

  factory NotificationEntity.fromJson(Map<String, Object?> json) =>
      _$NotificationEntityFromJson(json);
}
