// import 'dart:ui';

// import 'package:flutter_google_ml_kit/objects/reworked/accelerometer_data.dart';
// import 'package:vector_math/vector_math.dart' as vm;

// class OnImageBarcodeDataOld {
//   OnImageBarcodeDataOld({
//     required this.barcodeUID,
//     required this.onImageCornerPoints,
//     required this.timestamp,
//     required this.accelerometerData,
//   });

//   ///BarcodeUID.
//   final String barcodeUID;

//   final List<Offset> onImageCornerPoints;

//   ///Timestamp.
//   final int timestamp;

//   ///Accelerometer Data.
//   final AccelerometerData accelerometerData;

//   ///Create a Isolate Barcode from a List.
//   factory OnImageBarcodeDataOld.fromMessage(List<dynamic> item) {
//     AccelerometerData accelerometerData = AccelerometerData(
//         accelerometerEvent: vm.Vector3(
//           item[2][0] as double,
//           item[2][1] as double,
//           item[2][2] as double,
//         ),
//         userAccelerometerEvent: vm.Vector3(
//           item[2][3] as double,
//           item[2][4] as double,
//           item[2][5] as double,
//         ));

//     List<Offset> onImageCornerPoints = [
//       Offset(item[1][0] as double, item[1][1] as double),
//       Offset(item[1][2] as double, item[1][3] as double),
//       Offset(item[1][4] as double, item[1][5] as double),
//       Offset(item[1][6] as double, item[1][7] as double),
//     ];

//     return OnImageBarcodeDataOld(
//       barcodeUID: item[0],
//       onImageCornerPoints: onImageCornerPoints,
//       accelerometerData: accelerometerData,
//       timestamp: item[3],
//     );
//   }

//   ///Calculate barcode centerPoint.
//   Offset get barcodeCenterPoint {
//     //Center of X coordinates.
//     double centerX = (onImageCornerPoints[0].dx +
//             onImageCornerPoints[1].dx +
//             onImageCornerPoints[2].dx +
//             onImageCornerPoints[3].dx) /
//         4;

//     //Center of Y coordinates.
//     double centerY = (onImageCornerPoints[0].dy +
//             onImageCornerPoints[1].dy +
//             onImageCornerPoints[2].dy +
//             onImageCornerPoints[3].dy) /
//         4;
//     return Offset(centerX, centerY);
//   }

//   @override
//   String toString() {
//     return '\nUID: $barcodeUID, timestamp: $timestamp, centerPoint: (${barcodeCenterPoint.dx}, ${barcodeCenterPoint.dy})';
//   }
// }
