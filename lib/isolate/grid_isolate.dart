import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';
import 'package:flutter_google_ml_kit/objects/grid/isolate_grid.dart';
import 'package:flutter_google_ml_kit/objects/navigation/isolate/isolate_on_image_data.dart';
import 'package:flutter_google_ml_kit/objects/navigation/isolate/isolate_on_image_inter_barcode_data.dart';
import 'package:flutter_google_ml_kit/objects/navigation/isolate/isolate_real_inter_barcode_vector.dart';
import 'package:flutter_google_ml_kit/objects/navigation/isolate/isolate_rolling_grid.dart';
import 'package:flutter_google_ml_kit/objects/navigation/message_objects/grid_processor_config.dart';

void gridIsolate(SendPort sendPort) {
  ReceivePort receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);
  IsolateGrid? isolateGrid;
  List<RollingGrid> currentGrids = [];
  SendPort? isolatePortImage1; //send stuff to isolate
  SendPort? isolatePortImage2; //send stuff to isolate

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
      int index = currentGrids.indexWhere((element) => element.barcodes
          .contains(realInterBarcodeVectors.first.startBarcodeUID));

      if (index != -1) {
        RollingGrid workingGrid = currentGrids[index];
        if (workingGrid.isComplete == false) {
          //Generate Grid working grid.
          workingGrid.generateGrid(realInterBarcodeVectors);

          ///TODO: Use IsolateGrid to do this.
          //Get relvant starting grid.
          IsolatePositionalGrid initialGrid = isolateGrid!.positionalGrids
              .where((element) =>
                  element.barcodes.contains(workingGrid.barcodes.first))
              .first;

          //My my my how have we gotten here :D.
          //Now I shall compare the initial Grid to the latest grid :D.

          for (var rollingGridPosition in workingGrid.grid) {
            bool hasMoved = initialGrid.comparePosition(rollingGridPosition);
            // initialGrid.comparePosition(rollingGridPosition);

            log(hasMoved.toString());
            if (hasMoved) {
              //Send this to the main Isolate so the position can be updated....
              log('new Position: $rollingGridPosition');

              sendPort
                  .send(['update', jsonEncode(rollingGridPosition.toJson())]);

              // isolatePortImage1!
              //     .send(['update1', jsonEncode(rollingGridPosition.toJson())]);
              // isolatePortImage2!
              //     .send(['update2', jsonEncode(rollingGridPosition.toJson())]);

              //Update Position in inital Grids
              initialGrid.updatePosition(rollingGridPosition);
            }
          }
        }
      }
    }
  }

  receivePort.listen(
    (message) {
      if (message is SendPort) {
        if (isolatePortImage1 == null) {
          isolatePortImage1 = message;
          log('isolate1 port set: ');
        } else if (isolatePortImage2 == null) {
          isolatePortImage2 = message;
          log('isolate2 port set');
        }
      } else if (message is List && message[0] == 'config') {
        GridProcessorConfig config = GridProcessorConfig.fromMessage(message);

        isolateGrid = config.grid;
        log(isolateGrid.toString());

        //Initiate all rolling grids :D.
        for (IsolatePositionalGrid grid in isolateGrid!.positionalGrids) {
          RollingGrid newRollingGrid = RollingGrid(markers: grid.markers);

          newRollingGrid.initiateGrid(newRollingGrid.markers, grid.positions);

          currentGrids.add(newRollingGrid);
        }
      } else if (message[0] == 'process') {
        //This is the data received from the Image Processors
        processGrid(message[1]);
      }
    },
  );
}
