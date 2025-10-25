import 'package:apparence_kit/core/data/entities/user_entity.dart';
import 'package:apparence_kit/core/security/secured_storage.dart';

/// This is a fake implementation of [AuthSecuredStorage]
/// As it uses the [FlutterSecureStorage] it is not possible to use it without a real device
/// We prefer using a fake implementation instead of a mock
/// because we want our tests to not reflect the implementation details of the [AuthSecuredStorage]
/// this also makes tests easier to maintain
class FakeAuthSecuredStorage implements AuthSecuredStorage {
  Credentials? credentials;

  FakeAuthSecuredStorage({
    this.credentials,
  });

  factory FakeAuthSecuredStorage.empty() => FakeAuthSecuredStorage();

  @override
  Future<Credentials?> read() {
    return Future.value(credentials);
  }

  @override
  Future<void> write({required Credentials value}) async {
    await Future.delayed(const Duration(milliseconds: 50));
    credentials = value;
  }

  @override
  Future<void> clear() async {
    credentials = null;
  }
}
