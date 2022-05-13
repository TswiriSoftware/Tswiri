import 'dart:convert';
import 'dart:developer';

import 'package:flutter_google_ml_kit/isar_database/containers/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/barcodes/marker/marker.dart';
import 'package:flutter_google_ml_kit/objects/grid/grid.dart';
import 'package:flutter_google_ml_kit/objects/grid/position.dart';
import 'package:flutter_google_ml_kit/objects/grid/positional_grid.dart';
import 'package:flutter_google_ml_kit/objects/navigation/isolate/rolling_grid_position.dart';

class IsolateGrid {
  IsolateGrid({
    required this.positionalGrids,
  });
  List<IsolatePositionalGrid> positionalGrids;

  List pathFinder(String startBarcodeUID, String endBarcodeUID) {
    //1. Find Start Positional Grid.

    log(positionalGrids.toString());

    // for (var i = 0; i < positionalGrids.length; i++) {
    //   log(startPath.last.parent.toString());

    //   if (startPath.last.parent != null) {
    //     IsolatePositionalGrid x = positionalGrids
    //         .firstWhere((element) => element.origin == startPath.last.parent);
    //     startPath.add(x);
    //   }
    // }

    // while (startPath.last?.parent != null) {
    //   IsolatePositionalGrid? x = positionalGrids.firstWhere((element) =>
    //       element.barcodes.contains(startPath.last!.parent!.barcodeUID));

    //   startPath.add(x);
    //   log(startPath.toString());
    // }

    // //2. Find End Positional Grid.
    // PositionalGrid? endGrid = grids
    //     .firstWhere((element) => element.getBarcodes.contains(endBarcodeUID));

    return [];
  }

  Map toJson() => {
        'positionalGrids': jsonEncode(positionalGrids),
      };

  factory IsolateGrid.fromJson(Map<String, dynamic> json) {
    List<dynamic> grids = jsonDecode(json['positionalGrids']);
    List<IsolatePositionalGrid> positionalGrid =
        grids.map((e) => IsolatePositionalGrid.fromJson(e)).toList();
    return IsolateGrid(positionalGrids: positionalGrid);
  }

  factory IsolateGrid.fromGrid(Grid grid) {
    List<IsolatePositionalGrid> isolatePositionalGrids = grid.positionalGrids
        .map((e) => IsolatePositionalGrid.fromPositionalGrid(e))
        .toList();
    return IsolateGrid(positionalGrids: isolatePositionalGrids);
  }

  @override
  String toString() {
    return '''______________________________________
    IsolateGrid

positionalGrids: ${positionalGrids.length}
Origins: ${positionalGrids.map((e) => e.origin.barcodeUID)}

______________________________________''';
  }
}

class IsolatePositionalGrid {
  IsolatePositionalGrid({
    required this.origin,
    required this.parent,
    required this.children,
    required this.markers,
    required this.positions,
    required this.barcodes,
  });

  ///Origin Container [ContainerEntry]
  final ContainerEntry origin;

  ///Parent Container [ContainerEntry]?
  final ContainerEntry? parent;

  ///Children [List]
  final List<ContainerEntry> children;

  ///Markers [List]
  final List<Marker> markers;

  ///Positions [List]
  final List<Position> positions;

  ///Barcodes [List]
  final List<String> barcodes;

  void updatePosition(RollingGridPosition rollingGridPosition) {
    positions
        .where(
            (element) => element.barcodeUID == rollingGridPosition.barcodeUID)
        .first
        .position = rollingGridPosition.position;
  }

  bool comparePosition(RollingGridPosition rollingGridPosition) {
    int relevantPositionIndex = positions.indexWhere(
        (element) => element.barcodeUID == rollingGridPosition.barcodeUID);

    if (relevantPositionIndex != -1) {
      Position relevantPosition = positions[relevantPositionIndex];

      if (rollingGridPosition.position != null &&
          relevantPosition.position != null) {
        //This is to calculate the amount of positional error we allow for in mm.

        double errorValue = 20; // max error value in mm
        double currentX = rollingGridPosition.position!.x;
        double currentXLowerBoundry = currentX - (errorValue);
        double currentXUpperBoundry = currentX + (errorValue);

        double currentY = rollingGridPosition.position!.y;
        double currentYLowerBoundry = currentY - (errorValue);
        double currentYUpperBoundry = currentY + (errorValue);

        double storedX = relevantPosition.position!.x;
        double storedY = relevantPosition.position!.y;

        if (storedX <= currentXUpperBoundry &&
            storedX >= currentXLowerBoundry &&
            storedY <= currentYUpperBoundry &&
            storedY >= currentYLowerBoundry) {
          return false;
        } else {
          log('new Position: $rollingGridPosition');
          log('old Position: ' + relevantPosition.toString() + '\n');
          return true;
        }
      }
    }

    return false;
  }

  factory IsolatePositionalGrid.fromPositionalGrid(
      PositionalGrid positionalGrid) {
    return IsolatePositionalGrid(
      origin: positionalGrid.originContainer,
      parent: positionalGrid.parentContainer,
      children: positionalGrid.children,
      markers: positionalGrid.markers,
      positions: positionalGrid.gridPositions,
      barcodes: positionalGrid.getBarcodes,
    );
  }

  Map toJson() => {
        'origin': origin.toJson(),
        'parent': parent?.toJson(),
        'children': jsonEncode(children),
        'markers': markers.isNotEmpty ? jsonEncode(markers) : '[]',
        'positions': positions.isNotEmpty ? jsonEncode(positions) : '[]',
        'barcodes': jsonEncode(barcodes),
      };

  factory IsolatePositionalGrid.fromJson(json) {
    return IsolatePositionalGrid(
      origin: ContainerEntry().fromJson(json['origin']),
      parent: ContainerEntry().fromJson(json['parent']),
      children: (jsonDecode(json['children']) as List<dynamic>)
          .map((e) => ContainerEntry().fromJson(e))
          .toList(),
      markers: (jsonDecode(json['markers']) as List<dynamic>)
          .map((e) => Marker().fromJson(e))
          .toList(),
      positions: (jsonDecode(json['positions']) as List<dynamic>)
          .map((e) => Position.fromJson(e))
          .toList(),
      barcodes: (jsonDecode(json['barcodes']) as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );
  }

  @override
  String toString() {
    return '''\n______________________________________
    IsolatePositionalGrid

origin:     ${origin.name} (${origin.containerUID})
parent:     ${parent?.containerUID}
children:   ${children.length}
markers:    ${markers.length}
positions:  ${positions.length}
barcodes:   $barcodes
______________________________________''';
  }
}
