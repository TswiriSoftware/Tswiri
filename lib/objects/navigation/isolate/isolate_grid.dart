import 'dart:developer';

import 'package:flutter_google_ml_kit/isar_database/marker/marker.dart';
import 'package:flutter_google_ml_kit/objects/navigation/grid_position.dart';
import 'package:flutter_google_ml_kit/objects/navigation/isolate/rolling_grid_position.dart';

///This Grid Object is made to be sent though a sendPort with Json
class IsolateGrid {
  IsolateGrid({
    required this.gridPositions,
    required this.markers,
  });
  //List of all grid positions
  List<GridPosition> gridPositions;
  //List of all markers in grid.
  List<Marker> markers;

  List<String> barcodes = [];

  List<String> getBarcodes() {
    List<String> barcodes = [];
    for (var position in gridPositions) {
      barcodes.add(position.barcodeUID);
    }
    return barcodes;
  }

  void updatePosition(RollingGridPosition rollingGridPosition) {
    gridPositions
        .where(
            (element) => element.barcodeUID == rollingGridPosition.barcodeUID)
        .first
        .position = rollingGridPosition.position;
  }

  bool comparePosition(RollingGridPosition rollingGridPosition) {
    int relevantPositionIndex = gridPositions.indexWhere(
        (element) => element.barcodeUID == rollingGridPosition.barcodeUID);

    if (relevantPositionIndex != -1) {
      GridPosition relevantPosition = gridPositions[relevantPositionIndex];

      if (rollingGridPosition.position != null &&
          relevantPosition.position != null) {
        //This is to calculate the amount of positional error we allow for in mm.

        double errorValue = 20; // max error value in mm
        double currentX = rollingGridPosition.position!.x;
        double currentXLowerBoundry = currentX - (errorValue);
        double currentXUpperBoundry = currentX + (errorValue);

        double currentY = rollingGridPosition.position!.y;
        double currentYLowerBoundry = currentY - (errorValue);
        double currentYUpperBoundry = currentY + (errorValue);

        double storedX = relevantPosition.position!.x;
        double storedY = relevantPosition.position!.y;

        if (storedX <= currentXUpperBoundry &&
            storedX >= currentXLowerBoundry &&
            storedY <= currentYUpperBoundry &&
            storedY >= currentYLowerBoundry) {
          return false;
        } else {
          log('new Position: $rollingGridPosition');
          log('old Position: ' + relevantPosition.toString() + '\n');
          return true;
        }
      }
    }

    return false;
  }

  Map toJson() {
    return {
      'grid': gridPositions,
      'markers': markers,
    };
  }

  factory IsolateGrid.fromJson(dynamic json) {
    List<dynamic> gridList = json['grid'];
    List<GridPosition> gridPositions =
        List<GridPosition>.from(gridList.map((e) => GridPosition.fromJson(e)));

    List<dynamic> markerList = json['markers'];
    List<Marker> markers =
        List<Marker>.from(markerList.map((e) => Marker().fromJson(e)));
    return IsolateGrid(
      gridPositions: gridPositions,
      markers: markers,
    );
  }

  @override
  String toString() {
    return '''______________________
positions: $gridPositions
markers: $markers
______________________''';
  }
}
