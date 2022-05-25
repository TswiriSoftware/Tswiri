import 'dart:developer';
import 'dart:isolate';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/barcodes/barcode_property/barcode_property.dart';
import 'package:flutter_google_ml_kit/isar_database/barcodes/interbarcode_vector_entry/interbarcode_vector_entry.dart';
import 'package:flutter_google_ml_kit/objects/grid/master_grid.dart';
import 'package:flutter_google_ml_kit/objects/grid/processing/on_Image_barcode_data.dart';
import 'package:flutter_google_ml_kit/objects/grid/processing/on_image_inter_barcode_data.dart';
import 'package:flutter_google_ml_kit/objects/grid/processing/real_interbarcode_vector.dart';
import 'package:flutter_google_ml_kit/objects/grid/rolling_grid.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcodes/barcode_scanning/barcode_position_scanner/barcode_position_scanner_processing_view.dart';
import 'package:isar/isar.dart';

void gridProcessor(List init) {
  //1. InitalMessage.
  SendPort sendPort = init[0]; //[0] SendPort.
  String isarDirectory = init[1]; //[1] Isar directory
  double focalLength = init[2]; //[2] focalLength
  double defualtBarcodeSize = init[3]; //[3] Default Barcode Size.

  //2. ReceivePort.
  ReceivePort receivePort = ReceivePort();
  sendPort.send([
    'Sendport', //[0] Identifier.
    receivePort.sendPort, //[1] Sendport
  ]);

  //3. Isar Connection.
  Isar isarDatabase = openIsar(directory: isarDirectory, inspector: false);
  List<BarcodeProperty> barcodeProperties =
      isarDatabase.barcodePropertys.where().findAllSync();

  //4. Spawn MasterGrid.
  MasterGrid masterGrid = MasterGrid(isarDatabase: isarDatabase);
  masterGrid.calculateCoordinates();

  List<Coordinate> coordinates = masterGrid.coordinates!;

  //5. Setup the Rolling grid.
  RollingGrid rollingGrid = RollingGrid(isarDatabase: isarDatabase);
  rollingGrid.initiate(masterGrid);

  log('GP: Setup Complete');

  List<InterBarcodeVectorEntry> realInterBarcodeVectors = [];
  List<InterBarcodeVectorEntry> averagedInterBarcodeVectors = [];

  void processBarcodes(List message) {
    //1. Create OnImageBarcodeData
    List<OnImageBarcodeData> barcodeData = [];
    if (message.isNotEmpty) {
      for (List item in message) {
        barcodeData.add(OnImageBarcodeData.fromMessage(item));
      }
    }

    //2. Create OnImageInterBarcodeData.
    List<OnImageInterBarcodeData> onImageInterBarcodeDatas = [];
    for (var x = 0; x < barcodeData.length; x++) {
      for (var i = 0; i < barcodeData.length; i++) {
        if (i != x) {
          OnImageInterBarcodeData onImageInterBarcodeData =
              OnImageInterBarcodeData.fromBarcodeDataPair(
                  barcodeData[i], barcodeData[x]);

          if (!onImageInterBarcodeDatas.contains(onImageInterBarcodeData)) {
            onImageInterBarcodeDatas.add(onImageInterBarcodeData);
          }
        }
      }
    }

    //3. Create RealInterBarcodeVectos and add to list :D.
    for (OnImageInterBarcodeData gridOnImageInterBarcodeData
        in onImageInterBarcodeDatas) {
      InterBarcodeVectorEntry realInterBarcodeVector = InterBarcodeVectorEntry()
          .fromRawInterBarcodeData(gridOnImageInterBarcodeData,
              gridOnImageInterBarcodeData.startBarcode.timestamp, isarDatabase);
      if (!averagedInterBarcodeVectors.contains(realInterBarcodeVector)) {
        realInterBarcodeVectors.add(realInterBarcodeVector);
      }
    }

    //4. Do the averageing thing.

    List<InterBarcodeVectorEntry> uniqueVectors =
        realInterBarcodeVectors.toSet().toList();

    for (InterBarcodeVectorEntry vector in uniqueVectors) {
      List<InterBarcodeVectorEntry> similarVectors = realInterBarcodeVectors
          .where((element) => element.uid == element.uid)
          .toList();

      //i. IF more than 5 do stuff
      if (similarVectors.length >= 5) {
        //iii. Sort similarInterBarcodeOffsets by the length of the vector.
        similarVectors
            .sort((a, b) => a.vector3.length.compareTo(b.vector3.length));

        //iv. Remove any outliers.
        //Indexes (Stats).
        int medianIndex = (similarVectors.length ~/ 2);
        int quartile1Index = ((similarVectors.length / 2) ~/ 2);
        int quartile3Index = medianIndex + quartile1Index;

        //Values of indexes.
        double median = similarVectors[medianIndex].vector3.length;
        double quartile1 =
            calculateQuartileValue(similarVectors, quartile1Index, median);
        double quartile3 =
            calculateQuartileValue(similarVectors, quartile3Index, median);

        //Boundry calculations.
        double interQuartileRange = quartile3 - quartile1;
        double q1Boundry = quartile1 - interQuartileRange * 1.5; //Lower boundry
        double q3Boundry = quartile3 + interQuartileRange * 1.5; //Upper boundry

        //Remove data outside the boundries.
        similarVectors.removeWhere((element) =>
            element.vector3.length <= q1Boundry &&
            element.vector3.length >= q3Boundry);
      }

      //v. Caluclate the average.
      for (InterBarcodeVectorEntry similarInterBarcodeOffset
          in similarVectors) {
        //Average the similar interBarcodeData.
        vector.x = (vector.x + similarInterBarcodeOffset.x) / 2;
        vector.y = (vector.y + similarInterBarcodeOffset.y) / 2;
        vector.vector3.z = (vector.z + similarInterBarcodeOffset.z) / 2;
      }

      //vi. Add the vector to list.
      averagedInterBarcodeVectors.add(vector);
    }

    log(averagedInterBarcodeVectors.toString());
  }

  receivePort.listen((message) {
    if (message is List && message.isNotEmpty) {
      if (message[0] == 'ImageProcessorConfig') {
      } else {
        processBarcodes(message);
      }
    }
  });
}
