import 'package:apparence_kit/modules/authentication/ui/recover_password_page.dart';
import 'package:apparence_kit/modules/authentication/ui/widgets/recover_password_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../../test_utils.dart';

void main() {
  Future<void> beforeTest(WidgetTester tester) async {
    await tester.pumpPage(
      routerConfig: GoRouter(
        initialLocation: '/recover_password',
        routes: [
          GoRoute(
            name: 'home',
            path: '/',
            builder: (context, state) => const PageFake(Colors.blueAccent),
          ),
          GoRoute(
            name: 'recover_password',
            path: '/recover_password',
            builder: (context, state) => const RecoverPasswordPage(),
          ),
        ],
      ),
    );
  }

  testWidgets(
    'Recover password page => should display email input and submit button',
    (tester) async {
      await beforeTest(tester);

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    },
  );

  testWidgets(
    'fill valid email then send => should show recover password sent page',
    (tester) async {
      await beforeTest(tester);
      const email = 'bruce@wayne.com';

      final emailInputFinder = find.byKey(const Key('email_input'));
      final sendButtonFinder = find.byKey(const Key('recover_button'));

      await tester.enterText(emailInputFinder, email);
      await tester.pump(const Duration(milliseconds: 1000));
      await tester.tap(sendButtonFinder);
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();

      expect(find.byType(RecoverPasswordSent), findsOneWidget);
    },
  );
}
