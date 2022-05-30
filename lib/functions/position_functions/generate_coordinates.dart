import 'dart:developer';
import 'package:flutter_google_ml_kit/isar_database/containers/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/grid/coordinate_entry.dart';
import 'package:flutter_google_ml_kit/objects/grid/master_grid.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcodes/barcode_scanning/barcode_position_scanner/interbarcode_vector.dart';
import 'package:vector_math/vector_math.dart';

///Generate a list of coordinates from a list of interBarcodeVectors and the origin container.
List<CoordinateEntry> generateCoordinates(ContainerEntry originContainer,
    List<InterBarcodeVector> interBarcodeVectors) {
  //1. Extract Barcodes
  List<String> barcodes = extractBarcodes(interBarcodeVectors);

  //2. Create a list of all possible coordiantes.
  List<Coordinate> coordinates = barcodes
      .map((e) => Coordinate(
          barcodeUID: e, coordinate: null, gridID: originContainer.barcodeUID!))
      .toList();

  //3. Populate the Origin Coordinate.
  coordinates
      .firstWhere((element) => element.barcodeUID == originContainer.barcodeUID)
      .coordinate = Vector3(0, 0, 0);

  int nonNullPositions = 1;
  int nonNullPositionsInPreviousIteration = coordinates.length - 1;

  for (int i = 0; i <= interBarcodeVectors.length;) {
    nonNullPositionsInPreviousIteration = nonNullPositions;
    for (Coordinate endBarcodeRealPosition in coordinates) {
      if (endBarcodeRealPosition.coordinate == null) {
        //We are going to add the interbarcode offset between start and end barcodes to obtain the "position" of the end barcode.

        //i. Find all InterBarcodeVectors that contains the EndBarcode.
        List<InterBarcodeVector> relevantInterBarcodeVectors =
            interBarcodeVectors
                .where((element) =>
                    element.startBarcodeUID ==
                        endBarcodeRealPosition.barcodeUID ||
                    element.endBarcodeUID == endBarcodeRealPosition.barcodeUID)
                .toList();

        //ii. Find the InterBarcodeVectors that already have a position. (effectivley to the Origin)
        List<Coordinate> confirmedPositions =
            coordinates.where((element) => element.coordinate != null).toList();

        //iii. Find a startBarcode with a position to calculate the endBarcode Position.
        int startBarcodeIndex =
            confirmedPositions.indexWhere((barcodeWithOffsetToOrigin) {
          for (InterBarcodeVector singleInterBarcodeData
              in relevantInterBarcodeVectors) {
            if (singleInterBarcodeData.startBarcodeUID ==
                    barcodeWithOffsetToOrigin.barcodeUID ||
                singleInterBarcodeData.endBarcodeUID ==
                    barcodeWithOffsetToOrigin.barcodeUID) {
              return true;
            }
          }
          return false;
        });

        if (startBarcodeIndex != -1) {
          Coordinate startBarcode = confirmedPositions[startBarcodeIndex];
          //Index of InterBarcodeOffset which contains startBarcode.
          int interBarcodeOffsetIndex =
              relevantInterBarcodeVectors.indexWhere((element) {
            if ((startBarcode.barcodeUID == element.startBarcodeUID &&
                    endBarcodeRealPosition.barcodeUID ==
                        element.endBarcodeUID) ||
                (startBarcode.barcodeUID == element.endBarcodeUID &&
                    endBarcodeRealPosition.barcodeUID ==
                        element.startBarcodeUID)) {
              return true;
            }
            return false;
          });

          if (interBarcodeOffsetIndex != -1) {
            //Determine whether to add or subtract the interBarcode Offset.
            if (relevantInterBarcodeVectors[interBarcodeOffsetIndex]
                    .endBarcodeUID ==
                endBarcodeRealPosition.barcodeUID) {
              //Calculate the interBarcodeOffset
              endBarcodeRealPosition.coordinate = startBarcode.coordinate! +
                  relevantInterBarcodeVectors[interBarcodeOffsetIndex].vector3;
            } else if (relevantInterBarcodeVectors[interBarcodeOffsetIndex]
                    .startBarcodeUID ==
                endBarcodeRealPosition.barcodeUID) {
              //Calculate the interBarcodeOffset
              endBarcodeRealPosition.coordinate = startBarcode.coordinate! -
                  relevantInterBarcodeVectors[interBarcodeOffsetIndex].vector3;
            }
            nonNullPositions++;
          }
        }
      }
    }
    i++;
    //If all barcodes have been mapped it will break the loop.
    if (nonNullPositions == nonNullPositionsInPreviousIteration) {
      break;
    }
  }

  int timestamp = DateTime.now().microsecondsSinceEpoch;
  List<CoordinateEntry> coordinateEntries = [];

  for (Coordinate coordinate in coordinates) {
    if (coordinate.coordinate != null) {
      coordinateEntries.add(
        CoordinateEntry()
          ..barcodeUID = coordinate.barcodeUID
          ..gridUID = originContainer.barcodeUID!
          ..timestamp = timestamp
          ..x = coordinate.coordinate!.x
          ..y = coordinate.coordinate!.y
          ..z = coordinate.coordinate!.z,
      );
    }
  }

  return coordinateEntries;
}

List<String> extractBarcodes(List<InterBarcodeVector> interBarcodeVectors) {
  List<String> barcodes = [];
  barcodes.addAll(interBarcodeVectors.map((e) => e.startBarcodeUID));
  barcodes.addAll(interBarcodeVectors.map((e) => e.endBarcodeUID));
  return barcodes.toSet().toList();
}
