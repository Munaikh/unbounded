import 'dart:math' as math;
import 'package:flutter/material.dart';

class RoundProgress extends StatefulWidget {
  final double radius;
  final double? progress;
  final Color color;
  final Widget? child;
  final double strokeWidth;

  const RoundProgress({
    super.key,
    required this.radius,
    required this.color,
    this.progress,
    this.child,
    this.strokeWidth = 4.0,
  });

  @override
  _RoundProgressState createState() => _RoundProgressState();
}

class _RoundProgressState extends State<RoundProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    if (widget.progress != null) {
      _initController(
        duration: const Duration(milliseconds: 250),
      );
    } else {
      _initController(
        duration: const Duration(milliseconds: 500),
        repeat: true,
      );
    }
    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.decelerate),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant RoundProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.progress != null &&
        oldWidget.progress != null &&
        oldWidget.progress != widget.progress) {
      _animation = Tween(
        begin: oldWidget.progress,
        end: widget.progress,
      ).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeIn),
      );
      _controller.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) => CustomPaint(
        size: Size(widget.radius * 2, widget.radius * 2),
        painter: _RoundProgressPainter(
          radius: widget.radius,
          progress: widget.progress ?? _controller.value,
          color: widget.color,
          animation: _animation,
          strokeWidth: widget.strokeWidth,
        ),
        child: widget.child,
      ),
    );
  }

  void _initController({
    required Duration duration,
    bool repeat = false,
  }) {
    _controller = AnimationController(
      vsync: this,
      duration: duration,
    );
    if (repeat) {
      _controller.repeat();
    }
  }
}

class _RoundProgressPainter extends CustomPainter {
  final double radius;
  final double progress;
  final Color color;
  final Animation<double> animation;
  final double strokeWidth;

  _RoundProgressPainter({
    required this.radius,
    required this.progress,
    required this.color,
    required this.animation,
    required this.strokeWidth,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final strokeWidth = radius / 10;
    final progressAngle = math.pi * 2 * progress;
    final progressPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(
      center,
      radius - strokeWidth / 2,
      Paint()
        ..color = color.withValues(alpha: 0.1)
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      progressAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_RoundProgressPainter oldDelegate) =>
      progress != oldDelegate.progress || color != oldDelegate.color;
}
