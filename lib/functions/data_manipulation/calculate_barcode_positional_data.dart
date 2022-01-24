import 'package:flutter/widgets.dart';
import 'package:flutter_google_ml_kit/VisionDetectorViews/painters/coordinates_translator.dart';
import 'package:flutter_google_ml_kit/objects/barcode_positional_data.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

BarcodePositionalData calculateBarcodePositionalData(Barcode barcode,
    InputImageRotation rotation, Size size, Size absoluteImageSize) {
  final boundingBoxLeft = translateX(
      barcode.value.boundingBox!.left, rotation, size, absoluteImageSize);
  final boundingBoxTop = translateY(
      barcode.value.boundingBox!.top, rotation, size, absoluteImageSize);
  final boundingBoxRight = translateX(
      barcode.value.boundingBox!.right, rotation, size, absoluteImageSize);
  final boundingBoxBottom = translateY(
      barcode.value.boundingBox!.bottom, rotation, size, absoluteImageSize);

  final barcodeCentreX = (boundingBoxLeft + boundingBoxRight) / 2;
  final barcodeCentreY = (boundingBoxTop + boundingBoxBottom) / 2;

  double barcodePixelSize = ((barcode.value.boundingBox!.left -
                  barcode.value.boundingBox!.right)
              .abs() +
          (barcode.value.boundingBox!.top - barcode.value.boundingBox!.bottom)
              .abs()) /
      2;

  final Offset center = Offset(barcodeCentreX, barcodeCentreY);
  final Offset topLeft = Offset(boundingBoxLeft, boundingBoxTop);
  final Offset topRight = Offset(boundingBoxRight, boundingBoxTop);
  final Offset bottomLeft = Offset(boundingBoxLeft, boundingBoxBottom);
  final Offset bottomRight = Offset(boundingBoxRight, boundingBoxBottom);

  return BarcodePositionalData(
      topRight: topRight,
      topLeft: topLeft,
      bottomRight: bottomRight,
      bottomLeft: bottomLeft,
      center: center,
      barcodePixelSize: barcodePixelSize);
}
