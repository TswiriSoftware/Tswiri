import 'dart:ui';

import 'package:google_ml_kit/google_ml_kit.dart';

class ImageProcessorConfig {
  ImageProcessorConfig({
    required this.absoluteSize,
    required this.canvasSize,
    required this.inputImageFormat,
  });
  Size absoluteSize;
  Size canvasSize;
  InputImageFormat inputImageFormat;

  List toMessage() {
    return [
      'ImageProcessorConfig', // [0]
      [
        absoluteSize.width, //[1][0]
        absoluteSize.height, //[1][1]
      ], //Absolute size [1]
      [
        canvasSize.width, //[2][0]
        canvasSize.height, //[2][1]
      ], //Canvas size [2]
      inputImageFormat.index, //InputImageFormat [3]
    ];
  }

  factory ImageProcessorConfig.fromMessage(message) {
    return ImageProcessorConfig(
      absoluteSize: Size(message[1][0] as double, message[1][1] as double),
      canvasSize: Size(message[2][0] as double, message[2][1] as double),
      inputImageFormat: InputImageFormat.values.elementAt(message[3] as int),
    );
  }
}
