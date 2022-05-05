import 'dart:convert';
import 'dart:ui';

import 'package:flutter_google_ml_kit/objects/navigation/isolate_grid_object.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class NavigatorIsolateConfig {
  NavigatorIsolateConfig(
      {required this.absoluteSize,
      required this.canvasSize,
      required this.inputImageFormat,
      required this.selectedBarcodeUID,
      required this.barcodeProperties,
      required this.initialGrids});
  String identifier = 'config';
  Size absoluteSize;
  Size canvasSize;
  InputImageFormat inputImageFormat;
  String selectedBarcodeUID;
  Map<String, double> barcodeProperties;
  List<IsolateGridObject> initialGrids;

  List toMessage() {
    return [
      identifier, //[0]
      absoluteSize.width, //[1]
      absoluteSize.height, //[2]
      canvasSize.width, //[3]
      canvasSize.height, //[4]
      inputImageFormat.index, //[5]
      selectedBarcodeUID, //[6]
      barcodeProperties, //[7]
      jsonEncode(initialGrids) //[8]
    ];
  }

  factory NavigatorIsolateConfig.fromMessage(message) {
    List<dynamic> parsedListJson = jsonDecode(message[8]);
    List<IsolateGridObject> grids = List<IsolateGridObject>.from(
        parsedListJson.map((e) => IsolateGridObject.fromJson(e)));
    return NavigatorIsolateConfig(
        absoluteSize: Size(message[1], message[2]),
        canvasSize: Size(message[3], message[4]),
        inputImageFormat: InputImageFormat.values.elementAt(message[5]),
        selectedBarcodeUID: message[6],
        barcodeProperties: message[7],
        initialGrids: grids);
  }
}
