import 'package:flutter/widgets.dart';

enum DeviceType {
  small(0),
  medium(768),
  large(1024),
  xlarge(1280);

  final int breakpoint;

  const DeviceType(this.breakpoint);

  static DeviceType fromWidth(double width) {
    return switch (width) {
      < 768 => DeviceType.small,
      < 1024 => DeviceType.medium,
      < 1280 => DeviceType.large,
      _ => DeviceType.xlarge,
    };
  }
}

/// A widget that adapts its content to the current device type.
/// It uses the [LayoutBuilder] widget to get the current device width
/// and returns the widget that matches the current device type.
/// Breakpoints are:
/// - small: < 768
/// - medium: >= 768
/// - large: >= 1024
/// - xlarge: >= 1280
/// It's designed as mobile first meaning that if you don't provide a widget
/// for a specific device type, it will fallback to the previous one. (the small widget is required)
class ResponsiveLayout extends StatelessWidget {
  final Widget small;
  final Widget? medium;
  final Widget? large;
  final Widget? xlarge;

  const ResponsiveLayout({
    super.key,
    required this.small,
    this.medium,
    this.large,
    this.xlarge,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        switch (getDeviceType(constraints)) {
          case DeviceType.small:
            return small;
          case DeviceType.medium:
            return medium ?? small;
          case DeviceType.large:
            return large ?? medium ?? small;
          case DeviceType.xlarge:
            return xlarge ?? large ?? medium ?? small;
        }
      },
    );
  }

  DeviceType getDeviceType(BoxConstraints constraints) {
    return switch (constraints.maxWidth) {
      > 1280 => DeviceType.xlarge,
      > 1024 => DeviceType.large,
      > 768 => DeviceType.medium,
      _ => DeviceType.small,
    };
  }
}

/// A widget that adapts its content to the current device type.
/// It uses the Most upper widget to get the current device width
/// and returns the widget that matches the current device type.
/// Use this when you want just some parts of the page to be adapted to the device type.
///
/// Breakpoints are:
/// - small: < 768
/// - medium: >= 768
/// - large: >= 1024
/// - xlarge: >= 1280
/// It's designed as mobile first meaning that if you don't provide a widget
/// for a specific device type, it will fallback to the previous one. (the small widget is required)
class ResponsiveBuilder extends StatelessWidget {
  final Widget small;
  final Widget? medium;
  final Widget? large;
  final Widget? xlarge;

  const ResponsiveBuilder({
    super.key,
    required this.small,
    this.medium,
    this.large,
    this.xlarge,
  });

  @override
  Widget build(BuildContext context) {
    return DeviceSizeBuilder(
      builder: (device) => switch (device) {
        DeviceType.small => small,
        DeviceType.medium => medium ?? small,
        DeviceType.large => large ?? medium ?? small,
        DeviceType.xlarge => xlarge ?? large ?? medium ?? small,
      },
    );
  }
}

// ------------------------------------------------------
// -- DeviceSizeBuilder
// ------------------------------------------------------

typedef DeviceTypeBuilder = Widget Function(DeviceType);

/// A widget that helps you adapt  content to the current device type.
/// It uses the Most upper View to get the current device width
/// A builder is provided to let you adapt the content to the current device type.
/// It will rebuild the content when the device type changes.
class DeviceSizeBuilder extends StatefulWidget {
  final DeviceTypeBuilder builder;

  const DeviceSizeBuilder({
    super.key,
    required this.builder,
  });

  @override
  State<DeviceSizeBuilder> createState() => _DeviceSizeBuilderState();
}

class _DeviceSizeBuilderState extends State<DeviceSizeBuilder>
    with WidgetsBindingObserver {
  late DeviceType _lastSize;
  WidgetsBinding get widgetBinding => WidgetsBinding.instance;

  @override
  void initState() {
    super.initState();
    widgetBinding.addObserver(this);
  }

  @override
  void dispose() {
    widgetBinding.removeObserver(this);
    super.dispose();
  }

  // detect the viewport width
  // I don't use View.of(context).physicalSize.width;
  // because it returns the complete screen width on Web
  double get viewportWidth => MediaQuery.of(context).size.width;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _lastSize = DeviceType.fromWidth(viewportWidth);
  }

  @override
  void didChangeMetrics() {
    final newSize = DeviceType.fromWidth(viewportWidth);
    if (_lastSize != newSize) {
      _lastSize = newSize;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(_lastSize);
  }
}

/// The maximum width for large devices.
const kMaxLargeLayoutWidth = 650.0;

/// A widget that constrains its child to a maximum width on large devices.
/// It uses the [LayoutBuilder] widget to get the current device width
/// and constrains the child to the maximum width on large devices.
/// the content will be centered on the screen.
class LargeLayoutContainer extends StatelessWidget {
  final Widget child;
  final double? maxWidth;

  const LargeLayoutContainer({
    super.key,
    required this.child,
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => DeviceSizeBuilder(
        builder: (device) => Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: switch (device) {
              DeviceType.small => constraints,
              _ => BoxConstraints(
                  maxWidth: maxWidth ?? kMaxLargeLayoutWidth,
                ),
            },
            child: child,
          ),
        ),
      ),
    );
  }
}