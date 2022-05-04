import 'dart:developer';

import 'package:flutter_google_ml_kit/isar_database/marker/marker.dart';
import 'package:flutter_google_ml_kit/objects/navigation/grid_object.dart';
import 'package:flutter_google_ml_kit/objects/navigation/grid_position.dart';
import 'package:flutter_google_ml_kit/objects/navigation/isolate_real_inter_barcode_vector.dart';
import 'package:flutter_google_ml_kit/objects/navigation/rolling_grid_position.dart';
import 'package:vector_math/vector_math.dart';

///This Grid Object is made to be sent though a sendPort with Json
class IsolateGridObject {
  IsolateGridObject({
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

  factory IsolateGridObject.fromJson(dynamic json) {
    List<dynamic> gridList = json['grid'];
    List<GridPosition> gridPositions =
        List<GridPosition>.from(gridList.map((e) => GridPosition.fromJson(e)));

    List<dynamic> markerList = json['markers'];
    List<Marker> markers =
        List<Marker>.from(markerList.map((e) => Marker().fromJson(e)));
    return IsolateGridObject(
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

///Used to build a rolling grid.
class RollingGridObject {
  RollingGridObject({required this.markers});
  List<Marker> markers;
  List<RollingGridPosition> grid = [];
  List<String> barcodes = [];
  List<IsolateRealInterBarcodeVector> vectors = [];
  bool isComplete = false;

  void initiateGrid(
      List<Marker> markers, List<GridPosition> initialGridPositions) {
    for (Marker marker in markers) {
      GridPosition initalMarker = initialGridPositions
          .where((element) => element.barcodeUID == marker.barcodeUID)
          .first;

      grid.add(RollingGridPosition(
          barcodeUID: marker.barcodeUID, position: initalMarker.position));
    }
    for (var gridPosition in initialGridPositions) {
      barcodes.add(gridPosition.barcodeUID);
      barcodes = barcodes.toSet().toList();
    }
  }

  void generateGrid(
      List<IsolateRealInterBarcodeVector> realInterBarcodeVectors) {
    vectors.addAll(realInterBarcodeVectors);

    List<IsolateRealInterBarcodeVector> uniqueVectors =
        vectors.toSet().toList();

    List<IsolateRealInterBarcodeVector> averagedVectors = [];

    for (var uniqueVector in uniqueVectors) {
      List<IsolateRealInterBarcodeVector> relevantVectors =
          vectors.where((element) => element.uid == uniqueVector.uid).toList();

      if (relevantVectors.length >= 10) {
        //This Determines the amount of interbarcodeData required to confirm position.
        for (var element in relevantVectors) {
          uniqueVector.averageInterBarcodeVector(element);
        }
        vectors.removeWhere((element) => element.uid == uniqueVector.uid);
        averagedVectors.add(uniqueVector);
      }
    }
    //Update the grid.
    for (var interBarcodeVector in averagedVectors) {
      // ignore: iterable_contains_unrelated_type
      if (grid.contains(interBarcodeVector.startBarcodeUID)) {
        // This checks if the grid contains the startbarcode.
        RollingGridPosition relevantPosition = grid
            .where((element) =>
                element.barcodeUID == interBarcodeVector.startBarcodeUID)
            .first;

        // ignore: iterable_contains_unrelated_type
        if (!grid.contains(interBarcodeVector.endBarcodeUID)) {
          Vector3 position =
              relevantPosition.position! + interBarcodeVector.vector;
          grid.add(RollingGridPosition(
              barcodeUID: interBarcodeVector.endBarcodeUID,
              position: position));
        }
      }
    }
    if (barcodes.length == grid.length) {
      isComplete = true;
    }
  }

  @override
  String toString() {
    return '''__________________________________________________________________
markers: $markers
positions: $grid   
barcodes: $barcodes   
__________________________________________________________________''';
  }
}
