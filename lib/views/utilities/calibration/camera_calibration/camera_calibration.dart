import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunbird/globals/globals_export.dart';
import 'package:sunbird/isar/isar_database.dart';
import 'dart:math' as m;

///Object used to calibrate the camera.
class CameraCalibration {
  CameraCalibration({
    required this.accelerometerData,
    required this.barcodeData,
  });
  //Collected AccelerometerData.
  Map<int, double> accelerometerData;

  //Collected BarcodeData.
  Map<int, Barcode> barcodeData;

  Future<void> calibrateCamera() async {
    double defualtBarcodeDiagonalSize = defaultBarcodeSize * m.sqrt(2);
    //1. Get the barcode size, otherwise default.
    double barcodeSize = defualtBarcodeDiagonalSize;

    String? barcodeUID = barcodeData.entries.first.value.displayValue;
    if (barcodeUID != null) {
      //Query the database for BarcodeSize
      CatalogedBarcode? barcodeProperty = isar!.catalogedBarcodes
          .filter()
          .barcodeUIDMatches(barcodeUID)
          .findFirstSync();

      if (barcodeProperty != null) {
        //Set barcode size
        barcodeSize = barcodeProperty.size * m.sqrt(2);
      }
    }

    //2. Calculate the average barcode diagonal length for each barcode.
    Map<int, double> barcodeSizeData = {
      for (var entry in barcodeData.entries)
        entry.key: _calculateBarcodeDiagonalLength(entry.value)
    };

    //3. Calculate the distance moved at each step
    Map<int, double> distanceData = {
      accelerometerData.entries.first.key: 0, //Add the first entry
    };
    double totalDistance = 0;
    for (var i = 1; i < accelerometerData.length; i++) {
      int deltaT = accelerometerData.entries.elementAt(i).key -
          distanceData.entries.elementAt(i - 1).key;

      double accelerometerValue = accelerometerData.entries.elementAt(i).value;

      distanceData.putIfAbsent(
        accelerometerData.entries.elementAt(i).key,
        () {
          if (accelerometerValue < 0) {
            //Calculate distance moved.
            totalDistance = totalDistance + (-accelerometerValue * deltaT);
            return totalDistance;
          }
          return totalDistance;
        },
      );
    }

    //4. Combine the Maps for a *Distance - Size* map
    List<double> focalLengths = [];
    Map<double, double> distanceSizeData = {};
    for (var sizeData in barcodeSizeData.entries) {
      double distance = distanceData.entries
          .firstWhere((element) => element.key >= sizeData.key)
          .value;

      distanceSizeData.putIfAbsent(distance, () => sizeData.value);

      double focalLength = sizeData.value * (distance / barcodeSize);
      focalLengths.add(focalLength);
    }

    //5. Save to sharedPrefs

    double sumFocalLength = 0;
    for (double e in focalLengths) {
      sumFocalLength += e;
    }

    double finalFocalLength = sumFocalLength / focalLengths.length;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(focalLengthPref, finalFocalLength);
    focalLength = finalFocalLength;

    //6. Write to isar.
    List<CameraCalibrationEntry> distanceSizeEntries = distanceSizeData.entries
        .map(
          (e) => CameraCalibrationEntry()
            ..diagonalSize = e.value
            ..distanceFromCamera = e.key,
        )
        .toList();

    isar!.writeTxnSync(
        (isar) => isar.cameraCalibrationEntrys.putAllSync(distanceSizeEntries));
  }

  double _calculateBarcodeDiagonalLength(Barcode barcode) {
    var cornerPoints = barcode.cornerPoints;
    List<Offset> offsetPoints = <Offset>[];
    if (cornerPoints != null) {
      for (var point in cornerPoints) {
        double x = point.x.toDouble();
        double y = point.y.toDouble();
        offsetPoints.add(Offset(x, y));
      }
    }

    double diagonal1 = (offsetPoints[0] - offsetPoints[2]).distance;
    double diagonal2 = (offsetPoints[1] - offsetPoints[3]).distance;

    return (diagonal1 + diagonal2) / 2;
  }
}
