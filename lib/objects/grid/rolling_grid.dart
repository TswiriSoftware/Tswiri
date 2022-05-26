import 'package:flutter_google_ml_kit/isar_database/barcodes/interbarcode_vector_entry/interbarcode_vector_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/barcodes/marker/marker.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_relationship/container_relationship.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_type/container_type.dart';
import 'package:flutter_google_ml_kit/objects/grid/master_grid.dart';
import 'package:isar/isar.dart';
import 'package:vector_math/vector_math.dart';

class RollingGrid {
  RollingGrid({
    required this.isarDatabase,
  });
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

  ///Master List of Markers.
  late final List<Marker> markers = isarDatabase.markers.where().findAllSync();

  late List<IndependantRollingGrid> independantRollingGrids = [];

  //1. Require a List of grids containing parents and markers.

  void initiate(MasterGrid masterGrid) {
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

    //iii. List the independantRolling Grids.
    List<IndependantRollingGrid> newIndependantRollingGrids =
        originContainers.map((e) => IndependantRollingGrid(parent: e)).toList();

    //iv. Populate Origin and Markers
    masterGrid.calculateCoordinates();
    List<Coordinate> coordinates = masterGrid.coordinates ?? [];
    for (IndependantRollingGrid independantRollingGrid
        in newIndependantRollingGrids) {
      independantRollingGrid.markers.addAll(markers.where((marker) =>
          marker.parentContainerUID == independantRollingGrid.gridID));

      List<Coordinate> currentCoordinates = coordinates
          .where((coordinate) =>
              coordinate.barcodeUID ==
                  independantRollingGrid.parent.barcodeUID &&
              coordinate.gridID == independantRollingGrid.gridID)
          .toList();

      currentCoordinates.addAll(
        coordinates.where(
          (coordinate) =>
              coordinate.gridID == independantRollingGrid.gridID &&
              coordinate.barcodeUID !=
                  independantRollingGrid.parent.barcodeUID &&
              independantRollingGrid.markers
                  .map((e) => e.barcodeUID)
                  .contains(coordinate.barcodeUID),
        ),
      );

      independantRollingGrid.coordinates.addAll(currentCoordinates);
    }
    independantRollingGrids.addAll(newIndependantRollingGrids);
  }
}

class IndependantRollingGrid {
  IndependantRollingGrid({required this.parent});
  final ContainerEntry parent;
  late String gridID = parent.containerUID;
  List<Marker> markers = [];
  List<Coordinate> coordinates = [];

  List<String> markerBarcodes() {
    List<String> markersBarcodes = markers.map((e) => e.barcodeUID).toList();
    markersBarcodes.add(parent.barcodeUID!);
    return markersBarcodes;
  }

  void addCoordinate(InterBarcodeVectorEntry interBarcodeVectorEntry) {
    Coordinate referenceCoordiante = coordinates
        .where((element) =>
            element.barcodeUID == interBarcodeVectorEntry.startBarcodeUID ||
            element.barcodeUID == interBarcodeVectorEntry.endBarcodeUID)
        .first;
    Coordinate? newCoordinate;
    if (referenceCoordiante.barcodeUID ==
        interBarcodeVectorEntry.startBarcodeUID) {
      Vector3 vector3 =
          referenceCoordiante.coordinate! - interBarcodeVectorEntry.vector3;
      newCoordinate = Coordinate(
          barcodeUID: interBarcodeVectorEntry.endBarcodeUID,
          coordinate: vector3,
          gridID: gridID);
    } else {
      Vector3 vector3 =
          referenceCoordiante.coordinate! + interBarcodeVectorEntry.vector3;
      newCoordinate = Coordinate(
          barcodeUID: interBarcodeVectorEntry.startBarcodeUID,
          coordinate: vector3,
          gridID: gridID);
    }
    if (!coordinates.contains(newCoordinate)) {
      coordinates.add(newCoordinate);
    }
  }

  @override
  String toString() {
    return '''
__________________GRID ID: ${parent.containerUID} __________________
parent: ${parent.barcodeUID},
markers: $markers
coordinates: $coordinates

''';
  }
}
