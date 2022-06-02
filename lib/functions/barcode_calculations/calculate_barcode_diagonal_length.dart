import 'dart:ui';
import 'package:google_ml_kit/google_ml_kit.dart';

///Calculates the absolute side length of a single barcode
double calculateBarcodeDiagonalLength(Barcode barcode) {
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
