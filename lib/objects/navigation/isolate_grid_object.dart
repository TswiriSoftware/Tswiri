import 'package:flutter_google_ml_kit/isar_database/marker/marker.dart';
import 'package:flutter_google_ml_kit/objects/navigation/grid_object.dart';
import 'package:flutter_google_ml_kit/objects/navigation/grid_position.dart';

///This Grid Object is made to be sent though a sendPort with Json
class IsolateGridObject {
  IsolateGridObject({
    required this.gridPositions,
    required this.markers,
  });
  //List of all grid positions
  List<GridPosition> gridPositions;
  //List of all markers in grid.
  List<Marker> markers;

  Map toJson() {
    return {
      'grid': gridPositions,
      'markers': markers,
    };
  }

  factory IsolateGridObject.fromJson(dynamic json) {
    List<dynamic> gridList = json['grid'];
    List<GridPosition> gridPositions =
        List<GridPosition>.from(gridList.map((e) => GridPosition.fromJson(e)));

    List<dynamic> markerList = json['markers'];
    List<Marker> markers =
        List<Marker>.from(markerList.map((e) => Marker().fromJson(e)));
    return IsolateGridObject(
      gridPositions: gridPositions,
      markers: markers,
    );
  }

  factory IsolateGridObject.fromGridObject(GridObject gridObject) {
    return IsolateGridObject(
      gridPositions: gridObject.grid,
      markers: gridObject.markers,
    );
  }

  @override
  String toString() {
    return '''______________________
positions: $gridPositions
markers: $markers
______________________''';
  }
}

///Used to build a rolling grid.
class RollingGridObject {
  RollingGridObject({required this.markers});
  List<Marker> markers;
  List<GridPosition> grid = [];

  void initiateGrid(
      List<Marker> markers, List<GridPosition> initialGridPositions) {
    for (Marker marker in markers) {
      GridPosition initalMarker = initialGridPositions
          .where((element) => element.barcodeUID == marker.barcodeUID)
          .first;
      grid.add(GridPosition(
          barcodeUID: marker.barcodeUID, position: initalMarker.position));
    }
  }

  void updateGrid() {}

  @override
  String toString() {
    return '''______________________
markers: $markers
positions: $grid      
        ______________________''';
  }
}
