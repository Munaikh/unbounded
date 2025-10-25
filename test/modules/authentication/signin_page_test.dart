import 'package:apparence_kit/core/data/api/http_client.dart';
import 'package:apparence_kit/modules/authentication/repositories/authentication_repository.dart';
import 'package:apparence_kit/modules/authentication/ui/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '../../core/data/api/storage_api_fake.dart';
import '../../core/security/secured_storage_fake.dart';
import '../../test_utils.dart';
import 'data/api/auth_api_fake.dart';
import 'data/api/user_api_fake.dart';

void main() {
  final authApiFake = FakeAuthenticationApi();
  final storageFake = FakeAuthSecuredStorage.empty();

  final authRepository = HttpAuthenticationRepository(
    logger: Logger(),
    authenticationApi: authApiFake,
    storage: storageFake,
    userApi: FakeUserApi(storageApi: FakeStorageApi()),
    httpClient: HttpClient(baseUrl: ''),
  );

  Future<void> beforeTest(WidgetTester tester) async {
    await tester.pumpPage(
      authApiFakeOverride: authApiFake,
      authSecuredStorageFakeOverride: storageFake,
      routerConfig: GoRouter(
        initialLocation: '/signin',
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const PageFake(Colors.blueAccent),
          ),
          GoRoute(
            path: '/signin',
            builder: (context, state) => const SigninPage(),
          ),
        ],
      ),
    );
    await authRepository.logout();
  }

  final validInputs = ValueVariant<TestEntry>({
    const TestEntry("test@example.com", "password"),
    const TestEntry("test@gmail.com", "passwordddd@1254"),
    const TestEntry("12d1@ouch.is", "AdndjFFFGG"),
  });

  final invalidInputs = ValueVariant<TestEntry>({
    const TestEntry("test.com", "password"),
    const TestEntry("test@gmail", "password1254"),
    const TestEntry("12d1@ouch.is", "a"),
  });

  testWidgets(
    'fill valid email, password and submit => should be connected',
    (tester) async {
      await beforeTest(tester);

      var auth = await authRepository.get();
      expect(auth, isNull, reason: 'user should be not authenticated');

      final emailInputFinder = find.byKey(const Key('email_input'));
      final passwordInputFinder = find.byKey(const Key('password_input'));

      // Enter text into the email and password input fields
      await tester.enterText(emailInputFinder, validInputs.currentValue!.email);
      await tester.enterText(
        passwordInputFinder,
        validInputs.currentValue!.password,
      );
      await tester.pumpAndSettle();

      // Find and tap the send button
      final sendButtonFinder = find.byKey(const Key('send_button'));
      await tester.tap(sendButtonFinder);

      // Wait for the state to update and our fake delay to finish
      await tester.pump(const Duration(milliseconds: 1500));
      await tester.pumpAndSettle(const Duration(milliseconds: 50));

      auth = await authRepository.get();
      expect(auth, isNotNull, reason: 'user should be authenticated');
    },
    variant: validInputs,
  );

  testWidgets(
    'fill invalid email or password and submit => should not try to authenticate',
    (tester) async {
      await beforeTest(tester);

      // Find the email and password input fields
      final emailInputFinder = find.byKey(const Key('email_input'));
      final passwordInputFinder = find.byKey(const Key('password_input'));

      // Enter text into the email and password input fields
      await tester.enterText(
          emailInputFinder, invalidInputs.currentValue!.email);
      await tester.enterText(
          passwordInputFinder, invalidInputs.currentValue!.password);
      await tester.pumpAndSettle();

      // Find and tap the send button
      final sendButtonFinder = find.byKey(const Key('send_button'));
      await tester.tap(sendButtonFinder);

      // Wait for the state to update
      await tester.pump(const Duration(milliseconds: 1500));

      final auth = await authRepository.get();
      expect(auth, isNull, reason: 'Email or password was incorect');
    },
    variant: invalidInputs,
  );
}

class TestEntry {
  final String email;
  final String password;

  const TestEntry(this.email, this.password);

  @override
  String toString() {
    return '{email: $email, password: $password}';
  }
}
