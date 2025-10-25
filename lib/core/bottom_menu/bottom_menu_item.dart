import 'package:apparence_kit/core/theme/colors.dart';
import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class BottomMenuItem extends StatelessWidget {
  final bool isSelected;
  final IconData icon;
  final IconData iconOutline;
  final String label;
  const BottomMenuItem({
    super.key,
    required this.isSelected,
    required this.icon,
    required this.iconOutline,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return _GlowingIcon(
      glow: isSelected,
      glowColor: context.colors.primary,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSelected ? icon : iconOutline,
            color:
                isSelected ? context.colors.primary : context.colors.neutral300,
            size: 24,
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}

class _GlowingIcon extends StatelessWidget {
  final Widget child;
  final Color glowColor;
  final bool glow;

  const _GlowingIcon({
    required this.child,
    required this.glowColor,
    this.glow = false,
  });

  @override
  Widget build(BuildContext context) {
    if (!glow) return child;

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: glowColor.withCustomOpacity(0.4),
            blurRadius: 40,
            spreadRadius: 1,
          ),
        ],
      ),
      child: child,
    );
  }
}
