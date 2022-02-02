import 'package:google_ml_kit/google_ml_kit.dart';

class BarcodePairDataInstance {
  BarcodePairDataInstance(
      {required this.startBarcode,
      required this.endBarcode,
      required this.timestamp});

  ///uid = uidStart_uidEnd.
  final BarcodeValue startBarcode;
  final BarcodeValue endBarcode;
  final int timestamp;
}
