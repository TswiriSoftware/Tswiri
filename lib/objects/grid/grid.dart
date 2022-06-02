// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_google_ml_kit/isar_database/barcodes/marker/marker.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_relationship/container_relationship.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_type/container_type.dart';
import 'package:flutter_google_ml_kit/isar_database/grid/coordinate_entry/coordinate_entry.dart';
import 'package:flutter_google_ml_kit/objects/grid/interbarcode_vector.dart';
import 'package:flutter_google_ml_kit/objects/grid/master_grid.dart';
import 'package:vector_math/vector_math.dart';
import 'package:isar/isar.dart';

class Grid {
  Grid({
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

  late List<CoordinateEntry> coordinates = [];

  //1. Initiates the grid by populating origins and markers.
  void initiate(MasterGrid masterGrid) {
    //Coordinates.
    List<CoordinateEntry> coordinateEntries =
        isarDatabase.coordinateEntrys.where().findAllSync();

    List<String> startBarcodes = [];
    //Add all gridUIDs
    startBarcodes.addAll(isarDatabase.coordinateEntrys
        .where()
        .gridUIDProperty()
        .findAllSync()
        .toSet()
        .toList());
    //Add all MarkerUIDs
    startBarcodes.addAll(markers.map((e) => e.barcodeUID).toList());
    //Remove Duplicates.
    startBarcodes.toSet().toList();

    for (CoordinateEntry coordinateEntry in coordinateEntries) {
      if (startBarcodes.contains(coordinateEntry.barcodeUID)) {
        coordinates.add(coordinateEntry);
      }
    }
  }

  //Adds a new coordiante given a vecto
  CoordinateEntry? addCoordiante(InterBarcodeVector vector) {
    //1. find the reference coordinate.
    CoordinateEntry referenceCoordinate = coordinates.firstWhere((element) =>
        element.barcodeUID == vector.startBarcodeUID ||
        element.barcodeUID == vector.endBarcodeUID);

    CoordinateEntry? newCoordinate;
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    if (referenceCoordinate.barcodeUID == vector.startBarcodeUID) {
      Vector3 vector3 = referenceCoordinate.vector()! + vector.vector3;
      newCoordinate = CoordinateEntry()
        ..barcodeUID = vector.endBarcodeUID
        ..gridUID = referenceCoordinate.gridUID
        ..timestamp = timestamp
        ..x = vector3.x
        ..y = vector3.y
        ..z = vector3.z;
    } else {
      Vector3 vector3 = referenceCoordinate.vector()! - vector.vector3;
      newCoordinate = CoordinateEntry()
        ..barcodeUID = vector.startBarcodeUID
        ..gridUID = referenceCoordinate.gridUID
        ..timestamp = timestamp
        ..x = vector3.x
        ..y = vector3.y
        ..z = vector3.z;
    }
    if (!coordinates.contains(newCoordinate)) {
      coordinates.add(newCoordinate);
      return newCoordinate;
    }

    return null;
  }
}
