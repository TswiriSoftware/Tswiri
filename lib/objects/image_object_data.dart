import 'dart:ui';

import 'package:google_ml_kit/google_ml_kit.dart';

///1. This object will be passed to the painter
///2. This object should also be used to create tags so that the user can easily add them to the barcode.
///3.
///It contains Lists of objects detected etc...
///It also contains the Image configuration.
class ImageObjectData {
  ImageObjectData({
    required this.detectedObjects,
    required this.detectedLabels,
    required this.detectedText,
    required this.imageRotation,
    required this.size,
  });

  ///List of detected Objects.
  final List<DetectedObject> detectedObjects;

  ///List of detected labels.
  final List<ImageLabel> detectedLabels;

  ///List of detected Text.
  final RecognisedText detectedText;

  ///Image rotation.
  final InputImageRotation imageRotation;

  //Image Size.
  final Size size;

  @override
  String toString() {
    return 'List of detected Objects: $detectedObjects,\n ImageRotation: $imageRotation,\n ImageSize: $size ';
  }
}
