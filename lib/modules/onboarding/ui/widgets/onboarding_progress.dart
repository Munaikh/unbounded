import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class OnboardingProgress extends StatefulWidget {
  final double value;

  const OnboardingProgress({super.key, required this.value});

  @override
  State<OnboardingProgress> createState() => _OnboardingProgressState();
}

class _OnboardingProgressState extends State<OnboardingProgress>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _setProgressValueAndStart();
  }

  @override
  void didUpdateWidget(OnboardingProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _setProgressValueAndStart();
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _setProgressValueAndStart() {
    var start = 0.0;
    if (widget.value > 0) {
      start = widget.value - 0.1;
    }
    _progressAnimation = Tween<double>(
      begin: start,
      end: widget.value,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.ease,
      ),
    );
    animationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _progressAnimation,
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(80, 16, 80, 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: LinearProgressIndicator(
              value: _progressAnimation.value,
              minHeight: 16,
              valueColor: AlwaysStoppedAnimation<Color>(
                context.colors.primary,
              ),
              backgroundColor: context.colors.primary.withOpacity(0.1),
            ),
          ),
        );
      },
    );
  }
}
