

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_entity.freezed.dart';
part 'activity_entity.g.dart';


@freezed
abstract class ActivityEntity with _$ActivityEntity {
  const factory ActivityEntity({
    required int id,
    required DateTime createdAt,
    required String name,
    String? description,
    int? cost,
    String? website,
    String? location,
    int? minGroupSize,
    int? maxGroupSize,
  }) = _ActivityEntity;

  factory ActivityEntity.fromJson(Map<String, dynamic> json) => _$ActivityEntityFromJson(json);
}