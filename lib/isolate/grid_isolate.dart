import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter_google_ml_kit/functions/translating/coordinates_translator.dart';
import 'package:flutter_google_ml_kit/isar_database/real_interbarcode_vector_entry/real_interbarcode_vector_entry.dart';
import 'package:flutter_google_ml_kit/objects/navigation/grid_object.dart';
import 'package:flutter_google_ml_kit/objects/navigation/isolate_grid_object.dart';
import 'package:flutter_google_ml_kit/objects/reworked/on_image_data.dart';
import 'package:flutter_google_ml_kit/objects/reworked/on_image_inter_barcode_data.dart';
import 'dart:math' as math;
import 'package:google_ml_kit/google_ml_kit.dart';

void gridIsolate(SendPort sendPort) {
  ReceivePort receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);
  List<IsolateGridObject>? initialGrids;
  List<RollingGridObject> currentGrids = [];

  void processGrid(var message) async {
    List<OnImageBarcodeData> onImageBarcodeDataBatch = [];
    for (int x = 0; x < message.length; x++) {
      //ii. Iterate through the barcodeDataBatch and generate IsolateRawOnImageBarcodeData.
      onImageBarcodeDataBatch.add(OnImageBarcodeData.fromMessage(message[x]));
    }

    List<OnImageInterBarcodeData> onImageInterBarcodeData = [];
    for (OnImageBarcodeData onImageBarcodeData in onImageBarcodeDataBatch) {
      //iii.Iterate through onImageBarcodeDataBatch.

      for (int z = 1; z < onImageBarcodeDataBatch.length; z++) {
        //iv. Create BarcodeDataPairs.
        if (onImageBarcodeData.barcodeUID !=
            onImageBarcodeDataBatch[z].barcodeUID) {
          onImageInterBarcodeData.add(
              OnImageInterBarcodeData.fromBarcodeDataPair(
                  onImageBarcodeData, onImageBarcodeDataBatch[z]));
        }
      }
    }

    List<RealInterBarcodeVectorEntry> realInterBarcodeVectors = [];
    int creationTimestamp = DateTime.now().millisecondsSinceEpoch;
    for (OnImageInterBarcodeData interBarcodeData in onImageInterBarcodeData) {
      // i. Iterate through onImageInterBarcodeData and generate IsolateRealInterBarcodeData.
      realInterBarcodeVectors.add(RealInterBarcodeVectorEntry()
          .fromRawInterBarcodeData(interBarcodeData, creationTimestamp));
    }
    log(realInterBarcodeVectors.toString());
  }

  receivePort.listen(
    (message) {
      if (message is String) {
        //This is the initial set of grids.
        List<dynamic> parsedListJson = jsonDecode(message);
        initialGrids = List<IsolateGridObject>.from(
            parsedListJson.map((e) => IsolateGridObject.fromJson(e)));

        //Initiate all rolling grids :D.
        for (IsolateGridObject grid in initialGrids!) {
          RollingGridObject newRollingGrid =
              RollingGridObject(markers: grid.markers);

          newRollingGrid.initiateGrid(
              newRollingGrid.markers, grid.gridPositions);

          currentGrids.add(newRollingGrid);
        }

        //  log(currentGrids.toString());
      } else if (message is List) {
        //This is the data received from the Image Processors
        processGrid(message);
      }
    },
  );
}
