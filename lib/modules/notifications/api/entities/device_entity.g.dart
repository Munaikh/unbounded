// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceEntityData _$DeviceEntityDataFromJson(Map json) => DeviceEntityData(
  id: json['id'] as String?,
  userId: json['user_id'] as String?,
  creationDate: DateTime.parse(json['creation_date'] as String),
  lastUpdateDate: DateTime.parse(json['last_update_date'] as String),
  installationId: json['installation_id'] as String,
  token: json['token'] as String,
  operatingSystem: $enumDecode(
    _$OperatingSystemEnumMap,
    json['operatingSystem'],
  ),
);

Map<String, dynamic> _$DeviceEntityDataToJson(DeviceEntityData instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'user_id': instance.userId,
      'creation_date': instance.creationDate.toIso8601String(),
      'last_update_date': instance.lastUpdateDate.toIso8601String(),
      'installation_id': instance.installationId,
      'token': instance.token,
      'operatingSystem': _$OperatingSystemEnumMap[instance.operatingSystem]!,
    };

const _$OperatingSystemEnumMap = {
  OperatingSystem.ios: 'ios',
  OperatingSystem.android: 'android',
};
