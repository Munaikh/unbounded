// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationData _$NotificationDataFromJson(Map json) => NotificationData(
  id: json['id'] as String?,
  userId: json['user_id'] as String?,
  title: json['title'] as String,
  creationDate: DateTime.parse(json['creation_date'] as String),
  body: json['body'] as String,
  readDate: json['read_date'] == null
      ? null
      : DateTime.parse(json['read_date'] as String),
  type: $enumDecodeNullable(_$NotificationTypesEnumMap, json['type']),
  data: (json['data'] as Map?)?.map((k, e) => MapEntry(k as String, e)),
);

Map<String, dynamic> _$NotificationDataToJson(NotificationData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'title': instance.title,
      'creation_date': instance.creationDate.toIso8601String(),
      'body': instance.body,
      'read_date': instance.readDate?.toIso8601String(),
      'type': _$NotificationTypesEnumMap[instance.type],
      'data': instance.data,
    };

const _$NotificationTypesEnumMap = {
  NotificationTypes.WELCOME: 'WELCOME',
  NotificationTypes.OTHER: 'OTHER',
  NotificationTypes.LINK: 'LINK',
};
