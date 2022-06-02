// import 'package:flutter/widgets.dart';
// import 'package:flutter_google_ml_kit/functions/translating/coordinates_translator.dart';
// import 'package:flutter_google_ml_kit/objects/reworked/on_screen_barcode_data.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';

// import 'calculate_barcode_center_from_corner_points.dart';

// ///This calculates the barcode screen data:
// OnScreenBarcodeData calculateScreenBarcodeData({
//   required Barcode barcode,
//   required InputImageRotation rotation,
//   required Size size,
//   required Size absoluteImageSize,
// }) {
//   var cornerPoints = barcode.cornerPoints;

//   List<Offset> offsetPoints = <Offset>[];
//   for (var point in cornerPoints!) {
//     double x =
//         translateX(point.x.toDouble(), rotation, size, absoluteImageSize);
//     double y =
//         translateY(point.y.toDouble(), rotation, size, absoluteImageSize);

//     offsetPoints.add(Offset(x, y));
//   }

//   offsetPoints.add(offsetPoints.first);

//   //Calculate barcode on screen center.
//   final Offset barcodeCenter = calculateCenterFromCornerPoints(offsetPoints);
//   //BarcodeID.
//   final String displayValue = barcode.displayValue!;

//   //Calculate the barcodes on screen size.
//   double diagonal1 = (offsetPoints[0] - offsetPoints[2]).distance;
//   double diagonal2 = (offsetPoints[1] - offsetPoints[3]).distance;

//   final double barcodeSizeOnScreenUnits = (diagonal1 + diagonal2) / 2;

//   return OnScreenBarcodeData(
//       displayValue: displayValue,
//       center: barcodeCenter,
//       barcodeOnScreenUnits: barcodeSizeOnScreenUnits,
//       cornerPoints: offsetPoints);
// }
