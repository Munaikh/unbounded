import 'package:apparence_kit/core/guards/guard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../../test_utils.dart';

void main() {
  testWidgets('guard condition returns true => pass through OK',
      (WidgetTester tester) async {
    await tester.pumpPage(
      routerConfig: GoRouter(
        initialLocation: '/page1',
        routes: [
          GoRoute(
            path: '/page1',
            builder: (context, state) => Guard(
              canActivate: Future.value(true),
              fallbackRoute: '/page2',
              child: const FakePage(msg: 'page1'),
            ),
          ),
          GoRoute(
            path: '/page2',
            builder: (context, state) => const FakePage(msg: 'page2'),
          ),
        ],
      ),
    );
    // ignore: avoid_redundant_argument_values
    await tester.pumpAndSettle(const Duration(milliseconds: 100));

    expect(find.text('page1'), findsOneWidget);
  });

  testWidgets('guard condition returns false => fallback to error url',
      (WidgetTester tester) async {
    await tester.pumpPage(
      routerConfig: GoRouter(
        initialLocation: '/page1',
        routes: [
          GoRoute(
            path: '/page1',
            builder: (context, state) => Guard(
              canActivate: Future.value(false),
              fallbackRoute: '/page2',
              child: const FakePage(msg: 'page1'),
            ),
          ),
          GoRoute(
            path: '/page2',
            builder: (context, state) => const FakePage(msg: 'page2'),
          ),
        ],
      ),
    );
    // ignore: avoid_redundant_argument_values
    await tester.pumpAndSettle(const Duration(milliseconds: 100));

    expect(find.text('page2'), findsOneWidget);
  });
}

class FakePage extends StatelessWidget {
  final String msg;

  const FakePage({
    super.key,
    required this.msg,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(msg),
    );
  }
}
