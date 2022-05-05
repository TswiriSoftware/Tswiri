import 'dart:developer';
import 'dart:isolate';
import 'package:flutter_google_ml_kit/objects/navigation/isolate_grid_object.dart';
import 'package:flutter_google_ml_kit/objects/navigation/isolate_on_image_data.dart';
import 'package:flutter_google_ml_kit/objects/navigation/isolate_on_image_inter_barcode_data.dart';
import 'package:flutter_google_ml_kit/objects/navigation/isolate_real_inter_barcode_vector.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_navigator/message_objects/grid_processor_config.dart';

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
      RollingGridObject workingGrid = currentGrids
          .where((element) => element.barcodes
              .contains(realInterBarcodeVectors.first.startBarcodeUID))
          .first;

      if (workingGrid.isComplete == false) {
        //Generate Grid working grid.
        workingGrid.generateGrid(realInterBarcodeVectors);

        //Get relvant starting grid.
        IsolateGridObject initialGrid = initialGrids!
            .where((element) =>
                element.getBarcodes().contains(workingGrid.barcodes.first))
            .first;

        //My my my how have we gotten here :D.
        //Now I shall compare the initial Grid to the latest grid :D.

        for (var rollingGridPosition in workingGrid.grid) {
          bool hasMoved = initialGrid.comparePosition(rollingGridPosition);
          if (hasMoved) {
            //Send this to the main Isolate so the position can be updated....
            log('new Position: $rollingGridPosition');
          }
        }
      }
    }

    // log(isolateFocalLength.toString());
    log('InitialGrids: \n' + initialGrids.toString());
    log('CurrentGrids: \n' + currentGrids.toString());
  }

  receivePort.listen(
    (message) {
      if (message is List && message[0] == 'config') {
        GridProcessorConfig config = GridProcessorConfig.fromMessage(message);

        initialGrids = config.grids;

        //Initiate all rolling grids :D.
        for (IsolateGridObject grid in initialGrids!) {
          RollingGridObject newRollingGrid =
              RollingGridObject(markers: grid.markers);

          newRollingGrid.initiateGrid(
              newRollingGrid.markers, grid.gridPositions);

          currentGrids.add(newRollingGrid);
        }

        //  log(currentGrids.toString());
      } else if (message[0] == 'compute') {
        //This is the data received from the Image Processors
        processGrid(message[1]);
      }
    },
  );
}
