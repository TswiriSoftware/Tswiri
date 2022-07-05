import 'package:flutter_google_ml_kit/isar_database/containers/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/grid/coordinate_entry/coordinate_entry.dart';
import 'package:flutter_google_ml_kit/objects/grid/interbarcode_vector.dart';

///Generate a list of coordinates from a list of interBarcodeVectors and the origin container.
List<CoordinateEntry> generateCoordinates(ContainerEntry originContainer,
    List<InterBarcodeVector> interBarcodeVectors) {
  //1. Extract Barcodes
  List<String> barcodes = extractBarcodes(interBarcodeVectors);

  int timestamp = DateTime.now().millisecondsSinceEpoch;

  //2. Create a list of all possible coordiantes.
  List<CoordinateEntry> coordinates = barcodes
      .map((e) => CoordinateEntry()
        ..barcodeUID = e
        ..gridUID = originContainer.barcodeUID!
        ..x = null
        ..y = null
        ..z = null
        ..timestamp = timestamp)
      .toList();

  //3. Populate the Origin Coordinate.
  int index = coordinates.indexWhere(
      (element) => element.barcodeUID == originContainer.barcodeUID);
  if (index != -1) {
    coordinates.firstWhere(
        (element) => element.barcodeUID == originContainer.barcodeUID)
      ..x = 0
      ..y = 0
      ..z = 0;
  }

  int nonNullPositions = 1;
  int nonNullPositionsInPreviousIteration = coordinates.length - 1;

  for (int i = 0; i <= interBarcodeVectors.length;) {
    nonNullPositionsInPreviousIteration = nonNullPositions;
    for (CoordinateEntry endBarcodeRealPosition in coordinates) {
      if (endBarcodeRealPosition.vector() == null) {
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
        List<CoordinateEntry> confirmedPositions =
            coordinates.where((element) => element.vector() != null).toList();

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
          CoordinateEntry startBarcode = confirmedPositions[startBarcodeIndex];
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
              endBarcodeRealPosition.x = startBarcode.x! +
                  relevantInterBarcodeVectors[interBarcodeOffsetIndex]
                      .vector3
                      .x;

              endBarcodeRealPosition.y = startBarcode.y! +
                  relevantInterBarcodeVectors[interBarcodeOffsetIndex]
                      .vector3
                      .y;

              endBarcodeRealPosition.z = startBarcode.z! +
                  relevantInterBarcodeVectors[interBarcodeOffsetIndex]
                      .vector3
                      .z;
            } else if (relevantInterBarcodeVectors[interBarcodeOffsetIndex]
                    .startBarcodeUID ==
                endBarcodeRealPosition.barcodeUID) {
              //Calculate the interBarcodeOffset

              endBarcodeRealPosition.x = startBarcode.x! -
                  relevantInterBarcodeVectors[interBarcodeOffsetIndex]
                      .vector3
                      .x;

              endBarcodeRealPosition.y = startBarcode.y! -
                  relevantInterBarcodeVectors[interBarcodeOffsetIndex]
                      .vector3
                      .y;

              endBarcodeRealPosition.z = startBarcode.z! -
                  relevantInterBarcodeVectors[interBarcodeOffsetIndex]
                      .vector3
                      .z;
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

  return coordinates;
}

///This extracts all the barcodes found in the list of InterBarcodeVectors.
List<String> extractBarcodes(List<InterBarcodeVector> interBarcodeVectors) {
  List<String> barcodes = [];
  barcodes.addAll(interBarcodeVectors.map((e) => e.startBarcodeUID));
  barcodes.addAll(interBarcodeVectors.map((e) => e.endBarcodeUID));
  return barcodes.toSet().toList();
}
