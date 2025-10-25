import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  final String? bgImagePath;
  final String? bgOverlayImagePath;
  final Color? bgColor;

  const Background({
    super.key,
    required this.child,
    this.bgOverlayImagePath,
    this.bgImagePath,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Positioned.fill(
          child: Container(
            color: bgColor ?? context.colors.background,
          ),
        ),
        if (bgImagePath != null)
          Positioned.fill(
            child: Opacity(
              opacity: .15,
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
        if (bgOverlayImagePath != null)
          Positioned.fill(
            child: Opacity(
              opacity: .10,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(bgOverlayImagePath!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
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
