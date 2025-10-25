// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionEntityData _$SubscriptionEntityDataFromJson(Map json) =>
    SubscriptionEntityData(
      id: json['id'] as String?,
      userId: json['user_id'] as String,
      key: json['info_key'] as String,
      value: json['info_value'] as String,
    );

Map<String, dynamic> _$SubscriptionEntityDataToJson(
  SubscriptionEntityData instance,
) => <String, dynamic>{
  'id': ?instance.id,
  'user_id': instance.userId,
  'info_key': instance.key,
  'info_value': instance.value,
};
