import 'dart:convert';

import 'package:flutter_google_ml_kit/objects/navigation/isolate/isolate_grid.dart';

class GridProcessorConfig {
  GridProcessorConfig({
    required this.grids,
    required this.focalLength,
  });

  ///Identifier. [String]
  final String identifier = 'config';

  ///Inital Grids. [IsolateGrid]
  final List<IsolateGrid> grids;

  ///Focal Length. [double]
  final double focalLength;

  List<dynamic> toMessage() {
    return [
      identifier,
      jsonEncode(grids),
      focalLength,
    ];
  }

  factory GridProcessorConfig.fromMessage(message) {
    //This is the initial set of grids.
    List<dynamic> parsedListJson = jsonDecode(message[1]);
    List<IsolateGrid> grids = List<IsolateGrid>.from(
        parsedListJson.map((e) => IsolateGrid.fromJson(e)));
    return GridProcessorConfig(
      grids: grids,
      focalLength: message[2],
    );
  }
}
