import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';
import 'package:flutter_google_ml_kit/objects/navigation/isolate_grid_object.dart';
import 'package:flutter_google_ml_kit/objects/navigation/isolate_on_image_data.dart';
import 'package:flutter_google_ml_kit/objects/navigation/isolate_on_image_inter_barcode_data.dart';
import 'package:flutter_google_ml_kit/objects/navigation/isolate_real_inter_barcode_vector.dart';

void gridIsolate(SendPort sendPort) {
  ReceivePort receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);
  List<IsolateGridObject>? initialGrids;
  List<RollingGridObject> currentGrids = [];

  void processGrid(var message) async {
    //1. Decode Messgae.
    //i. Build IsolateOnImageBarcodeData.
    List<IsolateOnImageBarcodeData> onImageBarcodeDataBatch = [];
    for (int x = 0; x < message.length; x++) {
      //ii. Iterate through the barcodeDataBatch and generate IsolateRawOnImageBarcodeData.
      onImageBarcodeDataBatch
          .add(IsolateOnImageBarcodeData.fromMessage(message[x]));
    }

    List<IsolateOnImageInterBarcodeData> onImageInterBarcodeData = [];
    for (IsolateOnImageBarcodeData onImageBarcodeData
        in onImageBarcodeDataBatch) {
      //iii.Iterate through onImageBarcodeDataBatch.

      for (int z = 1; z < onImageBarcodeDataBatch.length; z++) {
        //iv. Create BarcodeDataPairs.
        if (onImageBarcodeData.barcodeUID !=
            onImageBarcodeDataBatch[z].barcodeUID) {
          onImageInterBarcodeData.add(
              IsolateOnImageInterBarcodeData.fromBarcodeDataPair(
                  onImageBarcodeData, onImageBarcodeDataBatch[z]));
        }
      }
    }

    ///2. Build list of RealInterBarcodeData.
    List<IsolateRealInterBarcodeVector> realInterBarcodeVectors = [];
    int creationTimestamp = DateTime.now().millisecondsSinceEpoch;
    for (IsolateOnImageInterBarcodeData interBarcodeData
        in onImageInterBarcodeData) {
      // i. Iterate through onImageInterBarcodeData and generate IsolateRealInterBarcodeData.
      realInterBarcodeVectors.add(
          IsolateRealInterBarcodeVector.fromIsolateInterBarcodeData(
              interBarcodeData, creationTimestamp));
    }

    //Start building the grid :D.
    if (realInterBarcodeVectors.isNotEmpty) {
      currentGrids
          .where((element) => element.barcodes
              .contains(realInterBarcodeVectors.first.startBarcodeUID))
          .first
          .updateGrid(realInterBarcodeVectors);
    }
    log(currentGrids.toString());
    log(initialGrids.toString());
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
