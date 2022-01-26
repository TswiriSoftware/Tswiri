import 'package:flutter/widgets.dart';
import 'package:flutter_google_ml_kit/VisionDetectorViews/painters/coordinates_translator.dart';
import 'package:flutter_google_ml_kit/objects/barcode_positional_data.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

///This
BarcodeScreenData calculateScreenBarcodeData(Barcode barcode,
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
  final String displayValue = barcode.value.displayValue!;
  Rect boundingBox = Rect.fromLTRB(
      boundingBoxLeft, boundingBoxTop, boundingBoxRight, boundingBoxBottom);

  return BarcodeScreenData(
      displayValue: displayValue,
      center: center,
      absoluteBarcodeSize: barcodePixelSize,
      boundingBox: boundingBox);
}
