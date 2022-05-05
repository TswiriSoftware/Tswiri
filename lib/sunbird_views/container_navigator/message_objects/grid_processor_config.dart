import 'dart:convert';

import 'package:flutter_google_ml_kit/objects/navigation/isolate_grid_object.dart';

class GridProcessorConfig {
  GridProcessorConfig({
    required this.grids,
    required this.focalLength,
  });

  ///Identifier.
  final String identifier = 'config';

  ///Initalgrids.
  final List<IsolateGridObject> grids;

  ///Focal Length.
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
    List<IsolateGridObject> grids = List<IsolateGridObject>.from(
        parsedListJson.map((e) => IsolateGridObject.fromJson(e)));
    return GridProcessorConfig(grids: grids, focalLength: message[2]);
  }
}
