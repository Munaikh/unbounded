import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class OurFilterChip extends StatelessWidget {
  final String label;
  final BuildContext context;

  const OurFilterChip({required this.label, required this.context});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: ShapeDecoration(
        shape: RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(100)),
        color: context.colors.surface,
      ),
      child: Text(
        label,
        style: context.textTheme.bodySmall?.copyWith(
          color: context.colors.onSurface,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
