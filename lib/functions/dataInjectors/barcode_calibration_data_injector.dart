// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/calibrationAdapters/calibration_accelerometer_data_adapter.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/calibrationAdapters/calibration_size_data_adapter.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/rawDataFunctions/data_capturing_functions.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:hive/hive.dart';

import '../mathfunctions/round_to_double.dart';

//RealData  (Stored in box) ****** Majoroty of calulations Real Offset -> Screen Offset;  realOffset * X = screenOffset ;
//ImageData (Stored in box)) ImageOffset -> RealOffset /barcode { uid , size }
//ScreenData * rarley used (Not stored)

//TODO : Global box names:
 
//1. consolidatedData: RealPositionData (UID, X & Y cordinates)
// X and Y cordinates of every barcode 

//2. rawDataBox: OnImageInterBarcodeData (......)

//3. AccelerometerData: Delete

//4. SizeData: Delete 

//5. MatchedData: DistanceLookupTable 

//.Recommended:

// Barcodes (UID, BarcodeDiagonalLength , Fixed )



//Add barcode size to Database... realBarcodeSize

injectBarcodeSizeData(
  BuildContext context,
  List<Barcode> barcodes,
  Size absoluteImageSize,
  InputImageRotation rotation,
  Box<dynamic> calibrationDataBox,
) {
  for (final Barcode barcode in barcodes) {
    bool checkIfBarcodeIsValid() =>
        barcode.value.displayValue != null && barcode.value.boundingBox != null;
    if (checkIfBarcodeIsValid()) {
      CalibrationSizeDataHiveObject calibrationDataInstance =
          CalibrationSizeDataHiveObject(
              timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
              averageDiagonalLength: averageBarcodeDiagonalLength(barcode));

      calibrationDataBox.put(
          calibrationDataInstance.timestamp, calibrationDataInstance);
    } else {
      throw Exception(
          'Barcode with null displayvalue or boundingbox detected ');
    }
  }
}

injectAccelerometerData(int deltaT, double zAcceleration, double distanceMoved,
    Box accelerometerDataBox) {
  int timestamp = DateTime.now().millisecondsSinceEpoch;
  CalibrationAccelerometerDataHiveObject accelerometerDataInstance =
      CalibrationAccelerometerDataHiveObject(
          timestamp: timestamp,
          deltaT: deltaT,
          accelerometerData: zAcceleration,
          distanceMoved: roundDouble(distanceMoved, 5).abs());

  accelerometerDataBox.put(timestamp.toString(), accelerometerDataInstance);
}
