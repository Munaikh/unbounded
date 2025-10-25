import 'dart:async';

import 'package:apparence_kit/core/data/api/base_api_exceptions.dart';
import 'package:apparence_kit/modules/notifications/api/entities/device_entity.dart';
import 'package:firebase_app_installations/firebase_app_installations.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:universal_io/io.dart';

abstract class DeviceApi {
  /// We use a unique id for the device / installation
  /// This allows to send notifications to a specific device
  /// iOS and Android tends now to restrict the use of device id
  /// You could also generate your own id and store it in the device
  /// But as we use firebase for notifications we can use the firebase installation id
  Future<DeviceEntity> get();

  /// Register the device in the backend
  /// Of course your backend should check if the device is already registered
  /// throws an [ApiError] if something goes wrong
  Future<DeviceEntity> register(String userId, DeviceEntity device);

  /// Update the device in the backend
  /// throws an [ApiError] if something goes wrong
  Future<DeviceEntity> update(DeviceEntity device);

  /// Unregister the device in the backend
  Future<void> unregister(String userId, String deviceId);

  /// Listen to token refresh
  void onTokenRefresh(OnTokenRefresh onTokenRefresh);

  /// Remove the token refresh listener
  void removeOnTokenRefreshListener();
}

typedef OnTokenRefresh = void Function(String token);

final deviceApiProvider = Provider<DeviceApi>(
  (ref) => FirebaseDeviceApi(
    client: Supabase.instance.client,
    messaging: FirebaseMessaging.instance,
    installations: FirebaseInstallations.instance,
  ),
);

class FirebaseDeviceApi implements DeviceApi {
  final SupabaseClient _client;
  final FirebaseMessaging _messaging;
  final FirebaseInstallations _installations;
  StreamSubscription? _onTokenRefreshSubscription;

  FirebaseDeviceApi({
    required SupabaseClient client,
    required FirebaseMessaging messaging,
    required FirebaseInstallations installations,
  })  : _client = client,
        _messaging = messaging,
        _installations = installations;

  @override
  Future<DeviceEntity> get() async {
    try {
      final installationId = await _installations.getId();
      final token = await _messaging.getToken();
      final os = Platform.isAndroid
          ? OperatingSystem.android //
          : OperatingSystem.ios;
      return DeviceEntity(
        installationId: installationId,
        token: token!,
        operatingSystem: os,
        creationDate: DateTime.now(),
        lastUpdateDate: DateTime.now(),
      );
    } catch (e) {
      throw ApiError(
        code: 0,
        message: '$e',
      );
    }
  }

  @override
  Future<DeviceEntity> register(String userId, DeviceEntity device) async {
    try {
      final deviceCpy = device.copyWith(userId: userId);
      final result = await _client
          .from('devices') //
          .insert(deviceCpy.toJson())
          .select();
      return DeviceEntity.fromJson(result.first);
    } catch (e, trace) {
      throw ApiError(
        code: 0,
        message: '$e : $trace',
      );
    }
  }

  @override
  Future<DeviceEntity> update(DeviceEntity device) async {
    try {
      final result = await _client
          .from('devices') //
          .update(device.toJson())
          .eq('installation_id', device.installationId)
          .select();
      return DeviceEntity.fromJson(result.first);
    } catch (e, trace) {
      throw ApiError(
        code: 0,
        message: '$e: $trace',
      );
    }
  }

  @override
  Future<void> unregister(String userId, String installationId) async {
    try {
      await _client
          .from('devices') //
          .delete()
          .eq('installation_id', installationId);
    } catch (e) {
      throw ApiError(
        code: 0,
        message: '$e',
      );
    }
  }

  @override
  void onTokenRefresh(OnTokenRefresh onTokenRefresh) {
    _onTokenRefreshSubscription =
        _messaging.onTokenRefresh.listen((data) => onTokenRefresh(data));
  }

  @override
  void removeOnTokenRefreshListener() {
    _onTokenRefreshSubscription?.cancel();
  }
}
