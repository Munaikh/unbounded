import 'package:apparence_kit/core/data/models/user.dart';
import 'package:apparence_kit/core/rating/widgets/rate_banner.dart';
import 'package:apparence_kit/core/states/models/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../test_utils.dart';

void main() {
  testWidgets(
    'user exists since 4 days, has never rate app, settings is set after 3 days -> should show RatingBanner',
    (widgetTester) async {
      await widgetTester.pumpPage(
        userState: UserState(
          user: User.authenticated(
            id: '1',
            email: 'user@email.com',
            name: 'user name',
            onboarded: true,
            creationDate: DateTime.now().subtract(const Duration(days: 4)),
          ),
        ),
        home: const Scaffold(
          body: RateBanner(
            delayBeforeAsking: Duration(days: 3),
            delayBeforeAskingAgain: Duration(days: 7),
          ),
        ),
      );
      expect(find.byType(RateBannerWidget), findsOneWidget);
    },
  );

  testWidgets(
    'user exists since 1 days, has never rate app, settings is set after 3 days-> should not show RatingBanner',
    (widgetTester) async {
      await widgetTester.pumpPage(
        userState: UserState(
          user: User.authenticated(
            id: '1',
            email: 'user@email.com',
            name: 'user name',
            onboarded: true,
            creationDate: DateTime.now().subtract(const Duration(days: 1)),
          ),
        ),
        home: const Scaffold(
          body: RateBanner(
            delayBeforeAsking: Duration(days: 3),
            delayBeforeAskingAgain: Duration(days: 7),
          ),
        ),
      );
      expect(find.byType(RateBannerWidget), findsNothing);
    },
  );

  testWidgets(
    'rating banner is shown, user click on late -> should not show RatingBanner anymore for 7 days',
    (widgetTester) async {
      await widgetTester.pumpPage(
        userState: UserState(
          user: User.authenticated(
            id: '1',
            email: 'user@email.com',
            name: 'user name',
            onboarded: true,
            creationDate: DateTime.now().subtract(const Duration(days: 4)),
          ),
        ),
        home: const Scaffold(
          body: RateBanner(
            delayBeforeAsking: Duration(days: 3),
            delayBeforeAskingAgain: Duration(days: 7),
          ),
        ),
      );
      expect(find.byType(RateBannerWidget), findsOneWidget);
      final laterButton = find.byKey(const ValueKey('later_button'));
      expect(laterButton, findsOneWidget);
      await widgetTester.tap(laterButton);
      await widgetTester.pumpAndSettle();
      expect(find.byType(RateBannerWidget), findsNothing);
    },
  );

  testWidgets(
    'rating banner is shown, user click on open store listing -> should not show RatingBanner anymore (never)',
    (widgetTester) async {
      await widgetTester.pumpPage(
        userState: UserState(
          user: User.authenticated(
            id: '1',
            email: 'user@email.com',
            name: 'user name',
            onboarded: true,
            creationDate: DateTime.now().subtract(const Duration(days: 4)),
          ),
        ),
        home: const Scaffold(
          body: RateBanner(
            delayBeforeAsking: Duration(days: 3),
            delayBeforeAskingAgain: Duration(days: 7),
          ),
        ),
      );
      expect(find.byType(RateBannerWidget), findsOneWidget);
      // tap on open store listing
      final positivBtn = find.byKey(const ValueKey('positive_button'));
      expect(positivBtn, findsOneWidget);
      await widgetTester.tap(positivBtn);
      await widgetTester.pumpAndSettle();
      // shoud not show anymore
      expect(find.byType(RateBannerWidget), findsNothing);
    },
  );
}
