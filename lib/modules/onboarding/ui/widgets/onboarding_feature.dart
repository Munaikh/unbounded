import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:apparence_kit/core/widgets/responsive_layout.dart';
import 'package:apparence_kit/modules/onboarding/ui/widgets/onboarding_background.dart';
import 'package:apparence_kit/modules/onboarding/ui/widgets/onboarding_progress.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// A generic onboarding step widget with text and image.
class OnboardingStep extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;
  final String imgPath;
  final String description;
  final String btnText;
  final String nextRoute;
  final VoidCallback? onNext;
  final double progress;
  final double? imgWPadding;
  final Widget? image;
  final bool withBg;

  const OnboardingStep({
    super.key,
    this.title,
    this.titleWidget,
    required this.imgPath,
    required this.description,
    required this.btnText,
    required this.nextRoute,
    required this.progress,
    this.imgWPadding,
    this.onNext,
    this.withBg = false,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    final content = ResponsiveLayout(
      // medium: OnboardingStepLarge(
      //   title: title,
      //   imgPath: imgPath,
      //   description: description,
      //   btnText: btnText,
      //   nextRoute: nextRoute,
      //   onNext: onNext,
      //   progress: progress,
      // ),
      small: ColoredBox(
        color: withBg == true ? Colors.transparent : const Color(0xFFFAF9FD),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OnboardingProgress(value: progress),
              Flexible(
                flex: 0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(32, 28, 32, 0),
                  child: Animate(
                    effects: const [
                      FadeEffect(
                        delay: Duration(milliseconds: 200),
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeIn,
                      ),
                      MoveEffect(
                        delay: Duration(milliseconds: 200),
                        duration: Duration(milliseconds: 450),
                        curve: Curves.easeOut,
                        begin: Offset(0, 50),
                        end: Offset.zero,
                      ),
                    ],
                    child: title != null
                        ? Text(
                            title!,
                            textAlign: TextAlign.center,
                            style: context.textTheme.headlineMedium?.copyWith(),
                          )
                        : titleWidget!,
                  ),
                ),
              ),
              Flexible(
                flex: 0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(32, 12, 32, 0),
                  child: Animate(
                    effects: const [
                      FadeEffect(
                        delay: Duration(milliseconds: 300),
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeIn,
                      ),
                      MoveEffect(
                        delay: Duration(milliseconds: 300),
                        duration: Duration(milliseconds: 450),
                        curve: Curves.easeOut,
                        begin: Offset(0, 50),
                        end: Offset.zero,
                      ),
                    ],
                    child: Text(
                      description,
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: context.colors.onBackground.withOpacity(.6),
                        // height: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              if (image != null) Expanded(flex: 4, child: image!),
              if (image == null && imgPath.isNotEmpty)
                Expanded(
                  flex: 4,
                  child: Animate(
                    effects: const [
                      FadeEffect(
                        delay: Duration(milliseconds: 100),
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeIn,
                      ),
                      MoveEffect(
                        delay: Duration(milliseconds: 100),
                        duration: Duration(milliseconds: 450),
                        curve: Curves.easeOut,
                        begin: Offset(0, 50),
                        end: Offset.zero,
                      ),
                    ],
                    child: Image.asset(
                      imgPath,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Animate(
                  effects: const [
                    FadeEffect(
                      delay: Duration(milliseconds: 400),
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeIn,
                    ),
                    MoveEffect(
                      delay: Duration(milliseconds: 400),
                      duration: Duration(milliseconds: 450),
                      curve: Curves.easeOut,
                      begin: Offset(0, 50),
                      end: Offset.zero,
                    ),
                  ],
                  child: ElevatedButton(
                    onPressed: () {
                      if (onNext != null) {
                        onNext!.call();
                      } else {
                        Navigator.of(context).pushReplacementNamed(nextRoute);
                      }
                    },
                    child: Text(btnText),
                  ),
                ),
              ),
              if (defaultTargetPlatform == TargetPlatform.android)
                const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
    return withBg == true ? OnboardingBackground(child: content) : content;
  }
}
