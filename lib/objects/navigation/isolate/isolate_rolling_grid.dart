import 'package:flutter_google_ml_kit/objects/grid/position.dart';
import 'package:flutter_google_ml_kit/objects/navigation/isolate/rolling_grid_position.dart';

import '../../../isar_database/marker/marker.dart';
import 'isolate_real_inter_barcode_vector.dart';
import 'package:vector_math/vector_math.dart';

///Used to build a rolling grid.
class RollingGrid {
  RollingGrid({required this.markers});
  List<Marker> markers;
  List<RollingGridPosition> grid = [];
  List<String> barcodes = [];
  List<IsolateRealInterBarcodeVector> vectors = [];
  bool isComplete = false;

  void initiateGrid(List<Marker> markers, List<Position> initialGridPositions) {
    for (Marker marker in markers) {
      Position initalMarker = initialGridPositions
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
