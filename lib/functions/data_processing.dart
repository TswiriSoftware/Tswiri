import 'dart:math';
import 'dart:ui';

import 'package:sunbird/classes/inter_barcode_vector.dart';
import 'package:sunbird/classes/on_image_barcode_data.dart';
import 'package:sunbird/classes/on_image_inter_barcode_data.dart';
import 'package:sunbird/globals/globals_export.dart';
import 'package:sunbird/isar/isar_database.dart';
// ignore: depend_on_referenced_packages
import 'package:vector_math/vector_math_64.dart' as vm;

///Generate a list of OnImageInterBarcodeData from barcodeDataBatches.
///
///   i. Iterate through barcodeDataBatches.
///
///   ii. Iterate through the barcodeDataBatch and generate IsolateRawOnImageBarcodeData.
///
///   iii.Iterate through onImageBarcodeDataBatch.
///
///   iv. Create BarcodeDataPairs.
///
List<OnImageInterBarcodeData> createOnImageBarcodeData(
    List barcodeDataBatches) {
  List<OnImageInterBarcodeData> onImageInterBarcodeData = [];

  for (int i = 0; i < barcodeDataBatches.length; i++) {
    //i. Iterate through barcodeDataBatches.
    List barcodeDataBatch = barcodeDataBatches[i];

    List<OnImageBarcodeData> onImageBarcodeDataBatch = [];

    for (int x = 0; x < barcodeDataBatch.length; x++) {
      //ii. Iterate through the barcodeDataBatch and generate IsolateRawOnImageBarcodeData.
      onImageBarcodeDataBatch
          .add(OnImageBarcodeData.fromBarcodeData(barcodeDataBatch[x]));
    }

    for (OnImageBarcodeData onImageBarcodeData in onImageBarcodeDataBatch) {
      //iii.Iterate through onImageBarcodeDataBatch.

      for (int z = 1; z < onImageBarcodeDataBatch.length; z++) {
        //iv. Create BarcodeDataPairs.
        if (onImageBarcodeData.barcodeUID !=
            onImageBarcodeDataBatch[z].barcodeUID) {
          onImageInterBarcodeData.add(
              OnImageInterBarcodeData.fromBarcodeDataPair(
                  onImageBarcodeData, onImageBarcodeDataBatch[z]));
        }
      }
    }
  }
  return onImageInterBarcodeData;
}

///Generate a list of InterbarcodeVector. (Real)
///
///   i. Iterate through onImageInterBarcodeData and generate InterbarcodeVector. (Real)
///
List<InterBarcodeVector> createInterbarcodeVectors(
    List<OnImageInterBarcodeData> onImageInterBarcodeData,
    List<CatalogedBarcode> barcodeProperties,
    double focalLength) {
  List<InterBarcodeVector> interBarcodeVectors = [];
  for (OnImageInterBarcodeData interBarcodeData in onImageInterBarcodeData) {
    // i. Iterate through onImageInterBarcodeData and generate IsolateRealInterBarcodeData.
    interBarcodeVectors.add(InterBarcodeVector.fromRawInterBarcodeData(
        interBarcodeData: interBarcodeData,
        barcodeProperties: barcodeProperties,
        focalLength: focalLength));
  }
  return interBarcodeVectors;
}

///Rotates the offset by the given angle.
Offset rotateOffset({required Offset offset, required double angleRadians}) {
  double x = offset.dx * cos(angleRadians) - offset.dy * sin(angleRadians);
  double y = offset.dx * sin(angleRadians) + offset.dy * cos(angleRadians);
  return Offset(x, y);
}

///Calculate the milimeter value of 1 on image unit (OIU). (Pixel ?)
double calculateRealUnit({
  required double diagonalLength,
  required String barcodeUID,
  required List<CatalogedBarcode> barcodeProperties,
  double? passedDefaultBarcodeSize,
}) {
  double barcodeDiagonalLength = passedDefaultBarcodeSize ?? defaultBarcodeSize;

  int index = barcodeProperties
      .indexWhere((element) => element.barcodeUID == barcodeUID);

  if (index != -1) {
    barcodeDiagonalLength = barcodeProperties[index].size;
  }

  return diagonalLength / barcodeDiagonalLength;
}

///Calculate the distance from camera in (mm).
double calculateDistanceFromCamera({
  required double barcodeOnImageDiagonalLength,
  required String barcodeUID,
  required double focalLength,
  required List<CatalogedBarcode> barcodeProperties,
  double? passedDefaultBarcodeSize,
}) {
  double barcodeDiagonalLength = passedDefaultBarcodeSize ?? defaultBarcodeSize;

  int index = barcodeProperties
      .indexWhere((element) => element.barcodeUID == barcodeUID);

  if (index != -1) {
    barcodeDiagonalLength = barcodeProperties[index].size;
  }

  //Calculate the distance from the camera
  double distanceFromCamera =
      focalLength * barcodeDiagonalLength / barcodeOnImageDiagonalLength;

  return distanceFromCamera;
}

///Remove outliers and calculate the average.
///
///   i. Generate list of unique RealInterBarcodeData.
///
///   ii. find similar RealInterbarcodeData.
///
///   iii. Sort similarInterBarcodeOffsets by the length of the vector.
///
///   iv. Remove any outliers.
///
///   v. Caluclate the average.
///
///   vi. Add to finalRealInterBarcodeData.
///
List<InterBarcodeVector> averageInterbarcodeData(
    List<InterBarcodeVector> interBarcodeVectors) {
  List<InterBarcodeVector> uniqueRealInterBarcodeData =
      interBarcodeVectors.toSet().toList();
  List<InterBarcodeVector> finalRealInterBarcodeData = [];
  for (InterBarcodeVector uniqueRealInterBarcodeData
      in uniqueRealInterBarcodeData) {
    //ii. find similar realInterBarcodeData.

    List<InterBarcodeVector> similarRealInterBarcodeData = interBarcodeVectors
        .where((element) => (element.startBarcodeUID ==
                uniqueRealInterBarcodeData.startBarcodeUID &&
            element.endBarcodeUID == uniqueRealInterBarcodeData.endBarcodeUID))
        .toList();

    //iii. Sort similarInterBarcodeOffsets by the length of the vector.
    similarRealInterBarcodeData
        .sort((a, b) => a.vector3.length.compareTo(b.vector3.length));

    //iv. Remove any outliers.
    //Indexes (Stats).
    int medianIndex = (similarRealInterBarcodeData.length ~/ 2);
    int quartile1Index = ((similarRealInterBarcodeData.length / 2) ~/ 2);
    int quartile3Index = medianIndex + quartile1Index;

    //Values of indexes.
    double median = similarRealInterBarcodeData[medianIndex].vector3.length;
    double quartile1 = calculateQuartileValue(
        similarRealInterBarcodeData, quartile1Index, median);
    double quartile3 = calculateQuartileValue(
        similarRealInterBarcodeData, quartile3Index, median);

    //Boundry calculations.
    double interQuartileRange = quartile3 - quartile1;
    double q1Boundry = quartile1 - interQuartileRange * 1.5; //Lower boundry
    double q3Boundry = quartile3 + interQuartileRange * 1.5; //Upper boundry

    //Remove data outside the boundries.
    similarRealInterBarcodeData.removeWhere((element) =>
        element.vector3.length <= q1Boundry &&
        element.vector3.length >= q3Boundry);

    //v. Caluclate the average.
    for (InterBarcodeVector similarInterBarcodeOffset
        in similarRealInterBarcodeData) {
      //Average the similar interBarcodeData.
      uniqueRealInterBarcodeData.vector3.x =
          (uniqueRealInterBarcodeData.vector3.x +
                  similarInterBarcodeOffset.vector3.x) /
              2;
      uniqueRealInterBarcodeData.vector3.y =
          (uniqueRealInterBarcodeData.vector3.y +
                  similarInterBarcodeOffset.vector3.y) /
              2;
      uniqueRealInterBarcodeData.vector3.z =
          (uniqueRealInterBarcodeData.vector3.z +
                  similarInterBarcodeOffset.vector3.z) /
              2;
    }
    //vi. Add to finalRealInterBarcodeData.
    finalRealInterBarcodeData.add(uniqueRealInterBarcodeData);
  }
  return finalRealInterBarcodeData;
}

//Calculates the quartile value.
double calculateQuartileValue(
    List<InterBarcodeVector> similarInterBarcodeOffsets,
    int quartile1Index,
    double median) {
  return (similarInterBarcodeOffsets[quartile1Index].vector3.length + median) /
      2;
}

///Generate a list of coordinates from a list of interBarcodeVectors and the origin container.
List<CatalogedCoordinate> generateCoordinates(
  int gridUID,
  List<InterBarcodeVector> interBarcodeVectors,
) {
  //1. Extract Barcodes
  List<String> barcodes = extractBarcodes(interBarcodeVectors);

  int timestamp = DateTime.now().millisecondsSinceEpoch;

  //2. Create a list of all possible coordiantes.
  List<CatalogedCoordinate> coordinates = barcodes
      .map(
        (e) => CatalogedCoordinate()
          ..barcodeUID = e
          ..gridUID = gridUID
          ..coordinate = null
          ..rotation = null
          ..timestamp = timestamp,
      )
      .toList();

  //3. Populate the Origin Coordinate.
  int index = coordinates.indexWhere((element) =>
      element.barcodeUID == isar!.catalogedGrids.getSync(gridUID)!.barcodeUID);

  if (index == -1) {
    coordinates.add(
      CatalogedCoordinate()
        ..barcodeUID = isar!.catalogedGrids.getSync(gridUID)!.barcodeUID
        ..coordinate = vm.Vector3(0, 0, 0)
        ..gridUID = gridUID
        ..rotation = null
        ..timestamp = DateTime.now().millisecondsSinceEpoch,
    );
  } else {
    coordinates[index].coordinate = vm.Vector3(0, 0, 0);
  }

  int nonNullPositions = 1;
  int nonNullPositionsInPreviousIteration = coordinates.length - 1;

  for (int i = 0; i <= interBarcodeVectors.length;) {
    nonNullPositionsInPreviousIteration = nonNullPositions;
    for (CatalogedCoordinate endBarcodeRealPosition in coordinates) {
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
        List<CatalogedCoordinate> confirmedPositions =
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
          CatalogedCoordinate startBarcode =
              confirmedPositions[startBarcodeIndex];
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
              endBarcodeRealPosition.coordinate = vm.Vector3(
                startBarcode.coordinate!.x +
                    relevantInterBarcodeVectors[interBarcodeOffsetIndex]
                        .vector3
                        .x,
                startBarcode.coordinate!.y +
                    relevantInterBarcodeVectors[interBarcodeOffsetIndex]
                        .vector3
                        .y,
                startBarcode.coordinate!.z +
                    relevantInterBarcodeVectors[interBarcodeOffsetIndex]
                        .vector3
                        .z,
              );
            } else if (relevantInterBarcodeVectors[interBarcodeOffsetIndex]
                    .startBarcodeUID ==
                endBarcodeRealPosition.barcodeUID) {
              endBarcodeRealPosition.coordinate = vm.Vector3(
                startBarcode.coordinate!.x -
                    relevantInterBarcodeVectors[interBarcodeOffsetIndex]
                        .vector3
                        .x,
                startBarcode.coordinate!.y -
                    relevantInterBarcodeVectors[interBarcodeOffsetIndex]
                        .vector3
                        .y,
                startBarcode.coordinate!.z -
                    relevantInterBarcodeVectors[interBarcodeOffsetIndex]
                        .vector3
                        .z,
              );

              // startBarcode.coordinate! +
              //     relevantInterBarcodeVectors[interBarcodeOffsetIndex].vector3;
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

Offset calculateUnitVectors(
    {required List<CatalogedCoordinate> coordinateEntries,
    required double width,
    required double height}) {
  double sX = 0;
  double bX = 0;
  double sY = 0;
  double bY = 0;

  for (var i = 0; i < coordinateEntries.length; i++) {
    CatalogedCoordinate catalogedCoordinate = coordinateEntries.elementAt(i);

    if (catalogedCoordinate.coordinate != null) {
      double xDistance = catalogedCoordinate.coordinate!.x;
      double yDistance = catalogedCoordinate.coordinate!.y;

      if (xDistance < sX) {
        sX = xDistance;
      }
      if (xDistance > bX) {
        bX = xDistance;
      }
      if (yDistance < sY) {
        sY = yDistance;
      }
      if (yDistance > bY) {
        bY = yDistance;
      }
    }
  }

  double totalXdistance = (sX - bX).abs() + 750;
  double totalYdistance = (sY - bY).abs() + 750;

  double unitX = width / 2 / totalXdistance;
  double unitY = height / 2 / totalYdistance;

  return Offset(unitX, unitY);
}
