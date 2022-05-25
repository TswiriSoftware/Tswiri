// import 'package:flutter_google_ml_kit/objects/navigation/isolate/on_image_data.dart';

// ///Describes the "Offset" between two barcodes.
// class OnImageInterBarcodeData {
//   OnImageInterBarcodeData({
//     required this.startBarcode,
//     required this.endBarcode,
//   });

//   ///Data related to the start barcode.
//   final OnImageBarcodeData startBarcode;

//   ///Data related to the end barcode.
//   final OnImageBarcodeData endBarcode;

//   ///This takes 2 IsolateRawOnImageBarcodeData and returns them so that the smaller barcode is always first.
//   factory OnImageInterBarcodeData.fromBarcodeDataPair(
//     OnImageBarcodeData rawOnImageBarcodeData1,
//     OnImageBarcodeData rawOnImageBarcodeData2,
//   ) {
//     int startBarcode =
//         int.parse(rawOnImageBarcodeData1.barcodeUID.split('_').first);
//     int endBarcode =
//         int.parse(rawOnImageBarcodeData2.barcodeUID.split('_').first);

//     if (startBarcode < endBarcode) {
//       return OnImageInterBarcodeData(
//         startBarcode: rawOnImageBarcodeData1,
//         endBarcode: rawOnImageBarcodeData2,
//       );
//     } else {
//       return OnImageInterBarcodeData(
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
//     return other is OnImageInterBarcodeData && hashCode == other.hashCode;
//   }

//   @override
//   int get hashCode => (uid).hashCode;

//   @override
//   String toString() {
//     return '\n${startBarcode.barcodeUID} => ${endBarcode.barcodeUID}';
//   }
// }
