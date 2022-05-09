import 'dart:convert';
import 'dart:ui';

import 'package:flutter_google_ml_kit/objects/grid/isolate_grid.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class NavigatorIsolateConfig {
  NavigatorIsolateConfig({
    required this.absoluteSize,
    required this.canvasSize,
    required this.inputImageFormat,
    required this.selectedBarcodeUID,
    required this.barcodeProperties,
    required this.grid,
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

  // ///Grids. [IsolateGridOLD]
  // List<IsolateGridOLD> initialGrids;
  ///Grid. [IsolateGrid]
  IsolateGrid grid;

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
      jsonEncode(grid) //[8]
    ];
  }

  factory NavigatorIsolateConfig.fromMessage(message) {
    return NavigatorIsolateConfig(
      absoluteSize: Size(message[1], message[2]),
      canvasSize: Size(message[3], message[4]),
      inputImageFormat: InputImageFormat.values.elementAt(message[5]),
      selectedBarcodeUID: message[6],
      barcodeProperties: message[7],
      grid: IsolateGrid.fromJson(jsonDecode(message[8])),
    );
  }
}
