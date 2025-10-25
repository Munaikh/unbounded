import 'dart:typed_data';

import 'package:image/image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:universal_io/io.dart';

extension ImageToJpeg on XFile {
  Future<Uint8List> toJpeg(int maxWidth, int quality) async {
    final bytes = await readAsBytes();
    final Image? image = decodeImage(bytes);
    final thumbnail = copyResize(image!, width: maxWidth);
    // EncodeJpg is not supported on flutter test
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      return thumbnail.getBytes();
    }
    return encodeJpg(thumbnail, quality: quality);
  }
}

/// this class allows to pass parameters to the isolate
class JpegParams {
  /// the image to resize
  final Uint8List data;

  /// the maximum width of the image to resize
  final int maxWidth;

  /// 0-100 (80 is recommended)
  final int quality;

  JpegParams({
    required this.data,
    required this.maxWidth,
    required this.quality,
  });
}

/// this function is executed in a separate isolate
/// to avoid blocking the UI
/// Compute is a Flutter function that allows to execute
/// a function in a separate isolate
/// https://api.flutter.dev/flutter/foundation/compute.html?ref=blog.flutter.wtf
/// -> It has to be a top level function to work
Future<Uint8List> imgToJpeg(JpegParams params) async {
  final Image? image = decodeImage(params.data);
  final thumbnail = copyResize(image!, width: params.maxWidth);
  // EncodeJpg is not supported on flutter test
  if (Platform.environment.containsKey('FLUTTER_TEST')) {
    return thumbnail.getBytes();
  }
  return encodeJpg(thumbnail, quality: params.quality);
}
