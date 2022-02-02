import 'package:google_ml_kit/google_ml_kit.dart';

//TODO: Rename file

///Describes the "Offset" between two barcodes.
class RawOnImageInterBarcodeData {
  RawOnImageInterBarcodeData(
      {required this.startBarcode,
      required this.endBarcode,
      required this.timestamp});

  ///uid = uidStart_uidEnd.
  final BarcodeValue startBarcode;
  final BarcodeValue endBarcode;
  final int timestamp;
}

