import 'dart:developer';
import 'dart:ui';

import 'package:flutter_google_ml_kit/functions/math_functionts/round_to_double.dart';
import 'package:flutter_google_ml_kit/functions/translating/unit_vectors.dart';
import 'package:flutter_google_ml_kit/isar_database/barcodes/interbarcode_vector_entry/interbarcode_vector_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/barcodes/marker/marker.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_relationship/container_relationship.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_type/container_type.dart';
import 'package:flutter_google_ml_kit/objects/display/display_point.dart';
import 'package:flutter_google_ml_kit/objects/grid/position.dart';
import 'package:isar/isar.dart';
import 'package:vector_math/vector_math.dart';

class GridBuilder {
  GridBuilder({
    required this.isarDatabase, // This is so it can build in an isolate
  });
  Isar isarDatabase;
  //1. List of independant grids -(based on relationships)
  //  i - If a container has a child it is clasified as a independant grid.
  //  ii- If the container enclosing then it forms part of the independant grid else it does not.
  //late List<IndependantGrid> independantGrids = grids;

  List<IndependantGrid> get grids {
    //1. We find containers with at least one child.
    List<ContainerEntry> allContainers =
        isarDatabase.containerEntrys.where().findAllSync();

    List<ContainerRelationship> containerRelationShips =
        isarDatabase.containerRelationships.where().findAllSync();

    List<ContainerEntry> parentContainers = [];

    for (var container in allContainers) {
      if (containerRelationShips
          .where((element) => element.parentUID == container.containerUID)
          .isNotEmpty) {
        parentContainers.add(container);
      }
    }
    List<IndependantGrid> grids = parentContainers
        .map((e) =>
            IndependantGrid(parentContainer: e, isarDatabase: isarDatabase))
        .toList();

    return grids;
  }

  IndependantGrid independantGrid(ContainerEntry parentContainer) {
    return IndependantGrid(
        parentContainer: parentContainer, isarDatabase: isarDatabase);
  }
}

///A grid that can be independently navigated.
class IndependantGrid {
  IndependantGrid({required this.parentContainer, required this.isarDatabase});

  Isar isarDatabase;

  ///Parent Container
  final ContainerEntry parentContainer;

  ///Container Type.
  late ContainerType containerType = isarDatabase.containerTypes
      .filter()
      .containerTypeMatches(parentContainer.containerType)
      .findFirstSync()!;

  ///Markers.
  late List<Marker> markers = isarDatabase.markers
      .filter()
      .parentContainerUIDMatches(parentContainer.containerUID)
      .findAllSync();

  ///Children.
  late List<ContainerEntry> children = findChildren;

  ///Grid Barcodes.
  late List<String> barcodes = findBarcodes;

  ///All Positions in the grid
  late List<Position> allPositions = buildGrid;

  ///All Non-Null Positions in the grid
  late List<Position> validPositions =
      allPositions.where((element) => element.position != null).toList();

  ///Find all the barcodes in the grid.
  List<String> get findBarcodes {
    List<String> foundBarcodes = [];
    //Add parent container barcode.
    if (containerType.enclosing) {
      foundBarcodes.add(parentContainer.barcodeUID!);
    }
    //Add markers
    foundBarcodes.addAll(markers.map((e) => e.barcodeUID));

    //Add Containers
    foundBarcodes.addAll(children.map((e) => e.barcodeUID!));

    return foundBarcodes;
  }

  ///Find all the children of the grid.
  List<ContainerEntry> get findChildren {
    List<ContainerRelationship> containerRelationships = isarDatabase
        .containerRelationships
        .filter()
        .parentUIDMatches(parentContainer.containerUID)
        .findAllSync();

    List<ContainerEntry> childrenContainers = isarDatabase.containerEntrys
        .filter()
        .repeat(
            containerRelationships,
            (q, ContainerRelationship element) =>
                q.containerUIDMatches(element.containerUID))
        .findAllSync();

    return childrenContainers;
  }

  ///Build the grid.
  List<Position> get buildGrid {
    if (children.isNotEmpty) {
      //1. Generate possible gridPositions.
      List<Position> gridPositions = [];

      //i. Add the parent container.
      gridPositions.add(Position(
          barcodeUID: parentContainer.barcodeUID!, position: Vector3(0, 0, 0)));

      //ii. Add the markers.
      gridPositions.addAll(markers
          .map((e) => Position(barcodeUID: e.barcodeUID, position: null)));

      //iii. Add children.
      gridPositions.addAll(children
          .map((e) => Position(barcodeUID: e.barcodeUID!, position: null)));

      ///iv. Remove duplicates.
      gridPositions.toSet().toList();

      //2. Find all relevant realInterBarcodeVectorEntrys.
      List<InterBarcodeVectorEntry> interBarcodevectorEntries = [];
      interBarcodevectorEntries.addAll(isarDatabase.interBarcodeVectorEntrys
          .filter()
          .repeat(
              barcodes,
              (q, String element) => q
                  .startBarcodeUIDMatches(element)
                  .or()
                  .endBarcodeUIDMatches(element))
          .findAllSync());

      //3. Add new barcodes from interBarcodeVectors.
      List<String> allBarcodes = [];
      //i. StartBarcodes.
      allBarcodes.addAll(
          interBarcodevectorEntries.map((e) => e.startBarcodeUID).toList());
      //ii. EndBarcodes.
      allBarcodes.addAll(
          interBarcodevectorEntries.map((e) => e.endBarcodeUID).toList());

      for (String item in allBarcodes) {
        if (!gridPositions.map((e) => e.barcodeUID).contains(item)) {
          gridPositions.add(Position(barcodeUID: item, position: null));
        }
      }

      //Initialize variables for gridBuilding.
      int nonNullPositions = 1;
      int nonNullPositionsInPreviousIteration = gridPositions.length - 1;

      for (int i = 0; i <= interBarcodevectorEntries.length;) {
        nonNullPositionsInPreviousIteration = nonNullPositions;
        for (Position endBarcodeRealPosition in gridPositions) {
          if (endBarcodeRealPosition.position == null) {
            //We are going to add the interbarcode offset between start and end barcodes to obtain the "position" of the end barcode.

            //i. Find all InterBarcodeVectors that contains the EndBarcode.
            List<InterBarcodeVectorEntry> relevantInterBarcodeVectors =
                interBarcodevectorEntries
                    .where((element) =>
                        element.startBarcodeUID ==
                            endBarcodeRealPosition.barcodeUID ||
                        element.endBarcodeUID ==
                            endBarcodeRealPosition.barcodeUID)
                    .toList();

            //ii. Find the InterBarcodeVectors that already have a position. (effectivley to the Origin)
            List<Position> confirmedPositions = gridPositions
                .where((element) => element.position != null)
                .toList();

            //iii. Find a startBarcode with a position to calculate the endBarcode Position.
            int startBarcodeIndex =
                confirmedPositions.indexWhere((barcodeWithOffsetToOrigin) {
              for (InterBarcodeVectorEntry singleInterBarcodeData
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
              Position startBarcode = confirmedPositions[startBarcodeIndex];
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
      return gridPositions;
    }
    return [];
  }

  ///Calculate the onScreenPoints.
  List<DisplayPoint> displayPoints(Size screenSize) {
    List<Position> positions = allPositions;
    //log(allPositions.toString());

    List<double> unitVector = unitVectors(
        realBarcodePositions: positions,
        width: screenSize.width,
        height: screenSize.height);

    List<DisplayPoint> myPoints = [];

    for (var i = 0; i < positions.length; i++) {
      Position realBarcodePosition = positions.elementAt(i);
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
              barcodeUID: realBarcodePosition.barcodeUID,
              barcodePosition: barcodePosition,
              realBarcodePosition: barcodeRealPosition));
        } else {
          myPoints.add(DisplayPoint(
              isMarker: false,
              barcodeUID: realBarcodePosition.barcodeUID,
              barcodePosition: barcodePosition,
              realBarcodePosition: barcodeRealPosition));
        }
      }
    }
    return myPoints;
  }

  @override
  String toString() {
    return '''

____________________INDEPENDANT GRID__________________________(ID: ${parentContainer.id})
Parent: ${parentContainer.containerUID}
Children: ${children.map((e) => '${e.containerUID} : ${e.id}').toList()} (${children.length})
Barcodes: ${barcodes.toList()} (${barcodes.length})
Valid Positions: ${allPositions.where((element) => element.position != null).length}
''';
  }
}
