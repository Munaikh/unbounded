import 'package:animations/animations.dart';
import 'package:apparence_kit/core/bottom_menu/bottom_menu_item.dart';
import 'package:apparence_kit/core/widgets/page_not_found.dart';
import 'package:apparence_kit/modules/events/events_page.dart';
import 'package:apparence_kit/modules/home/home_page.dart';
import 'package:bart/bart.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

List<BartMenuRoute> subRoutes() {
  return [
    BartMenuRoute.bottomBarBuilder(
      label: "Discover",
      path: 'home',
      builder: (context, isActive) => BottomMenuItem(
        isSelected: isActive,
        icon: Ionicons.location,
        iconOutline: Ionicons.location_outline,
        label: "Discover",
      ),
      pageBuilder: (_, _, settings) => const HomePage(),
      transitionDuration: bottomBarTransitionDuration,
      transitionsBuilder: bottomBarTransition,
    ),
    BartMenuRoute.bottomBarBuilder(
      label: "Events",
      path: 'events',
      builder: (context, isActive) => BottomMenuItem(
        isSelected: isActive,
        icon: Ionicons.people,
        iconOutline: Ionicons.people_outline,
        label: "Events",
      ),
      pageBuilder: (_, _, settings) => const EventsPage(),
      transitionDuration: bottomBarTransitionDuration,
      transitionsBuilder: bottomBarTransition,
    ),
    BartMenuRoute.bottomBarBuilder(
      label: "404",
      path: '404',
      builder: (context, isActive) => BottomMenuItem(
        isSelected: isActive,
        icon: Ionicons.game_controller,
        iconOutline: Ionicons.game_controller_outline,
        label: "Society",
      ),
      pageBuilder: (_, _, settings) => const PageNotFound(),
      transitionDuration: bottomBarTransitionDuration,
      transitionsBuilder: bottomBarTransition,
    ),

    BartMenuRoute.innerRoute(
      path: '/search',
      pageBuilder: (_, _, _) => const SizedBox.shrink(),
    ),
  ];
}

Widget bottomBarTransition(
  BuildContext c,
  Animation<double> a1,
  Animation<double> a2,
  Widget child,
) => FadeThroughTransition(
  animation: a1,
  secondaryAnimation: a2,
  fillColor: Colors.transparent,
  child: child,
);

const bottomBarTransitionDuration = Duration(milliseconds: 300);
