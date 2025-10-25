import 'package:apparence_kit/core/data/entities/user_entity.dart';
import 'package:apparence_kit/modules/authentication/api/authentication_api_interface.dart';

/// Fake implementation of [AuthenticationApi]
/// This is useful for testing purposes
class FakeAuthenticationApi implements AuthenticationApi {
  Credentials? current;

  @override
  Future<void> init() {
    return Future.value();
  }

  @override
  Future<Credentials> signup(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    current = Credentials(
      id: 'fake-user-id',
      token: 'fake-user-token-1234567890',
    );
    return current!;
  }

  @override
  Future<Credentials> signin(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    current = Credentials(
      id: 'fake-user-id',
      token: 'fake-user-token-1234567890',
    );
    return current!;
  }

  @override
  Future<Credentials> signinAnonymously() async {
    await Future.delayed(const Duration(seconds: 1));
    current = Credentials(
      id: 'fake-user-id-anonymous',
      token: 'fake-user-token-1234567898',
    );
    return current!;
  }

  @override
  Future<void> signout() async {
    current = null;
  }

  @override
  Future<Credentials> signinWithGoogle() async {
    await Future.delayed(const Duration(seconds: 1));
    current = Credentials(
      id: 'fake-user-id',
      token: 'fake-user-token-1234567890',
    );
    return current!;
  }

  @override
  Future<Credentials> signinWithGooglePlay() async {
    await Future.delayed(const Duration(seconds: 1));
    current = Credentials(
      id: 'fake-user-id',
      token: 'fake-user-token-1234567890',
    );
    return current!;
  }

  @override
  Future<Credentials> signinWithApple() async {
    await Future.delayed(const Duration(seconds: 1));
    current = Credentials(
      id: 'fake-user-id',
      token: 'fake-user-token-1234567890',
    );
    return current!;
  }

  @override
  Future<Credentials> signinWithFacebook() async {
    await Future.delayed(const Duration(seconds: 1));
    current = Credentials(
      id: 'fake-user-id',
      token: 'fake-user-token-1234567890',
    );
    return current!;
  }

  @override
  Future<void> recoverPassword(String email) async {
    await Future.delayed(const Duration(milliseconds: 100));
  }

  @override
  Future<Credentials?> get() {
    return Future.value(current);
  }

  
  @override
  Future<Credentials> signupFromAnonymousWithGoogle() async {
    await Future.delayed(const Duration(seconds: 1));
    current = Credentials(
      id: 'fake-user-id',
      token: 'fake-user-token-1234567890',
    );
    return current!;
  }

  
  @override
  Future<Credentials> signupFromAnonymousWithApple() async {
    await Future.delayed(const Duration(seconds: 1));
    current = Credentials(
      id: 'fake-user-id',
      token: 'fake-user-token-1234567890',
    );
    return current!;
  }

  @override
  Future<String> signinWithPhone(String phoneNumber) {
    return Future.value('fake-verification-id');
  }

  @override
  Future<Credentials> verifyPhoneAuth(String verificationId, String otp) async {
    await Future.delayed(const Duration(seconds: 1));
    current = Credentials(
      id: 'fake-user-id',
      token: 'fake-user-token-1234567890',
    );
    return current!;
  }

  @override
  Future<Credentials> confirmLinkPhoneAuth(
    String verificationId,
    String otp,
  ) async {
    await Future.delayed(const Duration(seconds: 1));
    current = Credentials(
      id: 'fake-user-id',
      token: 'fake-user-token-1234567890',
    );
    return current!;
  }

  @override
  Future<String> updateAuthPhone(String phoneNumber) {
    return Future.value('fake-verification-id');
  }
}
