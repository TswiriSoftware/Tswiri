import 'dart:developer';

import 'package:flutter_google_ml_kit/isar_database/barcodes/interbarcode_vector_entry/interbarcode_vector_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_relationship/container_relationship.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_type/container_type.dart';
import 'package:isar/isar.dart';
import 'package:vector_math/vector_math.dart';

class MasterGrid {
  MasterGrid({
    required this.isarDatabase, // This is so it can build in an isolate.
  });

  ///Isardatabase reference.
  final Isar isarDatabase;

  ///Master List of ContainerEntries.
  late final List<ContainerEntry> containers =
      isarDatabase.containerEntrys.where().findAllSync();

  ///Master List of relationships.
  late final List<ContainerRelationship> relationships =
      isarDatabase.containerRelationships.where().findAllSync();

  ///Master List of containerTypes.
  late final List<ContainerType> types =
      isarDatabase.containerTypes.where().findAllSync();

  ///Master List of InterBarcodeVectors.
  late final List<InterBarcodeVectorEntry> vectors = isarDatabase
      .interBarcodeVectorEntrys
      .filter()
      .outDatedEqualTo(false)
      .findAllSync();

  ///List of coordinates. (Updateable)
  late List<Coordinate> coordinates = calculateCoordinates();

  ///List of relationships Trees. (Updateable)
  late List<Relationship> relationshipTrees = calculateRelationshipTrees();

  ///List of relationshipTrees.
  List<Relationship> calculateRelationshipTrees() {
    List<Relationship> relationshipsTrees = [];
    for (ContainerEntry container in containers) {
      List<String> tree = [container.containerUID];
      if (relationships
          .any((element) => element.containerUID == container.containerUID)) {
        String? parent = relationships
            .where((element) => element.containerUID == container.containerUID)
            .first
            .parentUID;

        ///Very Dangerous code this :D.
        int counter = 0; //THIS IS INCASE SOMETHING FUCKS UP.
        while (parent != null && counter < 25) {
          tree.add(parent);
          if (relationships.any((element) => element.containerUID == parent)) {
            parent = relationships
                .firstWhere((element) => element.containerUID == parent)
                .parentUID;
          } else {
            parent = null;
          }
          counter++;
        }
      }
      Relationship relationshipTree = Relationship(
          containerUID: container.containerUID,
          barcodeUID: container.barcodeUID!,
          treeList: tree);
      relationshipsTrees.add(relationshipTree);
    }

    return relationshipsTrees;
  }

  ///Calculate all the coordinates that can be calculated.
  List<Coordinate> calculateCoordinates() {
    //1. Find All origin containers (Containers that are Non-Moveable AND Non-Enclosing).
    //i. Valid ContainerTypes
    List<String> originContainerTypes = types
        .where((element) =>
            element.enclosing == false && element.moveable == false)
        .map((e) => e.containerType)
        .toList();

    //ii. Origin Containers
    List<ContainerEntry> originContainers = containers
        .where(
            (element) => originContainerTypes.contains(element.containerType))
        .toList();

    List<Coordinate> allCoordinates = [];

    //2. Build A grid for each Origin Container.
    for (ContainerEntry container in originContainers) {
      //i. Find Container's Children.
      List<String> childrenUIDs = relationships
          .where((element) => element.parentUID == container.containerUID)
          .map((e) => e.containerUID)
          .toList();

      List<ContainerEntry> children = containers
          .where((element) => childrenUIDs.contains(element.containerUID))
          .toList();

      List<String> barcodeUIDs = children.map((e) => e.barcodeUID!).toList();
      barcodeUIDs.add(container.barcodeUID!);

      //ii. Find relevant InterBarcodeData.
      List<InterBarcodeVectorEntry> interBarcodeVectors = vectors
          .where((element) =>
              barcodeUIDs.contains(element.endBarcodeUID) ||
              barcodeUIDs.contains(element.startBarcodeUID))
          .toList();

      //iii. Add other barcodes.
      for (InterBarcodeVectorEntry vector in interBarcodeVectors) {
        if (!barcodeUIDs.contains(vector.startBarcodeUID)) {
          barcodeUIDs.add(vector.startBarcodeUID);
        }
        if (!barcodeUIDs.contains(vector.endBarcodeUID)) {
          barcodeUIDs.add(vector.endBarcodeUID);
        }
      }

      //iv. Generate a list of all possible grid coordinates.
      List<Coordinate> coordinates = barcodeUIDs
          .map((e) => Coordinate(
              barcodeUID: e, coordinate: null, gridID: container.containerUID))
          .toList();

      //v. Populate the Origin Coordinate.
      coordinates
          .firstWhere((element) => element.barcodeUID == container.barcodeUID)
          .coordinate = Vector3(0, 0, 0);

      //Initialize variables for gridBuilding.
      int nonNullPositions = 1;
      int nonNullPositionsInPreviousIteration = coordinates.length - 1;

      for (int i = 0; i <= interBarcodeVectors.length;) {
        nonNullPositionsInPreviousIteration = nonNullPositions;
        for (Coordinate endBarcodeRealPosition in coordinates) {
          if (endBarcodeRealPosition.coordinate == null) {
            //We are going to add the interbarcode offset between start and end barcodes to obtain the "position" of the end barcode.

            //i. Find all InterBarcodeVectors that contains the EndBarcode.
            List<InterBarcodeVectorEntry> relevantInterBarcodeVectors =
                interBarcodeVectors
                    .where((element) =>
                        element.startBarcodeUID ==
                            endBarcodeRealPosition.barcodeUID ||
                        element.endBarcodeUID ==
                            endBarcodeRealPosition.barcodeUID)
                    .toList();

            //ii. Find the InterBarcodeVectors that already have a position. (effectivley to the Origin)
            List<Coordinate> confirmedPositions = coordinates
                .where((element) => element.coordinate != null)
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
                      relevantInterBarcodeVectors[interBarcodeOffsetIndex]
                          .vector3;
                } else if (relevantInterBarcodeVectors[interBarcodeOffsetIndex]
                        .startBarcodeUID ==
                    endBarcodeRealPosition.barcodeUID) {
                  //Calculate the interBarcodeOffset
                  endBarcodeRealPosition.coordinate = startBarcode.coordinate! -
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
      allCoordinates.addAll(coordinates);
    }

    //log(allCoordinates.toString());

    return allCoordinates;
  }

  ///Containers that do not have parents. (foundlings ?)
  List<ContainerEntry> orphanContainers() {
    List<ContainerEntry> orphans = [];
    for (var container in containers) {
      //Checks if a container has a parent.
      if (!relationships
          .any((element) => element.containerUID == container.containerUID)) {
        orphans.add(container);
      }
    }
    return orphans;
  }
}

class Coordinate {
  Coordinate({
    required this.barcodeUID,
    required this.coordinate,
    required this.gridID,
  });

  ///barcodeUID.
  final String barcodeUID;

  ///The absolute coordinate.
  late Vector3? coordinate;

  ///This is the grid this coordinate belongs too. (OriginContainerUID)
  final String gridID;

  @override
  String toString() {
    return '\nGridID: $gridID, barcodeUID: $barcodeUID, X: ${coordinate?.x}, Y: ${coordinate?.y}, Z: ${coordinate?.z}';
  }
}

class Relationship {
  Relationship({
    required this.containerUID,
    required this.barcodeUID,
    required this.treeList,
  });

  ///ContainerUID.
  final String containerUID;

  ///BarcodeUID.
  final String barcodeUID;

  ///The List of parent Containers.
  List<String> treeList;
  @override
  String toString() {
    return '\n$containerUID: $treeList';
  }
}
