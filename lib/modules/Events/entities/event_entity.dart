import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_entity.freezed.dart';
part 'event_entity.g.dart';

@freezed
abstract class EventEntity with _$EventEntity {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory EventEntity({
    required String id,
    required DateTime createdAt,
    required String title,
    required String description,
    DateTime? date,
    String? location,
    String? bgUrl,
    String? album,
    required String owner,
    int? activityId,
  }) = _EventEntity;

  factory EventEntity.fromJson(Map<String, dynamic> json) => _$EventEntityFromJson(json);
}
