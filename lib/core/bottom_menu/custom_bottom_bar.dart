import 'dart:io';
import 'dart:ui';

import 'package:apparence_kit/core/bottom_menu/bottom_menu_item.dart';
import 'package:apparence_kit/core/theme/colors.dart';
import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:apparence_kit/core/widgets/buttons/pressable_scale.dart';
import 'package:bart/bart.dart';
import 'package:bart/bart/bart_model.dart';
import 'package:bart/bart/widgets/bottom_bar/styles/bottom_bar_custom.dart';
import 'package:flutter/material.dart';

class CustomBottomBar extends BartBottomBarFactory {
  final double blur = 15;
  final double opacity = 0.7;
  final double borderRadius = 0;
  final double padding = 8;

  BottomMenuItem getBottomMenuItem(
    BuildContext context,
    List<BartMenuRoute> routes,
    int currentIndex,
  ) {
    return routes[currentIndex].iconBuilder!(context, true) as BottomMenuItem;
  }

  Widget buildDefultStyle(
    BuildContext context,
    List<BartMenuRoute> routes,
    void Function(int) onTap,
    int currentIndex,
  ) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(borderRadius),
        topRight: Radius.circular(borderRadius),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            color: context.colors.surface.withCustomOpacity(opacity),
            border: Border(
              top: BorderSide(
                color: context.colors.outline.withCustomOpacity(0.2),
                width: 1.5,
              ),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Row(
              children: [
                for (var i = 0; i < routes.length; i++)
                  Expanded(
                    child: PressableScale(
                      scaleTo: 0.95,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () => onTap(i),
                        child: routes[i].iconBuilder?.call(
                          context,
                          i == currentIndex,
                        ) ?? const SizedBox.shrink(),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAndroidStyle(
    BuildContext context,
    List<BartMenuRoute> routes,
    void Function(int) onTap,
    int currentIndex,
  ) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final base = context.textTheme.labelMedium;
          final isSelected = states.contains(WidgetState.selected);
          return base?.copyWith(
            color: isSelected
                ? context.colors.primary
                : context.colors.onSurface,
          );
        }),
      ),
      child: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: onTap,
        backgroundColor: context.colors.surface,
        indicatorColor: context.colors.primary,
        surfaceTintColor: context.colors.surface,
        destinations: [
          for (var i = 0; i < routes.length; i++)
            (() {
              final item = getBottomMenuItem(context, routes, i);
              return NavigationDestination(
                icon: Icon(item.iconOutline),
                selectedIcon: Icon(item.icon, color: context.colors.onPrimary),
                label: item.label,
              );
            })(),
        ],
      ),
    );
  }

  @override
  Widget create({
    required BuildContext context,
    required List<BartMenuRoute> routes,
    required void Function(int) onTap,
    required int currentIndex,
  }) {
    if (Platform.isAndroid) {
      return buildAndroidStyle(context, routes, onTap, currentIndex);
    } else {
      return buildDefultStyle(context, routes, onTap, currentIndex);
    }
  }
}
