import 'package:apparence_kit/core/bottom_menu/bottom_router.dart';
import 'package:apparence_kit/core/bottom_menu/custom_bottom_bar.dart';
import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:apparence_kit/core/widgets/responsive_layout.dart';
import 'package:bart/bart.dart' as bart;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// This bottom menu is powered by Bart packages
/// https://pub.dev/packages/bart
/// It allows you to create a bottom menu with a router and handle
/// all tabs navigation separately.
/// See the bottom_router.dart file to add tabs or subpages to show on tabs
class BottomMenu extends ConsumerWidget {
  final String? initialRoute;

  const BottomMenu({super.key, this.initialRoute});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // Determine appropriate status bar style.
    const overlayStyle =
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
        );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: ColoredBox(
        color: context.colors.background,
        child: AnimatedScale(
          scale: 1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              0,
            ),
            child: ResponsiveLayout(
              small: bart.BartScaffold(
                routesBuilder: subRoutes,
                bottomBar: bart.BartBottomBar.custom(
                        bottomBarFactory: CustomBottomBar(),
                      ),
                initialRoute: initialRoute,
                scaffoldOptions: bart.ScaffoldOptions(
                  extendBody: true,
                  backgroundColor: context.colors.background,
                ),
                onRouteChanged: (route) {
                  // If you want to log tab events to analytics
                  // MixpanelAnalyticsApi.instance().logEvent('home/$route', {});
                },
              ),
              // medium: bart.BartScaffold(
              //   routesBuilder: subRoutes,
              //   bottomBar: bart.BartBottomBar.custom(
              //     bottomBarFactory: CustomBottomBar(),
              //   ),
              //   initialRoute: initialRoute,
              //   scaffoldOptions: bart.ScaffoldOptions(
              //     extendBody: true,
              //     backgroundColor: context.colors.background,
              //   ),
              //   sideBarOptions: bart.RailSideBarOptions(extended: true),
              // ),
            ),
          ),
        ),
      ),
    );
  }
}
