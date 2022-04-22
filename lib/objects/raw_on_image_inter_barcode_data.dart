import 'package:flutter_google_ml_kit/functions/barcode_calculations/data_capturing_functions.dart';
import 'package:flutter_google_ml_kit/objects/accelerometer_data.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

///Describes the "Offset" between two barcodes.
class RawOnImageInterBarcodeDataOLD {
  RawOnImageInterBarcodeDataOLD(
      {required this.startBarcode,
      required this.endBarcode,
      required this.accelerometerData,
      required this.timestamp});

  ///Data related to the start barcode.
  final BarcodeValue startBarcode;

  ///Data related to the end barcode.
  final BarcodeValue endBarcode;

  ///Contains accelerometer Events
  final AccelerometerData accelerometerData;

  ///Time of creation.
  final int timestamp;

  ///Check if startBarcode displayValue is less than endBarcode DisplayValue.
  bool checkBarcodes() {
    return int.parse(startBarcode.displayValue!.split('_').first) <
        int.parse(endBarcode.displayValue!.split('_').first);
  }

  ///Gets the start barcode's diagonal length in px.
  double get startDiagonalLength {
    if (checkBarcodes()) {
      return calculateAverageBarcodeDiagonalLength(startBarcode);
    } else {
      return calculateAverageBarcodeDiagonalLength(endBarcode);
    }
  }

  ///Gets the end barcode's diagonal length.
  double get endDiagonalLength {
    if (checkBarcodes()) {
      return calculateAverageBarcodeDiagonalLength(endBarcode);
    } else {
      return calculateAverageBarcodeDiagonalLength(startBarcode);
    }
  }

  ///This returns the UID of the Start and end Barcode.
  ///The start barcode will always be smaller than the end barcode.
  String get uid {
    if (checkBarcodes()) {
      return startBarcode.displayValue! + '_' + endBarcode.displayValue!;
    } else {
      return endBarcode.displayValue! + '_' + startBarcode.displayValue!;
    }
  }

  ///Returns the start Barcodes ID.
  String get uidStart {
    if (checkBarcodes()) {
      return startBarcode.displayValue!;
    } else {
      return endBarcode.displayValue!;
    }
  }

  ///Returns the end Barcodes ID.
  String get uidEnd {
    if (checkBarcodes()) {
      return endBarcode.displayValue!;
    } else {
      return startBarcode.displayValue!;
    }
  }

  @override
  bool operator ==(Object other) {
    return other is RawOnImageInterBarcodeDataOLD && hashCode == other.hashCode;
  }

  @override
  int get hashCode => (uid).hashCode;

  @override
  String toString() {
    return '\n${startBarcode.displayValue} => ${endBarcode.displayValue}, $timestamp';
  }
}
