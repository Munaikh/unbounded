import 'package:animations/animations.dart';
import 'package:apparence_kit/core/bottom_menu/bottom_menu_item.dart';
import 'package:apparence_kit/modules/home/home_page.dart';
import 'package:bart/bart.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

List<BartMenuRoute> subRoutes() {
  return [
    BartMenuRoute.bottomBarBuilder(
      label: "Home",
      path: 'home',
      builder:
          (context, isActive) => BottomMenuItem(
            isSelected: isActive,
            icon: Ionicons.home,
            iconOutline: Ionicons.home_outline,
            label: "Home",
          ),
      pageBuilder: (_, _, settings) => const HomePage(),
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
