import 'package:apparence_kit/core/bottom_menu/bottom_router.dart';
import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:apparence_kit/core/widgets/responsive_layout.dart';
import 'package:bart/bart.dart' as bart;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// This bottom menu is powered by Bart packages
/// https://pub.dev/packages/bart
/// It allows you to create a bottom menu with a router and handle
/// all tabs navigation separately.
/// See the bottom_router.dart file to add tabs or subpages to show on tabs
class BottomMenu extends StatelessWidget {
  final String? initialRoute;

  const BottomMenu({
    super.key,
    this.initialRoute,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: ResponsiveLayout(
        small: bart.BartScaffold(
          routesBuilder: subRoutes,
          bottomBar: bart.BartBottomBar.adaptive(),
          initialRoute: initialRoute,
          scaffoldOptions: bart.ScaffoldOptions(
            backgroundColor: context.colors.background,
          ),
          onRouteChanged: (route) {
            // If you want to log tab events to analytics
            // MixpanelAnalyticsApi.instance().logEvent('home/$route', {});
          },
        ),
        medium: bart.BartScaffold(
          routesBuilder: subRoutes,
          bottomBar: bart.BartBottomBar.adaptive(),
          initialRoute: initialRoute,
          scaffoldOptions: bart.ScaffoldOptions(
            backgroundColor: context.colors.background,
          ),
          sideBarOptions: bart.RailSideBarOptions(
            extended: true,
          ),
        ),
      ),
    );
  }
}
