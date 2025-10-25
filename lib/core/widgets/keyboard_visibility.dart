import 'package:flutter/material.dart';

enum KeyboardVisibilityState { visible, hidden }

typedef OnKeyboardStateChanged = void Function(KeyboardVisibilityState state);

typedef KeyboardVisibilityBuilder = Widget Function(
  BuildContext context,
  Widget child,
  KeyboardVisibilityState state,
);

/// A widget that helps you adapt content to the current keyboard visibility.
/// It uses the Most upper View to get the current keyboard visibility.
/// A builder is provided to let you adapt the content to the current keyboard visibility.
/// It will rebuild the content when the keyboard visibility changes.
class KeyboardVisibility extends StatefulWidget {
  final Widget child;
  final OnKeyboardStateChanged? onKeyboardStateChanged;
  final KeyboardVisibilityBuilder? builder;

  const KeyboardVisibility({
    super.key,
    required this.child,
    this.onKeyboardStateChanged,
    this.builder,
  });

  @override
  State<KeyboardVisibility> createState() => _KeyboardVisibilityState();
}

class _KeyboardVisibilityState extends State<KeyboardVisibility>
    with WidgetsBindingObserver {
  KeyboardVisibilityState? _state;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    checkState();
  }

  void checkState() {
    final value = WidgetsBinding
        .instance.platformDispatcher.views.first.viewInsets.bottom;
    switch (value != 0.0) {
      case true:
        widget.onKeyboardStateChanged?.call(KeyboardVisibilityState.visible);
        setState(() => _state = KeyboardVisibilityState.visible);
      case false:
        widget.onKeyboardStateChanged?.call(KeyboardVisibilityState.hidden);
        setState(() => _state = KeyboardVisibilityState.hidden);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.builder != null && _state != null) {
      return widget.builder!(context, widget.child, _state!);
    }
    return widget.child;
  }
}
