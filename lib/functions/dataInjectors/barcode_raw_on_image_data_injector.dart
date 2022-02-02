// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:flutter_google_ml_kit/objects/barcode_pairs_data_instance.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

///Captures a collection of barcodes from a "single frame" and inserts them into a database.
///Take note that all calculations are done relative to the actual image size
// barcodeRawOnImageDataInjector(
//   List<Barcode> barcodes,
//   Box<dynamic> rawOnImageDataBox,
// ) {
// //TODO: Write documentation for all functions.

barcodePairsDataCollector(
  List<Barcode> barcodes,
  List barcodePairsData,
) {
  for (final Barcode barcodeStart in barcodes) {
    if (barcodes.length >= 2) {
      for (final Barcode barcodeEnd in barcodes) {
        if (barcodeStart.value.displayValue! !=
            barcodeEnd.value.displayValue!) {
          barcodePairsData.add(BarcodePairDataInstance(
              startBarcode: barcodeStart.value,
              endBarcode: barcodeEnd.value,
              timestamp: DateTime.now().microsecondsSinceEpoch));
        }
      }
    }
  }
}
