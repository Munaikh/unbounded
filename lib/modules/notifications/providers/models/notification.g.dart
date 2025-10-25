// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationData _$NotificationDataFromJson(Map json) => NotificationData(
  id: json['id'] as String?,
  title: json['title'] as String,
  body: json['body'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  readAt: json['readAt'] == null
      ? null
      : DateTime.parse(json['readAt'] as String),
  type: $enumDecodeNullable(_$NotificationTypesEnumMap, json['type']),
  data: (json['data'] as Map?)?.map((k, e) => MapEntry(k as String, e)),
);

Map<String, dynamic> _$NotificationDataToJson(NotificationData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'createdAt': instance.createdAt.toIso8601String(),
      'readAt': instance.readAt?.toIso8601String(),
      'type': _$NotificationTypesEnumMap[instance.type],
      'data': instance.data,
    };

const _$NotificationTypesEnumMap = {
  NotificationTypes.WELCOME: 'WELCOME',
  NotificationTypes.OTHER: 'OTHER',
  NotificationTypes.LINK: 'LINK',
};
