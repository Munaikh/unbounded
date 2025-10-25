import 'package:apparence_kit/core/data/entities/user_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _kTokenKey = "token";
const _kUserIdKey = "userId";

final authSecuredStorageProvider = Provider<AuthSecuredStorage>(
  (ref) => AuthSecuredStorage.fromEnv(),
);

class AuthSecuredStorage {
  final FlutterSecureStorage _storage;

  AuthSecuredStorage({
    required FlutterSecureStorage storage,
  }) : _storage = storage;

  factory AuthSecuredStorage.fromEnv() => AuthSecuredStorage(
        storage: const FlutterSecureStorage(),
      );

  Future<void> write({
    required Credentials value,
  }) async {
    await _storage.write(key: _kUserIdKey, value: value.id);
    await _storage.write(key: _kTokenKey, value: value.token);
  }

  Future<Credentials?> read() async {
    final userId = await _storage.read(key: _kUserIdKey);
    final token = await _storage.read(key: _kTokenKey);
    if (userId != null && token != null) {
      return Credentials(
        id: userId,
        token: token,
      );
    }
    return null;
  }

  Future<void> clear() async {
    await _storage.delete(key: _kUserIdKey);
    await _storage.delete(key: _kTokenKey);
  }
}
