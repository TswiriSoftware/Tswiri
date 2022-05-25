// import 'package:flutter_google_ml_kit/disposal/on_image_data.dart';

// ///Describes the "Offset" between two barcodes.
// class OnImageInterBarcodeDataOld {
//   OnImageInterBarcodeDataOld({
//     required this.startBarcode,
//     required this.endBarcode,
//   });

//   ///Data related to the start barcode.
//   final OnImageBarcodeDataOld startBarcode;

//   ///Data related to the end barcode.
//   final OnImageBarcodeDataOld endBarcode;

//   ///This takes 2 IsolateRawOnImageBarcodeData and returns them so that the smaller barcode is always first.
//   factory OnImageInterBarcodeDataOld.fromBarcodeDataPair(
//     OnImageBarcodeDataOld rawOnImageBarcodeData1,
//     OnImageBarcodeDataOld rawOnImageBarcodeData2,
//   ) {
//     int startBarcode =
//         int.parse(rawOnImageBarcodeData1.barcodeUID.split('_').first);
//     int endBarcode =
//         int.parse(rawOnImageBarcodeData2.barcodeUID.split('_').first);

//     if (startBarcode < endBarcode) {
//       return OnImageInterBarcodeDataOld(
//         startBarcode: rawOnImageBarcodeData1,
//         endBarcode: rawOnImageBarcodeData2,
//       );
//     } else {
//       return OnImageInterBarcodeDataOld(
//         startBarcode: rawOnImageBarcodeData2,
//         endBarcode: rawOnImageBarcodeData1,
//       );
//     }
//   }

//   ///This returns the UID of the Start and end Barcode.
//   String get uid {
//     return startBarcode.barcodeUID + '_' + endBarcode.barcodeUID;
//   }

//   @override
//   bool operator ==(Object other) {
//     return other is OnImageInterBarcodeDataOld && hashCode == other.hashCode;
//   }

//   @override
//   int get hashCode => (uid).hashCode;

//   @override
//   String toString() {
//     return '\n${startBarcode.barcodeUID} => ${endBarcode.barcodeUID}';
//   }
// }
