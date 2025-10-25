import 'package:apparence_kit/modules/notifications/repositories/device_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/device_api_fake.dart';

void main() {
  final fakeDeviceApi = FakeDeviceApi();

  Future<DeviceRepository> init() async {
    SharedPreferences.setMockInitialValues({});
    final sharedPrefs = await SharedPreferences.getInstance();
    return DeviceRepository(
      deviceApi: fakeDeviceApi,
      prefs: sharedPrefs,
    );
  }

  test(
    'register device should register a new device with an id',
    () async {
      final deviceRepository = await init();
      await deviceRepository.register('fake_user_id');
      final device = await deviceRepository.get();
      expect(device, isNotNull);
      expect(device!.id, isNotNull);
    },
  );

  test(
    'register device, then unregister should remove the device',
    () async {
      final deviceRepository = await init();
      await deviceRepository.register('fake_user_id');
      await deviceRepository.unregister('fake_user_id');
      final device = await deviceRepository.get();
      expect(device, isNull);
    },
  );

  test(
    'on token refresh, should update the device',
    () async {
      final deviceRepository = await init();
      await deviceRepository.register('fake_user_id');
      deviceRepository.onTokenUpdate(
        (device) => deviceRepository.updateToken(device.token),
      );
      expect(fakeDeviceApi.refreshTokenCallback, isNotNull);
      fakeDeviceApi.refreshTokenCallback!("updated_token");
      await Future.delayed(const Duration(milliseconds: 100));
      final updatedDevice = await deviceRepository.get();
      expect(updatedDevice!.token, 'updated_token');
    },
  );

  test(
    'should update token correctly',
    () async {
      final deviceRepository = await init();
      await deviceRepository.register('fake_user_id');
      await deviceRepository.updateToken('updated_token');
      await Future.delayed(const Duration(milliseconds: 100));
      final updatedDevice = await deviceRepository.get();
      expect(updatedDevice!.token, 'updated_token');
    },
  );
}
