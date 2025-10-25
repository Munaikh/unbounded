import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MoveFadeAnim extends StatelessWidget {
  final int? delayInMs;
  final Widget child;

  const MoveFadeAnim({
    super.key,
    required this.child,
    this.delayInMs,
  });

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        FadeEffect(
          delay: Duration(milliseconds: delayInMs ?? 0),
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeIn,
        ),
        MoveEffect(
          delay: Duration(milliseconds: delayInMs ?? 0),
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeOut,
          begin: const Offset(0, 50),
          end: Offset.zero,
        ),
      ],
      child: child,
    );
  }
}
