import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class OnboardingBackground extends StatelessWidget {
  final Widget child;
  final String? bgImagePath;
  final double bgImageOpacity;
  final Color? bgColor;

  const OnboardingBackground({
    super.key,
    required this.child,
    this.bgImagePath,
    this.bgColor,
    this.bgImageOpacity = .15,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        if (bgImagePath != null)
          Positioned.fill(
            child: Opacity(
              opacity: bgImageOpacity,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(bgImagePath!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        const Positioned.fill(
          child: ColoredBox(
            color: Colors.white,
          ),
        ),
        Positioned.fill(
          child: Container(
              decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                bgColor ?? context.colors.primary.withValues(alpha: .15),
                bgColor ?? context.colors.primary.withValues(alpha: 0),
              ],
              stops: const [0.0, .5],
            ),
          )),
        ),
        // Positioned(
        //   top: 120,
        //   left: 0,
        //   right: 0,
        //   child: Image.asset(
        //     'assets/images/introduction/lines.png',
        //     fit: BoxFit.cover,
        //   ),
        // ),
        Positioned.fill(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                key: const ValueKey("background"),
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: child,
              );
            },
          ),
        ),
      ],
    );
  }
}
