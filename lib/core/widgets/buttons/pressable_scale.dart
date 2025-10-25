import 'package:flutter/material.dart';

typedef PressableScaleBuilder = Widget Function(BuildContext context, bool isPressed, Widget child);

class PressableScale extends StatefulWidget {
  final double scaleTo;
  final Duration duration;
  final Curve curve;
  final Widget child;
  final PressableScaleBuilder? builder;
  final bool enabled;

  const PressableScale({
    super.key,
    this.scaleTo = 0.98,
    this.duration = const Duration(milliseconds: 150),
    this.curve = Curves.easeOutCubic,
    required this.child,
    this.builder,
    this.enabled = true,
  });

  @override
  State<PressableScale> createState() => _PressableScaleState();
}

class _PressableScaleState extends State<PressableScale> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: widget.duration,
    vsync: this,
  );
  late Animation<double> _scale;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _scale = Tween<double>(
      begin: 1.0,
      end: widget.scaleTo,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));
  }

  @override
  void didUpdateWidget(covariant PressableScale oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration ||
        oldWidget.curve != widget.curve ||
        oldWidget.scaleTo != widget.scaleTo) {
      _controller.duration = widget.duration;
      _scale = Tween<double>(
        begin: 1.0,
        end: widget.scaleTo,
      ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _finishPressAnimation() async {
    if (!mounted) return;
    final Duration? total = _controller.duration;
    if (total != null) {
      final double progress = _controller.value;
      final int remainingMs = (total.inMilliseconds * (1.0 - progress)).round();
      if (remainingMs > 0 && mounted) {
        await _controller.animateTo(1.0, duration: Duration(milliseconds: remainingMs));
      }
    }
    if (mounted) await _controller.reverse();
    if (mounted) setState(() => _isPressed = false);
  }

  void _onPointerDown(PointerDownEvent e) {
    if (!mounted) return;
    setState(() => _isPressed = true);
    _controller.forward();
  }

  void _onPointerUp(PointerUpEvent e) {
    if (!mounted) return;
    if (_isPressed) {
      _finishPressAnimation();
    }
  }

  void _onPointerCancel(PointerCancelEvent e) {
    if (!mounted) return;
    _controller.reverse();
    setState(() => _isPressed = false);
  }

  void _onPointerMove(PointerMoveEvent e) {
    if (!mounted) return;
    final RenderBox? box = context.findRenderObject() as RenderBox?;
    if (box == null) return;
    final Offset local = box.globalToLocal(e.position);
    final bool within = box.size.contains(local);
    if (within) {
      if (!_isPressed) {
        setState(() => _isPressed = true);
        _controller.forward();
      }
    } else {
      if (_isPressed) {
        setState(() => _isPressed = false);
        _controller.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return widget.child;
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      onPointerCancel: _onPointerCancel,
      onPointerMove: _onPointerMove,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (ctx, ch) => Transform.scale(scale: _scale.value, child: ch),
        child: widget.builder != null
            ? Builder(builder: (ctx) => widget.builder!(ctx, _isPressed, widget.child))
            : widget.child,
      ),
    );
  }
}
