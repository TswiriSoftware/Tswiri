import 'package:flutter/widgets.dart';
import 'package:flutter_google_ml_kit/VisionDetectorViews/painters/coordinates_translator.dart';
import 'package:flutter_google_ml_kit/objects/barcode_positional_data.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

///This calculates the barcode screen data:
BarcodeOnScreenData calculateScreenBarcodeData({
  required Barcode barcode,
  required InputImageRotation rotation,
  required Size size,
  required Size absoluteImageSize,
}) {
  var cornerPoints = barcode.value.cornerPoints;

  List<Offset> offsetPoints = <Offset>[];
  for (var point in cornerPoints!) {
    double x =
        translateX(point.x.toDouble(), rotation, size, absoluteImageSize);
    double y =
        translateY(point.y.toDouble(), rotation, size, absoluteImageSize);

    offsetPoints.add(Offset(x, y));
  }

  offsetPoints.add(offsetPoints.first);

  //Calculate barcode on screen center.
  final Offset barcodeCenter = calculateCenterFromCornerPoints(offsetPoints);
  //BarcodeID.
  final String displayValue = barcode.value.displayValue!;

  //Calculate the barcodes on screen size.
  double diagonal1 = (offsetPoints[0] - offsetPoints[2]).distance;
  double diagonal2 = (offsetPoints[1] - offsetPoints[3]).distance;

  final double barcodeSizeOnScreenUnits = (diagonal1 + diagonal2) / 2;

  return BarcodeOnScreenData(
      displayValue: displayValue,
      center: barcodeCenter,
      barcodeOnScreenUnits: barcodeSizeOnScreenUnits,
      cornerPoints: offsetPoints);
}

Offset calculateCenterFromCornerPoints(List<Offset> offsetPoints) {
  return (offsetPoints[0] +
          offsetPoints[1] +
          offsetPoints[2] +
          offsetPoints[3]) /
      4;
}
