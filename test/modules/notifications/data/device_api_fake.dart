import 'package:apparence_kit/modules/notifications/api/device_api.dart';
import 'package:apparence_kit/modules/notifications/api/entities/device_entity.dart';

class FakeDeviceApi implements DeviceApi {
  OnTokenRefresh? refreshTokenCallback;

  @override
  Future<DeviceEntity> register(String userId, DeviceEntity device) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return Future.value(device.copyWith(id: 'fake_id'));
  }

  @override
  Future<void> unregister(String userId, String deviceId) async {
    await Future.delayed(const Duration(milliseconds: 100));
  }

  @override
  Future<DeviceEntity> get() {
    return Future.value(
      DeviceEntity(
        installationId: 'fake_installation_id',
        token: 'fake_token',
        operatingSystem: OperatingSystem.android,
        creationDate: DateTime.now(),
        lastUpdateDate: DateTime.now(),
      ),
    );
  }

  @override
  void onTokenRefresh(OnTokenRefresh onTokenRefresh) {
    refreshTokenCallback = onTokenRefresh;
  }

  @override
  Future<DeviceEntity> update(DeviceEntity device) {
    return Future.value(device.copyWith(lastUpdateDate: DateTime.now()));
  }

  @override
  void removeOnTokenRefreshListener() {
    refreshTokenCallback = null;
  }
}
