import 'package:apparence_kit/modules/notifications/api/entities/device_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'device.freezed.dart';

@freezed
sealed class Device with _$Device {
  const factory Device({
    String? id,
    required String installationId,
    required String token,
    required OperatingSystem platform,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _DeviceData;

  factory Device.fromEntity(DeviceEntity entity) {
    return Device(
      id: entity.id,
      installationId: entity.installationId,
      token: entity.token,
      platform: entity.operatingSystem,
      createdAt: entity.creationDate,
      updatedAt: entity.lastUpdateDate,
    );
  }
}
