// ignore: depend_on_referenced_packages
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_entity.freezed.dart';
part 'device_entity.g.dart';

enum OperatingSystem {
  @JsonValue('ios')
  ios,
  @JsonValue('android')
  android,
}

@freezed
sealed class DeviceEntity with _$DeviceEntity {
  const factory DeviceEntity({
    @JsonKey(includeIfNull: false) String? id,
    @JsonKey(name: "user_id") String? userId,
    @JsonKey(name: 'creation_date') required DateTime creationDate,
    @JsonKey(name: 'last_update_date') required DateTime lastUpdateDate,
    @JsonKey(name: 'installation_id') required String installationId,
    @JsonKey(name: 'token') required String token,
    @JsonKey(name: 'operatingSystem') required OperatingSystem operatingSystem,
  }) = DeviceEntityData;

  const DeviceEntity._();

  factory DeviceEntity.fromJson(Map<String, Object?> json) =>
      _$DeviceEntityFromJson(json);

  factory DeviceEntity.fromPrefs(Map<String, dynamic> json) => DeviceEntity(
        id: json['id'] as String?,
        installationId: json['installation_id'] as String? ?? '',
        token: json['token'] as String? ?? '',
        operatingSystem: OperatingSystem.values.firstWhere(
          (e) => e.name == json['operatingSystem'] as String?,
          orElse: () => throw Exception(
            "Operating system not found for ${json['operatingSystem']}",
          ),
        ),
        creationDate: DateTime.parse(json['creation_date'] as String),
        lastUpdateDate: DateTime.parse(json['last_update_date'] as String),
      );

  Map<String, dynamic> toJsonForPrefs() => toJson();
}
