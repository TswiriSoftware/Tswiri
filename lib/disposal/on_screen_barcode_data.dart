// import 'package:flutter/cupertino.dart';
// import 'package:flutter_google_ml_kit/functions/barcode_calculations/calculate_barcode_center_from_corner_points.dart';
// import 'package:flutter_google_ml_kit/functions/translating/coordinates_translator.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';

// ///Barcode Screen Data contains data related to the on screen image
// ///
// ///1. String        : displayValue
// ///
// ///2. List<Offset>  : cornerPoints
// ///
// ///3. Offset        : center
// ///
// ///4. double        : barcodeOnScreenUnits
// ///
// ///

// class OnScreenBarcodeData {
//   OnScreenBarcodeData(
//       {required final this.displayValue,
//       required final this.cornerPoints,
//       required final this.center,
//       required final this.barcodeOnScreenUnits});

//   ///The BarcodeID
//   final String displayValue;

//   ///The 4 corner points of the barcode
//   final List<Offset> cornerPoints;

//   ///The barcode's center offset
//   final Offset center;

//   ///The barcode's size (On Screen Units)
//   final double barcodeOnScreenUnits;

//   factory OnScreenBarcodeData.fromBarcodeData({
//     required Barcode barcode,
//     required InputImageRotation rotation,
//     required Size size,
//     required Size absoluteImageSize,
//   }) {
//     var cornerPoints = barcode.cornerPoints;

//     List<Offset> offsetPoints = <Offset>[];
//     for (var point in cornerPoints!) {
//       double x =
//           translateX(point.x.toDouble(), rotation, size, absoluteImageSize);
//       double y =
//           translateY(point.y.toDouble(), rotation, size, absoluteImageSize);

//       offsetPoints.add(Offset(x, y));
//     }

//     offsetPoints.add(offsetPoints.first);

//     //Calculate barcode on screen center.
//     final Offset barcodeCenter = calculateCenterFromCornerPoints(offsetPoints);
//     //BarcodeID.
//     final String displayValue = barcode.displayValue!;

//     //Calculate the barcodes on screen size.
//     double diagonal1 = (offsetPoints[0] - offsetPoints[2]).distance;
//     double diagonal2 = (offsetPoints[1] - offsetPoints[3]).distance;

//     final double barcodeSizeOnScreenUnits = (diagonal1 + diagonal2) / 2;

//     return OnScreenBarcodeData(
//         displayValue: displayValue,
//         cornerPoints: offsetPoints,
//         center: barcodeCenter,
//         barcodeOnScreenUnits: barcodeSizeOnScreenUnits);
//   }
// }
