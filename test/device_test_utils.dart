import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';

const iphone8Plus = Device(
  name: 'iPhone 8 Plus',
  width: 414,
  height: 736,
  pixelDensity: 3,
);
const iphone11Pro = Device(
  name: 'iPhone 11 Pro',
  width: 375,
  height: 812,
  pixelDensity: 3,
);
const iphone15ProMax = Device(
  name: 'iPhone 15 Pro Max',
  width: 428,
  height: 926,
  pixelDensity: 3,
);
const googlePixel4 = Device(
  name: 'Google Pixel 4',
  width: 393,
  height: 851,
  pixelDensity: 2.7,
);
const googlePixel7 = Device(
  name: 'Google Pixel 7',
  width: 411,
  height: 823,
  pixelDensity: 3.5,
);
const desktopDeviceSpec = Device(
  name: 'Desktop',
  width: 1400,
  height: 900,
  pixelDensity: 1,
);

final deviceVariants = ValueVariant<Device>({
  iphone8Plus,
  iphone11Pro,
  iphone15ProMax,
  googlePixel4,
  googlePixel7,
});

/// A device to use in tests
class Device {
  final String name;
  final double width;
  final double height;
  final double pixelDensity;

  const Device({
    required this.name,
    required this.width,
    required this.height,
    required this.pixelDensity,
  });

  @override
  String toString() {
    return 'Device(name: $name, width: $width, height: $height, pixelDensity: $pixelDensity)';
  }
}

/// Use this extension to set the screen size of the device in tests
/// This allows to test the UI on different devices and check for some overflow
///
/// example:
/// ```dart
/// testWidgets('should show the page', (tester) async {
///   await tester.setScreenSize(iphone8Plus);
///   await tester.pumpWidget(MyApp());
///   expect(find.byType(MyPage), findsOneWidget);
/// });
/// ```
extension ScreenSize on WidgetTester {
  Future<void> setScreenSize(Device device) => _setScreenSize(
        width: device.width,
        height: device.height,
        pixelDensity: device.pixelDensity,
      );

  Future<void> _setScreenSize({
    double width = 450,
    double height = 800,
    double pixelDensity = 1,
  }) async {
    final size = Size(width, height);
    await binding.setSurfaceSize(size);
    view.physicalSize = size;
    view.devicePixelRatio = pixelDensity;
  }
}
