import 'package:flutter_google_ml_kit/objects/accelerometer_data.dart';
import 'package:flutter_google_ml_kit/objects/raw_on_image_inter_barcode_data.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

///Captures a collection of barcodes from a single image and returns a list of interBarcodeData
List<RawOnImageInterBarcodeData> singeImageInterBarcodeDataExtractor(
    List<Barcode> barcodes, AccelerometerData accelerometerEvent) {
  List<RawOnImageInterBarcodeData> interBarcodeData = [];
  for (var barcodeIndex = 1; barcodeIndex < barcodes.length; barcodeIndex++) {
    interBarcodeData.add(RawOnImageInterBarcodeData(
        startBarcode: barcodes[0].value,
        endBarcode: barcodes[barcodeIndex].value,
        accelerometerData: accelerometerEvent,
        timestamp: DateTime.now().microsecondsSinceEpoch));
  }
  return interBarcodeData;
}
