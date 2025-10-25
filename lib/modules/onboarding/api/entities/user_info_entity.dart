// ignore: depend_on_referenced_packages
// ignore_for_file: invalid_annotation_target



import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_info_entity.freezed.dart';
part 'user_info_entity.g.dart';




@freezed
sealed class UserInfoEntity with _$UserInfoEntity {
  const factory UserInfoEntity({
    @JsonKey(includeIfNull: false) String? id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'info_key') required String key,
    @JsonKey(name: 'info_value') required String value,
  }) = SubscriptionEntityData;

  factory UserInfoEntity.fromJson(Map<String, Object?> json) =>
      _$UserInfoEntityFromJson(json);
}

