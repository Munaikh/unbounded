import 'dart:convert';

import 'package:apparence_kit/core/shared_preferences/shared_preferences.dart';
import 'package:apparence_kit/modules/notifications/api/device_api.dart';
import 'package:apparence_kit/modules/notifications/api/entities/device_entity.dart';
import 'package:apparence_kit/modules/notifications/providers/models/device.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final deviceRepositoryProvider = Provider<DeviceRepository>(
  (ref) {
    final prefsLoader = ref.watch(sharedPreferencesProvider);
    return DeviceRepository(
      prefs: prefsLoader.prefs,
      deviceApi: ref.watch(deviceApiProvider),
    );
  },
);

const _devicePrefsKey = 'device';

typedef OnTokenRefreshCallback = void Function(Device device);

/// This repository is responsible for the device registration
/// You need to register the device in your backend to be able to send notifications
/// You can also unregister the device
/// The device is also stored in the shared preferences to prevent spamming the backend
/// The token is updated when the token is refreshed
/// Optionnaly you can also add the user id to the methods
class DeviceRepository {
  final DeviceApi _deviceApi;
  final SharedPreferences _prefs;

  DeviceRepository({
    required DeviceApi deviceApi,
    required SharedPreferences prefs,
  })  : _deviceApi = deviceApi,
        _prefs = prefs;

  Future<Device?> get() async {
    final deviceEntity = await _getFromPrefs();
    if (deviceEntity == null) {
      return null;
    }
    return Device.fromEntity(deviceEntity);
  }

  Future<void> register(String userId) async {
    final device = await _getFromPrefs();
    final newDevice = await _deviceApi.get();
    if (device != null && device.token == newDevice.token) {
      return;
    }
    final response = await _deviceApi.register(userId, newDevice);
    await _saveInPrefs(response);
  }

  Future<void> unregister(String userId) async {
    final device = await _getFromPrefs();
    if (device == null) {
      return;
    }
    await _deviceApi.unregister(userId, device.installationId);
    await _removeFromPrefs();
  }

  void onTokenUpdate(OnTokenRefreshCallback onTokenRefresh) {
    _deviceApi.onTokenRefresh((token) async {
      final device = await _getFromPrefs();
      if (device == null) {
        return;
      }
      final updatedDevice = device.copyWith(token: token);
      onTokenRefresh(Device.fromEntity(updatedDevice));
    });
  }

  void removeTokenUpdateListener() {
    _deviceApi.removeOnTokenRefreshListener();
  }

  Future<void> updateToken(String token) async {
    final device = await _getFromPrefs();
    if (device == null) {
      return;
    }
    final updatedDevice = device.copyWith(token: token);
    await _deviceApi.update(updatedDevice);
    await _saveInPrefs(updatedDevice);
  }

  /// ------------------------------
  /// PRIVATES
  /// ------------------------------

  Future<void> _saveInPrefs(DeviceEntity device) async {
    final json = device.toJsonForPrefs();
    final data = jsonEncode(json);
    await _prefs.setString(_devicePrefsKey, data);
  }

  Future<DeviceEntity?> _getFromPrefs() async {
    final deviceJson = _prefs.getString(_devicePrefsKey);
    if (deviceJson != null) {
      final deviceMap = jsonDecode(deviceJson) as Map<String, dynamic>;
      return DeviceEntity.fromPrefs(deviceMap);
    }
    return null;
  }

  Future<void> _removeFromPrefs() async {
    await _prefs.remove(_devicePrefsKey);
  }
}
