import 'dart:ui';
import 'package:google_ml_kit/google_ml_kit.dart';

///Calculates the absolute side length of a single barcode
double calculateAverageBarcodeDiagonalLength(Barcode barcode) {
  var cornerPoints = barcode.cornerPoints;
  List<Offset> offsetPoints = <Offset>[];
  if (cornerPoints != null) {
    for (var point in cornerPoints) {
      double x = point.x.toDouble();
      double y = point.y.toDouble();
      offsetPoints.add(Offset(x, y));
    }
  }

  double diagonal1 = (offsetPoints[0] - offsetPoints[2]).distance;
  double diagonal2 = (offsetPoints[1] - offsetPoints[3]).distance;

  return (diagonal1 + diagonal2) / 2;
}

///Calculates the OnImage center point of the barcode given the barcode and inputImageData
Offset calculateBarcodeCenterPoint(Barcode barcode) {
  final barcodeCentreX =
      (barcode.boundingBox!.left + barcode.boundingBox!.right) / 2;
  final barcodeCentreY =
      (barcode.boundingBox!.top + barcode.boundingBox!.bottom) / 2;

  final Offset centerOffset = Offset(barcodeCentreX, barcodeCentreY);

  return centerOffset;
}
