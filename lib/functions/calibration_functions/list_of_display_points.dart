import 'dart:ui';
import 'package:flutter_google_ml_kit/isar_database/barcodes/barcode_size_distance_entry/barcode_size_distance_entry.dart';

///Generates a list of points to display with painter
List<Offset> listOfCalibrationPoints(
    List<BarcodeSizeDistanceEntry> sizeDistanceEntries, Size screenSize) {
  List<Offset> points = [];

  for (var sizeDistanceEntry in sizeDistanceEntries) {
    Offset offsetData = Offset(
        sizeDistanceEntry.diagonalSize, sizeDistanceEntry.distanceFromCamera);
    points.add(
      Offset(
        ((offsetData.dx + screenSize.width / 2) / (screenSize.width / 50)),
        ((offsetData.dy + screenSize.height / 2) / (screenSize.height / 50)),
      ),
    );
  }

  return points;
}
