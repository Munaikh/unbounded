import 'package:apparence_kit/core/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../device_test_utils.dart';

void main() {
  group('Small device', () {
    testWidgets('Add a small child widget => shows correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ResponsiveLayout(
            small: Text('small'),
          ),
        ),
      );
      expect(find.text('small'), findsOneWidget);
    });
  });

  group('desktop device', () {
    testWidgets('Add small, medium, large child widget only => shows large',
        (tester) async {
      await tester.setScreenSize(desktopDeviceSpec);
      await tester.pumpWidget(
        const MaterialApp(
          home: ResponsiveLayout(
            small: Text('small'),
            medium: Text('medium'),
            large: Text('large'),
          ),
        ),
      );
      expect(find.text('large'), findsOneWidget);
    });

    testWidgets('Add a small child widget only => shows correctly',
        (tester) async {
      await tester.setScreenSize(desktopDeviceSpec);
      await tester.pumpWidget(
        const MaterialApp(
          home: ResponsiveLayout(
            small: Text('small'),
          ),
        ),
      );
      expect(find.text('small'), findsOneWidget);
    });
  });
}
