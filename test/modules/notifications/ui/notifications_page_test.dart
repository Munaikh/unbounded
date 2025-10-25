import 'package:apparence_kit/core/data/models/user.dart';
import 'package:apparence_kit/core/states/models/user_state.dart';
import 'package:apparence_kit/modules/notifications/ui/components/notification_tile.dart';
import 'package:apparence_kit/modules/notifications/ui/notifications_page.dart';
import 'package:apparence_kit/modules/notifications/ui/widgets/notification_tile.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_utils.dart';

void main() {
  group('User is connected', () {
    testWidgets(
      'Load notifications => should show 20 notifications',
      (tester) async {
        await tester.pumpPage(
          userState: UserState(
            user: User.authenticated(
              id: '1',
              email: 'user@email.com',
              name: 'user name',
              onboarded: true,
              creationDate: DateTime.now().subtract(const Duration(days: 4)),
            ),
          ),
          home: NotificationsPage(),
        );
        await tester.pump(const Duration(seconds: 3));
        await tester.pumpAndSettle();
        expect(find.byType(NotificationsPage), findsOneWidget);
        expect(find.text("Notifications"), findsOneWidget);
        expect(find.byType(NotificationTile), findsAtLeastNWidgets(3));
      },
    );

    testWidgets(
      'Load notifications, wait 3 seconds => all notifications are now read',
      (tester) async {
        await tester.pumpPage(
          userState: UserState(
            user: User.authenticated(
              id: '1',
              email: 'user@email.com',
              name: 'user name',
              onboarded: true,
              creationDate: DateTime.now().subtract(const Duration(days: 4)),
            ),
          ),
          home: NotificationsPage(),
        );
        var firstNotification = tester.firstWidget<NotificationTileComponent>(
          find.byType(NotificationTileComponent),
        );
        expect(firstNotification.notification.readAt, isNull);

        await tester.pump(const Duration(seconds: 3));
        await tester.pumpAndSettle();
        firstNotification = tester.firstWidget<NotificationTileComponent>(
          find.byType(NotificationTileComponent),
        );

        expect(
          firstNotification.notification.readAt,
          isNotNull,
          reason: "All notifications should be read after 3 seconds",
        );
      },
    );
  });
}
