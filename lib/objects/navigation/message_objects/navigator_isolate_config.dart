import 'dart:convert';
import 'dart:ui';

import 'package:flutter_google_ml_kit/objects/navigation/isolate/isolate_grid.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class NavigatorIsolateConfig {
  NavigatorIsolateConfig({
    required this.absoluteSize,
    required this.canvasSize,
    required this.inputImageFormat,
    required this.selectedBarcodeUID,
    required this.barcodeProperties,
    required this.initialGrids,
  });

  ///identifier. [String]
  String identifier = 'config';

  ///Abosulte Image size. [Size]
  Size absoluteSize;

  ///Canvas Size. [Size]
  Size canvasSize;

  ///Input Image Format. [InputImageFormat]
  InputImageFormat inputImageFormat;

  ///Selcted BarcodeUID. [String]
  String selectedBarcodeUID;

  ///Barcode Properties. [Map]
  Map<String, double> barcodeProperties;

  ///Grids. [IsolateGrid]
  List<IsolateGrid> initialGrids;

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
    List<IsolateGrid> grids = List<IsolateGrid>.from(
        parsedListJson.map((e) => IsolateGrid.fromJson(e)));
    return NavigatorIsolateConfig(
        absoluteSize: Size(message[1], message[2]),
        canvasSize: Size(message[3], message[4]),
        inputImageFormat: InputImageFormat.values.elementAt(message[5]),
        selectedBarcodeUID: message[6],
        barcodeProperties: message[7],
        initialGrids: grids);
  }
}
