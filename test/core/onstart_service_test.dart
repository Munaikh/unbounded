import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../test_utils.dart';

void main() {
  testWidgets(
    'app start -> should be on ready state once all services are ready',
    (tester) async {
      // -
      await tester.pumpPage(
        home: const Text('ready'),
      );
      // expect(find.text('loading'), findsOneWidget);
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('ready'), findsOneWidget);
    },
  );
}
