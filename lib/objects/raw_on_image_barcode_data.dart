import 'package:google_ml_kit/google_ml_kit.dart';

import 'reworked/accelerometer_data.dart';

//TODO: Depricate.

///Contains all barcodes scanned at an istant.
class RawOnImageBarcodeData {
  ///The list of barcodes
  List<Barcode> barcodes;

  ///The time of creation.
  int timestamp;

  ///The accelerometer data at that instant.
  AccelerometerData accelerometerData;
  RawOnImageBarcodeData(
      {required this.barcodes,
      required this.timestamp,
      required this.accelerometerData});
}
