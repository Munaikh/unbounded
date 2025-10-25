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
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSelected ? icon : iconOutline,
            color:
                isSelected ? context.colors.primary : context.colors.neutral300,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: context.textTheme.labelMedium?.copyWith(
              color:
                  isSelected
                      ? context.colors.primary
                      : context.colors.neutral300,
            ),
          ),
        ],
    );
  }
}
