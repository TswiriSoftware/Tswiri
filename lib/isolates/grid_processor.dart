import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';
import 'package:flutter_google_ml_kit/extentions/distinct.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/global_values/shared_prefrences.dart';
import 'package:flutter_google_ml_kit/isar_database/barcodes/barcode_property/barcode_property.dart';
import 'package:flutter_google_ml_kit/isar_database/grid/coordinate_entry/coordinate_entry.dart';
import 'package:flutter_google_ml_kit/objects/grid/interbarcode_vector.dart';
import 'package:flutter_google_ml_kit/objects/grid/master_grid.dart';
import 'package:flutter_google_ml_kit/objects/grid/processing/on_image_barcode_data.dart';
import 'package:flutter_google_ml_kit/objects/grid/processing/on_image_inter_barcode_data.dart';
import 'package:flutter_google_ml_kit/objects/grid/grid.dart';
import 'package:isar/isar.dart';

///This is a isolate that updates positions (improve this over time.)
void gridProcessor(List init) {
  //1. InitalMessage.
  SendPort sendPort = init[0]; //[0] SendPort.
  String isarDirectory = init[1]; //[1] Isar directory
  //[2] focalLength
  //double defualtBarcodeSize = init[3]; //[3] Default Barcode Size.

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

  //5. Setup the Rolling grid.
  Grid grid = Grid(isarDatabase: isarDatabase);
  grid.initiate(masterGrid);

  log('GP: Setup Complete');

  List<InterBarcodeVector> realVectors = [];
  List<InterBarcodeVector> averagedInterBarcodeVectors = [];
  List<InterBarcodeVector> usedInterBarcodeVectors = [];

  /// this function is called by
  void processBarcodes(List message) {
    //1. Create realInterBarcodeVectors.
    List<InterBarcodeVector> interBarcodeVectorEntries =
        createInterBarcodeVectors(message, barcodeProperties);

    //2. Add new interBarcodeVectors. (If it has already been averaged then it is not added to this list.)
    for (InterBarcodeVector vector in interBarcodeVectorEntries) {
      if (!averagedInterBarcodeVectors.contains(vector)) {
        realVectors.add(vector);
      }
    }

    //3. Average the InterBarcodeVectors.
    List<InterBarcodeVector> newAveragedVectors =
        averageInterBarcodeVectors(realVectors);

    for (InterBarcodeVector averagedVector in newAveragedVectors) {
      //i. Add New AverageVector.
      if (!averagedInterBarcodeVectors.contains(averagedVector) &&
          !usedInterBarcodeVectors.contains(averagedVector)) {
        averagedInterBarcodeVectors.add(averagedVector);
      }
    }

    List<String> fixedCoordinates =
        grid.coordinates.map((e) => e.barcodeUID).toList();

    //4. Start building the new grids.
    //i. Iterate through averagedInterBarcodeVectors.
    List<InterBarcodeVector> movedInterBarcodeVectors = [];
    for (InterBarcodeVector vector in averagedInterBarcodeVectors) {
      if (fixedCoordinates.contains(vector.startBarcodeUID) ||
          fixedCoordinates.contains(vector.endBarcodeUID)) {
        //ii. Add the coordinate to the grid.
        CoordinateEntry? newCoordinate = grid.addCoordiante(vector);

        //iii. Move Vectors.
        if (newCoordinate != null) {
          movedInterBarcodeVectors.add(vector);
          //iv. Compare Grid Coordinates.

          //1. Check if this coordinate is stored in database.
          CoordinateEntry? storedCoordinate =
              masterGrid.findCoordinate(newCoordinate);
          if (storedCoordinate != null) {
            //Checks if this coordinate exists.
            if (storedCoordinate.gridUID == newCoordinate.gridUID) {
              //The gridUIDs matches. (This means the barcode has moved within this grid.)
              if (hasMoved(newCoordinate, storedCoordinate, 15)) {
                //Update position
                masterGrid.updateCoordinateMem(newCoordinate);
                masterGrid.updateCoordinateIsar(newCoordinate);
                sendPort.send(['Update', jsonEncode(newCoordinate.toJson())]);
              }
            } else {
              //The gridUIDs do not match. (This means the barcode has moved to a new grid.)
              //1. Delete the old coordinate + Add new one
              //2. Delete Relationship + Add new Relationship
              masterGrid.updateCoordinateMem(newCoordinate);
              //Update the Isar database.
              masterGrid.updateCoordinateIsar(newCoordinate);
            }
          } else {
            //The coordinate does not exisit.

          }
        }
      }
    }
    for (InterBarcodeVector vector in movedInterBarcodeVectors) {
      usedInterBarcodeVectors.add(vector);
      averagedInterBarcodeVectors.remove(vector);
    }
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

/// Convert onImageInterbarcodeData -> onImageInterbarcodeData-> realInterBarcodeVectors
List<InterBarcodeVector> createInterBarcodeVectors(
    List message, List<BarcodeProperty> barcodeProperties) {
  //1. Convert message to InImageBarcodeData.
  List<OnImageBarcodeData> onImageBarcodeData = [];
  if (message.isNotEmpty) {
    for (List item in message) {
      onImageBarcodeData.add(OnImageBarcodeData.fromMessage(item));
    }
  }

  //2. Create OnImageInterBarcodeData.
  List<OnImageInterBarcodeData> onImageInterBarcodes = [];
  for (var x = 0; x < onImageBarcodeData.length; x++) {
    for (var i = 0; i < onImageBarcodeData.length; i++) {
      if (i != x) {
        OnImageInterBarcodeData onImageInterBarcodeData =
            OnImageInterBarcodeData.fromBarcodeDataPair(
                onImageBarcodeData[i], onImageBarcodeData[x]);

        if (!onImageInterBarcodes.contains(onImageInterBarcodeData)) {
          onImageInterBarcodes.add(onImageInterBarcodeData);
        }
      }
    }
  }

  //3. Create RealInterBarcodeVectos;
  List<InterBarcodeVector> realInterBarcodeVectors = [];
  for (OnImageInterBarcodeData onImageInterBarcodes in onImageInterBarcodes) {
    InterBarcodeVector realInterBarcodeVector =
        InterBarcodeVector.fromRawInterBarcodeData(
            interBarcodeData: onImageInterBarcodes,
            barcodeProperties: barcodeProperties,
            focalLength: focalLength);

    realInterBarcodeVectors.add(realInterBarcodeVector);
  }

  return realInterBarcodeVectors;
}

///Averages the interBarcodeVectors with more than 8 copies.
List<InterBarcodeVector> averageInterBarcodeVectors(
    List<InterBarcodeVector> realInterBarcodeVectors) {
  List<InterBarcodeVector> averagedInterBarcodeVectors = [];

  //1. Get a list of all unique vectors.
  List<InterBarcodeVector> uniqueVectors =
      realInterBarcodeVectors.distinctBy((x) => x.uid).toList();

  //2. Loop through uniqueVectors.
  for (InterBarcodeVector uniqueVector in uniqueVectors) {
    //i. Find similar vectors. (These vectors have the same uid as the unique vector)
    List<InterBarcodeVector> similarVectors = realInterBarcodeVectors
        .where((element) => element.uid == uniqueVector.uid)
        .toList();

    //ii. Check if there are more than 8.
    if (similarVectors.length >= 3) {
      // //iii. Sort by vector length.
      // similarVectors
      //     .sort((a, b) => a.vector3.length.compareTo(b.vector3.length));

      // //iv. Remove any outliers.
      // //Indexes (Stats).
      // int medianIndex = (similarVectors.length ~/ 2);
      // int quartile1Index = ((similarVectors.length / 2) ~/ 2);
      // int quartile3Index = medianIndex + quartile1Index;

      // //Values of indexes.
      // double median = similarVectors[medianIndex].vector3.length;
      // double quartile1 =
      //     calculateQuartileValue(similarVectors, quartile1Index, median);
      // double quartile3 =
      //     calculateQuartileValue(similarVectors, quartile3Index, median);

      // //Boundry calculations.
      // double interQuartileRange = quartile3 - quartile1;
      // double q1Boundry = quartile1 - interQuartileRange * 1.5; //Lower boundry
      // double q3Boundry = quartile3 + interQuartileRange * 1.5; //Upper boundry

      // //Remove data outside the boundries.
      // similarVectors.removeWhere((element) =>
      //     element.vector3.length <= q1Boundry &&
      //     element.vector3.length >= q3Boundry);

      //v. Caluclate the average.
      for (InterBarcodeVector similarVector in similarVectors) {
        //Average the similar interBarcodeData.
        uniqueVector.vector3.x =
            (uniqueVector.vector3.x + similarVector.vector3.x) / 2;
        uniqueVector.vector3.y =
            (uniqueVector.vector3.y + similarVector.vector3.y) / 2;
        uniqueVector.vector3.z =
            (uniqueVector.vector3.z + similarVector.vector3.z) / 2;
      }
      averagedInterBarcodeVectors.add(uniqueVector);
    }
  }

  return averagedInterBarcodeVectors;
}

///Checks if the coordinate's positions are within a given error (mm)
bool hasMoved(CoordinateEntry newCoordinate, CoordinateEntry storedCoordinate,
    double error) {
  if (storedCoordinate.vector()!.x + error >= newCoordinate.vector()!.x &&
      storedCoordinate.vector()!.x - error <= newCoordinate.vector()!.x &&
      storedCoordinate.vector()!.y + error >= newCoordinate.vector()!.y &&
      storedCoordinate.vector()!.y - error <= newCoordinate.vector()!.y &&
      storedCoordinate.vector()!.z + error >= newCoordinate.vector()!.z &&
      storedCoordinate.vector()!.z - error <= newCoordinate.vector()!.z) {
    //Returns false if it has not moved.
    return false;
  }
  //Returns true if it has moved.
  return true;
}
