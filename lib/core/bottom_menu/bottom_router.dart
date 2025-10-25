import 'package:animations/animations.dart';
import 'package:apparence_kit/core/bottom_menu/notification_bottom_item.dart';
import 'package:apparence_kit/core/rating/widgets/rate_banner.dart';
import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:apparence_kit/modules/home/home_page.dart';
import 'package:apparence_kit/modules/notifications/ui/notifications_page.dart';
import 'package:apparence_kit/modules/settings/settings_page.dart';
import 'package:bart/bart.dart';
import 'package:flutter/material.dart';

List<BartMenuRoute> subRoutes() {
  return [
    BartMenuRoute.bottomBar(
      label: "Home",
      icon: Icons.home,
      path: 'home',
      pageBuilder: (_, _, settings) => const HomePage(),
      transitionDuration: bottomBarTransitionDuration,
      transitionsBuilder: bottomBarTransition,
    ),
    BartMenuRoute.bottomBar(
      label: "My wishlist",
      icon: Icons.favorite,
      path: 'wishlist',
      pageBuilder: (_, _, settings) => const PageFake(),
      transitionDuration: bottomBarTransitionDuration,
      transitionsBuilder: bottomBarTransition,
    ),
    BartMenuRoute.bottomBarBuilder(
      label: "Notifications",
      builder: (_, isActive) => NotificationBottomItem(
        isActive: isActive,
      ),
      path: 'notifications',
      pageBuilder: (_, _, settings) => NotificationsPage(),
      transitionDuration: bottomBarTransitionDuration,
      transitionsBuilder: bottomBarTransition,
    ),
    BartMenuRoute.bottomBar(
      label: "Settings",
      icon: Icons.settings,
      path: 'settings',
      pageBuilder: (_, _, settings) => const SettingsPage(),
      transitionDuration: bottomBarTransitionDuration,
      transitionsBuilder: bottomBarTransition,
    ),
    BartMenuRoute.innerRoute(
      path: '/search',
      pageBuilder: (_, _, _) => const PageFake(),
    ),
    BartMenuRoute.innerRoute(
      path: '/search/subscribe',
      pageBuilder: (_, _, _) => const PageFake(),
    ),
  ];
}

/// This is a fake page to show how to use Bart
/// You can replace it with your own pages
class PageFake extends StatelessWidget {
  final Color? color;

  const PageFake({this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // ignore: use_colored_box
      child: Container(
        color: color ?? context.colors.background,
        child: const Column(
          children: [
            RateBanner(forceInDebug: true),
            SizedBox(
              height: 100,
            ),
            Opacity(
              opacity: 0.5,
              child: Text("This is a fake page"),
            ),
          ],
        ),
      ),
    );
  }
}

Widget bottomBarTransition(
  BuildContext c,
  Animation<double> a1,
  Animation<double> a2,
  Widget child,
) =>
    FadeThroughTransition(
      animation: a1,
      secondaryAnimation: a2,
      fillColor: Colors.transparent,
      child: child,
    );

const bottomBarTransitionDuration = Duration(milliseconds: 300);
