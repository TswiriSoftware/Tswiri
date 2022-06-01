import 'dart:developer';
import 'dart:ui';

import 'package:flutter_google_ml_kit/functions/math_functionts/round_to_double.dart';
import 'package:flutter_google_ml_kit/functions/translating/unit_vectors.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_relationship/container_relationship.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_type/container_type.dart';
import 'package:flutter_google_ml_kit/isar_database/grid/coordinate_entry/coordinate_entry.dart';
import 'package:flutter_google_ml_kit/objects/display/display_point.dart';
import 'package:isar/isar.dart';

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

  late final List<CoordinateEntry> coordinateEntries =
      isarDatabase.coordinateEntrys.where().findAllSync();

  ///Find all coordinates related to this gridUID.
  List<CoordinateEntry> findGridCoordinates(String gridUID) {
    return coordinateEntries
        .where((element) => element.gridUID == gridUID)
        .toList();
  }

  ///This returns a list of displayPoints (Takes into account the screen size)
  List<DisplayPoint> createDisplayPoints(String gridUID, Size size) {
    List<CoordinateEntry> coordinates = findGridCoordinates(gridUID);
    List<double> unitVector = calculateUnitVectors(
      coordinateEntries: coordinates,
      width: size.width,
      height: size.height,
    );

    List<DisplayPoint> myPoints = [];

    for (var i = 0; i < coordinates.length; i++) {
      CoordinateEntry coordinate = coordinates.elementAt(i);

      if (coordinate.vector() != null) {
        Offset barcodePosition = Offset(
            (coordinate.vector()!.x * unitVector[0]) +
                (size.width / 2) -
                (size.width / 8),
            (coordinate.vector()!.y * unitVector[1]) +
                (size.height / 2) -
                (size.height / 8));

        List<double> barcodeRealPosition = [
          roundDouble(coordinate.vector()!.x, 5),
          roundDouble(coordinate.vector()!.y, 5),
          roundDouble(coordinate.vector()!.z, 5),
        ];

        myPoints.add(DisplayPoint(
            barcodeUID: coordinate.barcodeUID,
            screenPosition: barcodePosition,
            realPosition: barcodeRealPosition));
      }
    }

    return myPoints;
  }

  ///Returns a matching coordinate if it exists.
  CoordinateEntry? findCoordinate(CoordinateEntry coordinateEntry) {
    int index = coordinateEntries.indexWhere(
        (element) => element.barcodeUID == coordinateEntry.barcodeUID);
    if (index != -1) {
      return coordinateEntries[index];
    }
    return null;
  }

  ///Updates a coordinate in memory.
  void updateCoordinateMem(CoordinateEntry coordinateEntry) {
    log('updating coordiante: $coordinateEntry');
    coordinateEntries.removeWhere(
        (element) => element.barcodeUID == coordinateEntry.barcodeUID);
    coordinateEntries.add(coordinateEntry);
  }

  ///Updates a coordinate in Isardatabase.
  void updateCoordinateIsar(CoordinateEntry newCoordinate) {
    CoordinateEntry? oldCoordinate = isarDatabase.coordinateEntrys
        .filter()
        .barcodeUIDMatches(newCoordinate.barcodeUID)
        .findFirstSync();

    if (oldCoordinate != null) {
      if (oldCoordinate.gridUID != newCoordinate.gridUID) {
        //Find the relevant container.
        ContainerEntry containerEntry = isarDatabase.containerEntrys
            .filter()
            .barcodeUIDMatches(oldCoordinate.barcodeUID)
            .findFirstSync()!;

        //Find the relevant relationship.
        ContainerRelationship containerRelationship = isarDatabase
            .containerRelationships
            .filter()
            .containerUIDMatches(containerEntry.containerUID)
            .findFirstSync()!;

        //Find the new ContainerParent
        ContainerEntry parentContainer = isarDatabase.containerEntrys
            .filter()
            .barcodeUIDMatches(newCoordinate.gridUID)
            .findFirstSync()!;

        ContainerRelationship newContainerRelationship = ContainerRelationship()
          ..containerUID = containerEntry.containerUID
          ..parentUID = parentContainer.containerUID;

        isarDatabase.writeTxnSync((isar) {
          isar.containerRelationships.deleteSync(containerRelationship.id);
          isar.containerRelationships
              .putSync(newContainerRelationship, replaceOnConflict: true);
        });
      }

      isarDatabase.writeTxnSync((isar) {
        //Delete the old coordinate.
        isar.coordinateEntrys.deleteSync(oldCoordinate.id);
        //Add the new coordinate.
        isar.coordinateEntrys.putSync(newCoordinate, replaceOnConflict: true);
      });
    }
  }

/////////////////////////////////???DISPOSE???/////////////////////////////////

  ///List of coordinates. (Updateable)
  //List<Coordinate>? coordinates;

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

  // ///Calculate all the coordinates that can be calculated.
  // void calculateCoordinates() {
  //   //1. Find All origin containers (Containers that are Non-Moveable AND Non-Enclosing).
  //   //i. Valid ContainerTypes
  //   List<String> originContainerTypes = types
  //       .where((element) =>
  //           element.enclosing == false && element.moveable == false)
  //       .map((e) => e.containerType)
  //       .toList();

  //   //ii. Origin Containers
  //   List<ContainerEntry> originContainers = containers
  //       .where(
  //           (element) => originContainerTypes.contains(element.containerType))
  //       .toList();

  //   List<Coordinate> allCoordinates = [];

  //   //2. Build A grid for each Origin Container.
  //   for (ContainerEntry container in originContainers) {
  //     //i. Find Container's Children.
  //     List<String> childrenUIDs = relationships
  //         .where((element) => element.parentUID == container.containerUID)
  //         .map((e) => e.containerUID)
  //         .toList();

  //     List<ContainerEntry> children = containers
  //         .where((element) => childrenUIDs.contains(element.containerUID))
  //         .toList();

  //     List<String> barcodeUIDs = children.map((e) => e.barcodeUID!).toList();
  //     barcodeUIDs.add(container.barcodeUID!);

  //     //ii. Find relevant InterBarcodeData.
  //     List<InterBarcodeVectorEntry> interBarcodeVectors = vectors
  //         .where((element) =>
  //             barcodeUIDs.contains(element.endBarcodeUID) ||
  //             barcodeUIDs.contains(element.startBarcodeUID))
  //         .toList();

  //     //iii. Add other barcodes.
  //     for (InterBarcodeVectorEntry vector in interBarcodeVectors) {
  //       if (!barcodeUIDs.contains(vector.startBarcodeUID)) {
  //         barcodeUIDs.add(vector.startBarcodeUID);
  //       }
  //       if (!barcodeUIDs.contains(vector.endBarcodeUID)) {
  //         barcodeUIDs.add(vector.endBarcodeUID);
  //       }
  //     }

  //     //iv. Generate a list of all possible grid coordinates.
  //     List<Coordinate> coordinates = barcodeUIDs
  //         .map((e) => Coordinate(
  //             barcodeUID: e, coordinate: null, gridID: container.containerUID))
  //         .toList();

  //     //v. Populate the Origin Coordinate.
  //     coordinates
  //         .firstWhere((element) => element.barcodeUID == container.barcodeUID)
  //         .coordinate = Vector3(0, 0, 0);

  //     //Initialize variables for gridBuilding.
  //     int nonNullPositions = 1;
  //     int nonNullPositionsInPreviousIteration = coordinates.length - 1;

  //     for (int i = 0; i <= interBarcodeVectors.length;) {
  //       nonNullPositionsInPreviousIteration = nonNullPositions;
  //       for (Coordinate endBarcodeRealPosition in coordinates) {
  //         if (endBarcodeRealPosition.coordinate == null) {
  //           //We are going to add the interbarcode offset between start and end barcodes to obtain the "position" of the end barcode.

  //           //i. Find all InterBarcodeVectors that contains the EndBarcode.
  //           List<InterBarcodeVectorEntry> relevantInterBarcodeVectors =
  //               interBarcodeVectors
  //                   .where((element) =>
  //                       element.startBarcodeUID ==
  //                           endBarcodeRealPosition.barcodeUID ||
  //                       element.endBarcodeUID ==
  //                           endBarcodeRealPosition.barcodeUID)
  //                   .toList();

  //           //ii. Find the InterBarcodeVectors that already have a position. (effectivley to the Origin)
  //           List<Coordinate> confirmedPositions = coordinates
  //               .where((element) => element.coordinate != null)
  //               .toList();

  //           //iii. Find a startBarcode with a position to calculate the endBarcode Position.
  //           int startBarcodeIndex =
  //               confirmedPositions.indexWhere((barcodeWithOffsetToOrigin) {
  //             for (InterBarcodeVectorEntry singleInterBarcodeData
  //                 in relevantInterBarcodeVectors) {
  //               if (singleInterBarcodeData.startBarcodeUID ==
  //                       barcodeWithOffsetToOrigin.barcodeUID ||
  //                   singleInterBarcodeData.endBarcodeUID ==
  //                       barcodeWithOffsetToOrigin.barcodeUID) {
  //                 return true;
  //               }
  //             }
  //             return false;
  //           });

  //           if (startBarcodeIndex != -1) {
  //             Coordinate startBarcode = confirmedPositions[startBarcodeIndex];
  //             //Index of InterBarcodeOffset which contains startBarcode.
  //             int interBarcodeOffsetIndex =
  //                 relevantInterBarcodeVectors.indexWhere((element) {
  //               if ((startBarcode.barcodeUID == element.startBarcodeUID &&
  //                       endBarcodeRealPosition.barcodeUID ==
  //                           element.endBarcodeUID) ||
  //                   (startBarcode.barcodeUID == element.endBarcodeUID &&
  //                       endBarcodeRealPosition.barcodeUID ==
  //                           element.startBarcodeUID)) {
  //                 return true;
  //               }
  //               return false;
  //             });

  //             if (interBarcodeOffsetIndex != -1) {
  //               //Determine whether to add or subtract the interBarcode Offset.

  //               if (relevantInterBarcodeVectors[interBarcodeOffsetIndex]
  //                       .endBarcodeUID ==
  //                   endBarcodeRealPosition.barcodeUID) {
  //                 //Calculate the interBarcodeOffset
  //                 endBarcodeRealPosition.coordinate = startBarcode.coordinate! +
  //                     relevantInterBarcodeVectors[interBarcodeOffsetIndex]
  //                         .vector3;
  //               } else if (relevantInterBarcodeVectors[interBarcodeOffsetIndex]
  //                       .startBarcodeUID ==
  //                   endBarcodeRealPosition.barcodeUID) {
  //                 //Calculate the interBarcodeOffset
  //                 endBarcodeRealPosition.coordinate = startBarcode.coordinate! -
  //                     relevantInterBarcodeVectors[interBarcodeOffsetIndex]
  //                         .vector3;
  //               }
  //               nonNullPositions++;
  //             }
  //           }
  //         }
  //       }
  //       i++;
  //       //If all barcodes have been mapped it will break the loop.
  //       if (nonNullPositions == nonNullPositionsInPreviousIteration) {
  //         break;
  //       }
  //     }
  //     allCoordinates.addAll(coordinates);
  //   }
  //   coordinates = allCoordinates;
  // }

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

// class Coordinate {
//   Coordinate({
//     required this.barcodeUID,
//     required this.coordinate,
//     required this.gridID,
//   });

//   ///barcodeUID.
//   final String barcodeUID;

//   ///The absolute coordinate.
//   late Vector3? coordinate;

//   ///This is the grid this coordinate belongs too. (OriginContainerUID)
//   final String gridID;

//   @override
//   bool operator ==(Object other) {
//     if (other is Coordinate) {
//       return hashCode == other.hashCode;
//     } else {
//       return hashCode == other.hashCode;
//     }
//   }

//   @override
//   int get hashCode => barcodeUID.hashCode;

//   @override
//   String toString() {
//     return '\nGridID: $gridID, barcodeUID: $barcodeUID, X: ${coordinate?.x}, Y: ${coordinate?.y}, Z: ${coordinate?.z}';
//   }

//   Map toJson() => {
//         'barcodeUID': barcodeUID,
//         'x': coordinate?.x,
//         'y': coordinate?.y,
//         'z': coordinate?.z,
//         'gridID': gridID,
//       };

//   factory Coordinate.fromJson(json) {
//     return Coordinate(
//         barcodeUID: json['barcodeUID'],
//         coordinate: Vector3(
//           json['x'] as double,
//           json['y'] as double,
//           json['z'] as double,
//         ),
//         gridID: json['gridID']);
//   }
// }

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
