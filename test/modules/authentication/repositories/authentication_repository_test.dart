import 'package:apparence_kit/core/data/api/http_client.dart';
import 'package:apparence_kit/modules/authentication/repositories/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';

import '../../../core/data/api/storage_api_fake.dart';
import '../../../core/security/secured_storage_fake.dart';
import '../data/api/auth_api_fake.dart';
import '../data/api/user_api_fake.dart';

void main() {
  test('at initialization credentials should be null', () async {
    final authRepository = HttpAuthenticationRepository(
      logger: Logger(),
      authenticationApi: FakeAuthenticationApi(),
      storage: FakeAuthSecuredStorage.empty(),
      userApi: FakeUserApi(storageApi: FakeStorageApi()),
      httpClient: HttpClient(baseUrl: ''),
    );
    final credentials = await authRepository.get();
    expect(
      credentials,
      isNull,
      reason: 'user should be null at the beginning',
    );
  });

  test('user signup -> user should now connected', () async {
    final authRepository = HttpAuthenticationRepository(
      logger: Logger(),
      authenticationApi: FakeAuthenticationApi(),
      storage: FakeAuthSecuredStorage.empty(),
      userApi: FakeUserApi(storageApi: FakeStorageApi()),
      httpClient: HttpClient(baseUrl: ''),
    );
    await authRepository.signup('email', 'password');
    final credentials = await authRepository.get();
    expect(
      credentials,
      isNotNull,
      reason: 'user should be connected',
    );
  });

  test('user signin -> user should now connected', () async {
    final authRepository = HttpAuthenticationRepository(
      logger: Logger(),
      authenticationApi: FakeAuthenticationApi(),
      storage: FakeAuthSecuredStorage.empty(),
      userApi: FakeUserApi(storageApi: FakeStorageApi()),
      httpClient: HttpClient(baseUrl: ''),
    );
    await authRepository.signin('email', 'password');
    final credentials = await authRepository.get();
    expect(
      credentials,
      isNotNull,
      reason: 'user should be connected',
    );
  });

  test(
    'user is connected then logout -> user should now be in unauth state',
    () async {
      final authRepository = HttpAuthenticationRepository(
        logger: Logger(),
        authenticationApi: FakeAuthenticationApi(),
        userApi: FakeUserApi(storageApi: FakeStorageApi()),
        storage: FakeAuthSecuredStorage.empty(),
        httpClient: HttpClient(baseUrl: ''),
      );
      await authRepository.signin('email', 'password');
      var credentials = await authRepository.get();
      expect(
        credentials,
        isNotNull,
        reason: 'user should be connected',
      );
      await authRepository.logout();
      credentials = await authRepository.get();
      expect(
        credentials,
        isNull,
        reason: 'user should be disconnected',
      );
    },
  );
}
