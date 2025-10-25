import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CheckedReassurance extends StatelessWidget {
  final String text;

  const CheckedReassurance({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: const [
        FadeEffect(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        ),
        MoveEffect(
          duration: Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          begin: Offset(0, -20),
          end: Offset.zero,
        ),
      ],
      child: Container(
        padding: const EdgeInsets.all(21),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FFF5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: context.colors.grey3,
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.left,
          style: context.textTheme.bodyLarge?.copyWith(
            color: context.colors.grey3,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
