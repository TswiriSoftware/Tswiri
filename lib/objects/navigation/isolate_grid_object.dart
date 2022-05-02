import 'dart:developer';

import 'package:flutter_google_ml_kit/isar_database/marker/marker.dart';
import 'package:flutter_google_ml_kit/objects/navigation/grid_object.dart';
import 'package:flutter_google_ml_kit/objects/navigation/grid_position.dart';
import 'package:flutter_google_ml_kit/objects/navigation/isolate_real_inter_barcode_vector.dart';
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

  factory IsolateGridObject.fromGridObject(GridObject gridObject) {
    return IsolateGridObject(
      gridPositions: gridObject.grid,
      markers: gridObject.markers,
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
  List<GridPosition> grid = [];
  List<String> barcodes = [];

  void initiateGrid(
      List<Marker> markers, List<GridPosition> initialGridPositions) {
    for (Marker marker in markers) {
      GridPosition initalMarker = initialGridPositions
          .where((element) => element.barcodeUID == marker.barcodeUID)
          .first;
      grid.add(GridPosition(
          barcodeUID: marker.barcodeUID, position: initalMarker.position));
    }
    for (var gridPosition in initialGridPositions) {
      barcodes.add(gridPosition.barcodeUID);
      barcodes = barcodes.toSet().toList();
    }
  }

  void updateGrid(List<IsolateRealInterBarcodeVector> realInterBarcodeVectors) {
    for (var interBarcodeVector in realInterBarcodeVectors) {
      // ignore: iterable_contains_unrelated_type
      if (grid.contains(interBarcodeVector.startBarcodeUID)) {
        // This checks if the grid contains the startbarcode.
        GridPosition relevantPosition = grid
            .where((element) =>
                element.barcodeUID == interBarcodeVector.startBarcodeUID)
            .first;

        // ignore: iterable_contains_unrelated_type
        if (grid.contains(interBarcodeVector.endBarcodeUID)) {
          //Code to update Position.
          grid
              .where((element) =>
                  element.barcodeUID == interBarcodeVector.endBarcodeUID)
              .first
              .averagePosition(interBarcodeVector.vector);
          log('averaged');
        } else {
          Vector3 position =
              relevantPosition.position! + interBarcodeVector.vector;
          grid.add(GridPosition(
              barcodeUID: interBarcodeVector.endBarcodeUID,
              position: position));
        }
      }
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
