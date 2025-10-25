import 'package:animations/animations.dart';
import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:flutter/cupertino.dart';

class OnboardingRouteTransition extends CupertinoPageRoute {
  OnboardingRouteTransition({
    required super.builder,
    super.settings,
  });

  // OPTIONAL IF YOU WISH TO HAVE SOME EXTRA ANIMATION WHILE ROUTING
  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // return FadeTransition(
    //   opacity: animation,
    //   child: builder(context),
    // );
    return SharedAxisTransition(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      transitionType: SharedAxisTransitionType.horizontal,
      fillColor: context.colors.background,
      child: builder(context),
    );
  }
}
