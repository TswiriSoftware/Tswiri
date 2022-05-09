import 'dart:convert';

import 'package:flutter_google_ml_kit/objects/grid/isolate_grid.dart';

class GridProcessorConfig {
  GridProcessorConfig({
    required this.grid,
    required this.focalLength,
  });

  ///Identifier. [String]
  final String identifier = 'config';

  ///Inital Grids. [IsolateGridOLD]
  final IsolateGrid grid;

  ///Focal Length. [double]
  final double focalLength;

  List<dynamic> toMessage() {
    return [
      identifier,
      jsonEncode(grid),
      focalLength,
    ];
  }

  factory GridProcessorConfig.fromMessage(message) {
    return GridProcessorConfig(
      grid: IsolateGrid.fromJson(jsonDecode(message[1])),
      focalLength: message[2],
    );
  }
}
