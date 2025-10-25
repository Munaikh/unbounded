import 'package:apparence_kit/core/widgets/buttons/pressable_scale.dart';
import 'package:apparence_kit/core/widgets/utils/feedback_utils.dart';
import 'package:flutter/material.dart';

class PressableMaterial extends StatefulWidget {
  final Color color;
  final Color? pressedColor;
  final ShapeBorder? shape;
  final BorderRadius? borderRadius;
  final double? elevation;
  final Color? shadowColor;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final InteractiveInkFeatureFactory? splashFactory;
  final Color? highlightColor;
  final Clip clipBehavior;
  final Widget child;
  final double scaleTo;
  final Duration duration;
  final Curve curve;
  final bool? enabled;
  final bool scaleOnlyOnSelfTap;
  final bool? enableHapticFeedback;

  const PressableMaterial({
    super.key,
    required this.color,
    this.pressedColor,
    this.shape,
    this.borderRadius,
    this.elevation,
    this.shadowColor,
    this.onTap,
    this.onLongPress,
    this.splashFactory,
    this.highlightColor,
    this.clipBehavior = Clip.antiAlias,
    required this.child,
    this.scaleTo = 0.98,
    this.duration = const Duration(milliseconds: 150),
    this.curve = Curves.easeOutCubic,
    this.enabled,
    this.scaleOnlyOnSelfTap = false,
    this.enableHapticFeedback,
  });

  @override
  State<PressableMaterial> createState() => _PressableMaterialState();
}

class _PressableMaterialState extends State<PressableMaterial>
    with SingleTickerProviderStateMixin {
  bool _inkHighlighted = false;

  @override
  Widget build(BuildContext context) {
    final bool effectiveEnabled =
        widget.enabled ?? (widget.onTap != null || widget.onLongPress != null);

    if (widget.scaleOnlyOnSelfTap) {
      // Scale only when this InkWell is actually pressed (i.e., wins the gesture)
      final child = Material(
        color: _inkHighlighted && effectiveEnabled
            ? (widget.pressedColor ?? widget.color)
            : widget.color,
        shape: widget.shape,
        borderRadius: widget.borderRadius,
        clipBehavior: widget.clipBehavior,
        elevation: widget.elevation ?? 0,
        shadowColor: widget.shadowColor,
        child: InkWell(
          splashFactory: widget.splashFactory ?? NoSplash.splashFactory,
          highlightColor: widget.highlightColor ?? Colors.transparent,
          onTap:() {
            if (widget.enableHapticFeedback == true) {
              FeedbackUtils.selection();
            }
            widget.onTap?.call();
          },
          onLongPress: widget.onLongPress,
          onHighlightChanged: (v) {
            if (!effectiveEnabled) return;
            if (v == _inkHighlighted) return;
            setState(() => _inkHighlighted = v);
          },
          child: widget.child,
        ),
      );

      return AnimatedScale(
        scale: _inkHighlighted ? widget.scaleTo : 1.0,
        duration: widget.duration,
        curve: widget.curve,
        child: child,
      );
    }

    // Default behavior: scale on any pointer within this subtree
    return PressableScale(
      enabled: effectiveEnabled,
      scaleTo: widget.scaleTo,
      duration: widget.duration,
      curve: widget.curve,
      builder: (ctx, isPressed, child) => Material(
        color: isPressed && effectiveEnabled
            ? (widget.pressedColor ?? widget.color)
            : widget.color,
        shape: widget.shape,
        borderRadius: widget.borderRadius,
        clipBehavior: widget.clipBehavior,
        elevation: widget.elevation ?? 0,
        shadowColor: widget.shadowColor,
        child: InkWell(
          splashFactory: widget.splashFactory ?? NoSplash.splashFactory,
          highlightColor: widget.highlightColor ?? Colors.transparent,
          onTap: widget.onTap,
          onLongPress: widget.onLongPress,
          child: widget.child,
        ),
      ),
      child: widget.child,
    );
  }
}
