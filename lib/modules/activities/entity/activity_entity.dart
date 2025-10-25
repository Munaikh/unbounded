import 'package:apparence_kit/modules/activities/entity/tag_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_entity.freezed.dart';
part 'activity_entity.g.dart';

@freezed
abstract class ActivityEntity with _$ActivityEntity {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory ActivityEntity({
    required int id,
    required DateTime createdAt,
    required String name,
    String? imageUrl,
    String? description,
    int? cost,
    String? website,
    String? location,
    int? minGroupSize,
    int? maxGroupSize,
    @Default([]) List<TagEntity> tags,
  }) = _ActivityEntity;

  factory ActivityEntity.fromJson(Map<String, dynamic> json) => _$ActivityEntityFromJson(json);
}
