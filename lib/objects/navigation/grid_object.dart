import 'dart:ui';

import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/functions/math_functionts/round_to_double.dart';
import 'package:flutter_google_ml_kit/functions/translating/unit_vectors.dart';
import 'package:flutter_google_ml_kit/isar_database/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/container_relationship/container_relationship.dart';
import 'package:flutter_google_ml_kit/isar_database/marker/marker.dart';
import 'package:flutter_google_ml_kit/isar_database/real_interbarcode_vector_entry/real_interbarcode_vector_entry.dart';
import 'package:flutter_google_ml_kit/objects/display/display_point.dart';
import 'package:flutter_google_ml_kit/objects/navigation/grid_position.dart';
import 'package:flutter_google_ml_kit/objects/navigation/navigator_data.dart';
import 'package:isar/isar.dart';
import 'package:vector_math/vector_math.dart' as vm;

class GridObject {
  GridObject({required this.originContainer});

  //The Grid's Origin Point.
  final ContainerEntry originContainer;

  late List<GridPosition> grid = gridPositions;
  late List<String> barcodes = getBarcodes;

  ///Markers contained in grid.
  List<Marker> get markers {
    return isarDatabase!.markers
        .filter()
        .parentContainerUIDMatches(originContainer.containerUID)
        .findAllSync();
  }

  ///The origin marker.
  Marker get originMarker {
    return markers
        .where((element) => element.barcodeUID == originContainer.barcodeUID)
        .first;
  }

  ///Find all the children of the Origin Container.
  List<ContainerEntry> get children {
    List<ContainerRelationship> containerRelationships = [];
    containerRelationships.addAll(isarDatabase!.containerRelationships
        .filter()
        .parentUIDMatches(originContainer.containerUID)
        .findAllSync());

    List<ContainerEntry> children = [];
    children.addAll(isarDatabase!.containerEntrys
        .filter()
        .repeat(
            containerRelationships,
            (q, ContainerRelationship element) =>
                q.containerUIDMatches(element.containerUID))
        .findAllSync());

    return children;
  }

  ///Get all the barcodes in the grid.
  List<String> get getBarcodes {
    List<String> barcodes = [];
    barcodes.addAll(children.map((e) => e.barcodeUID!).toList());
    barcodes.addAll(markers.map((e) => e.barcodeUID).toList());
    return barcodes;
  }

  ///Build the grid.
  List<GridPosition> get gridPositions {
    //log('calculating grid');
    if (children.isNotEmpty) {
      //Find all relevant barcodeUID's.
      List<String> relevantBarcodes =
          children.map((e) => e.barcodeUID!).toList();

      //Map them to GridPosition(s).
      List<GridPosition> gridPositions = relevantBarcodes
          .map((e) => GridPosition(barcodeUID: e, position: null))
          .toList();

      relevantBarcodes.addAll(markers.map((e) => e.barcodeUID));

      //Add the Origin.
      gridPositions.add(GridPosition(
          barcodeUID: originContainer.barcodeUID!,
          position: vm.Vector3(0, 0, 0)));

      //Add other markers to gridPositions.
      gridPositions.addAll(markers
          .where((element) => element.barcodeUID != originContainer.barcodeUID!)
          .map((e) => GridPosition(barcodeUID: e.barcodeUID, position: null)));

      //Find all relevant realInterBarcodeVectorEntrys.
      List<RealInterBarcodeVectorEntry> interBarcodevectorEntries = [];
      interBarcodevectorEntries.addAll(isarDatabase!
          .realInterBarcodeVectorEntrys
          .filter()
          .repeat(
              relevantBarcodes,
              (q, String element) => q
                  .startBarcodeUIDMatches(element)
                  .or()
                  .endBarcodeUIDMatches(element))
          .findAllSync());

      //Add all other barcodes that have been scanned with the relevant barcodes.
      List<String> allBarcodes = [];
      allBarcodes.addAll(
          interBarcodevectorEntries.map((e) => e.startBarcodeUID).toList());
      allBarcodes.addAll(
          interBarcodevectorEntries.map((e) => e.endBarcodeUID).toList());

      for (String item in allBarcodes) {
        if (!gridPositions.map((e) => e.barcodeUID).contains(item)) {
          gridPositions.add(GridPosition(barcodeUID: item, position: null));
        }
      }

      //Initialize variables.
      int nonNullPositions = 1;
      int nonNullPositionsInPreviousIteration = gridPositions.length - 1;

      for (int i = 0; i <= interBarcodevectorEntries.length;) {
        nonNullPositionsInPreviousIteration = nonNullPositions;
        for (GridPosition endBarcodeRealPosition in gridPositions) {
          if (endBarcodeRealPosition.position == null) {
            //startBarcode : The barcode that we are going to use as a reference (has offset relative to origin)
            //endBarcode : the barcode whose Real Position we are trying to find in this step , if we cant , we will skip and see if we can do so in the next round.
            // we are going to add the interbarcode offset between start and end barcodes to obtain the "position" of the end barcode.

            //This list contains all RealInterBarcode Offsets that contains the endBarcode.
            List<RealInterBarcodeVectorEntry> relevantInterBarcodeVectors =
                interBarcodevectorEntries
                    .where((element) =>
                        element.startBarcodeUID ==
                            endBarcodeRealPosition.barcodeUID ||
                        element.endBarcodeUID ==
                            endBarcodeRealPosition.barcodeUID)
                    .toList();

            //This list contains all realBarcodePositions with a Offset (effectivley to the Origin).
            List<GridPosition> confirmedPositions = gridPositions
                .where((element) => element.position != null)
                .toList();

            //Finds a relevant startBarcode based on the relevantInterbarcodeOffsets and BarcodesWithOffset.
            int startBarcodeIndex =
                confirmedPositions.indexWhere((barcodeWithOffsetToOrigin) {
              for (RealInterBarcodeVectorEntry singleInterBarcodeData
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

            // findStartBarcodeIndex(
            //     confirmedPositions, relevantBarcodeOffset);

            if (startBarcodeIndex != -1) {
              GridPosition startBarcode = confirmedPositions[startBarcodeIndex];

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
                  endBarcodeRealPosition.position = startBarcode.position! +
                      relevantInterBarcodeVectors[interBarcodeOffsetIndex]
                          .vector3;
                } else if (relevantInterBarcodeVectors[interBarcodeOffsetIndex]
                        .startBarcodeUID ==
                    endBarcodeRealPosition.barcodeUID) {
                  //Calculate the interBarcodeOffset
                  endBarcodeRealPosition.position = startBarcode.position! -
                      relevantInterBarcodeVectors[interBarcodeOffsetIndex]
                          .vector3;

                  //log(endBarcodeRealPosition.toString());
                }

                //log(startBarcode.startBarcodeDistanceFromCamera.toString());

                nonNullPositions++;
              }
            }
            //else "Skip"
          }
        }
        i++;
        //If all barcodes have been mapped it will break the loop.
        if (nonNullPositions == nonNullPositionsInPreviousIteration) {
          break;
        }
      }

      return gridPositions;
    }
    return [];
  }

  ///Calculate the onScreenPoints.
  List<DisplayPoint> displayPoints(Size screenSize) {
    List<GridPosition> positions = gridPositions;
    List<double> unitVector = unitVectors(
        realBarcodePositions: positions,
        width: screenSize.width,
        height: screenSize.height);

    List<DisplayPoint> myPoints = [];

    for (var i = 0; i < positions.length; i++) {
      GridPosition realBarcodePosition = positions.elementAt(i);
      if (realBarcodePosition.position != null) {
        Offset barcodePosition = Offset(
            (realBarcodePosition.position!.x * unitVector[0]) +
                (screenSize.width / 2) -
                (screenSize.width / 8),
            (realBarcodePosition.position!.y * unitVector[1]) +
                (screenSize.height / 2) -
                (screenSize.height / 8));

        List<double> barcodeRealPosition = [
          roundDouble(realBarcodePosition.position!.x, 5),
          roundDouble(realBarcodePosition.position!.y, 5),
          roundDouble(realBarcodePosition.position!.z, 5),
        ];

        if (markers
            .map((e) => e.barcodeUID)
            .contains(realBarcodePosition.barcodeUID)) {
          myPoints.add(DisplayPoint(
              isMarker: true,
              barcodeID: realBarcodePosition.barcodeUID,
              barcodePosition: barcodePosition,
              realBarcodePosition: barcodeRealPosition));
        } else {
          myPoints.add(DisplayPoint(
              isMarker: false,
              barcodeID: realBarcodePosition.barcodeUID,
              barcodePosition: barcodePosition,
              realBarcodePosition: barcodeRealPosition));
        }
      }
    }

    return myPoints;
  }

  ///Calculate the offset to a specified barcode, given navigator data.
  Offset calculateOffsetToBarcde({
    required List<NavigatorData> navigatorData,
    required String barcodeUID,
  }) {
    //1. Average the Navigator data to find realScreenCenter.
    Offset? realScreenCenter;
    for (var item in navigatorData.take(3)) {
      //Get the Grid Position
      GridPosition barcodePosition =
          grid.where((element) => element.barcodeUID == item.barcodeUID).first;

      Offset screenCenter =
          Offset(barcodePosition.position!.x, barcodePosition.position!.y) -
              item.offsetToScreenCenter;

      if (realScreenCenter == null) {
        realScreenCenter = screenCenter;
      } else {
        realScreenCenter = (realScreenCenter + screenCenter) / 2;
      }

      // log('Real SC: ' + realScreenCenter.toString());
    }

    //2. Calculate the offset to the barcode from realScreenCenter :D.

    GridPosition barcodePosition =
        grid.where((element) => element.barcodeUID == barcodeUID).first;
    Offset barcodeOffset =
        Offset(barcodePosition.position!.x, barcodePosition.position!.y);
    Offset offsetToBarcode = barcodeOffset - realScreenCenter!;

    //log(offsetToBarcode.toString());
    return offsetToBarcode;
  }

  @override
  String toString() {
    return
        /*Text*/
        '''____________________________________________________________________________
Origin : ${originContainer.containerUID},  Marker: ${originMarker.barcodeUID}
Markers: ${markers.map((e) => e.barcodeUID.toString())}
Chldren: ${children.map((e) => e.containerUID.toString())}
barcods: $getBarcodes
Vectors: ${gridPositions.length}
____________________________________________________________________________
''';
  }
}
