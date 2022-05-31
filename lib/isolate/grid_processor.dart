import 'dart:developer';
import 'dart:isolate';
import 'package:flutter_google_ml_kit/extentions/distinct.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/functions/position_functions/average_inter_barcode_vectors.dart';
import 'package:flutter_google_ml_kit/global_values/shared_prefrences.dart';
import 'package:flutter_google_ml_kit/isar_database/barcodes/barcode_property/barcode_property.dart';
import 'package:flutter_google_ml_kit/objects/grid/interbarcode_vector.dart';
import 'package:flutter_google_ml_kit/objects/grid/master_grid.dart';
import 'package:flutter_google_ml_kit/objects/grid/processing/on_image_barcode_data.dart';
import 'package:flutter_google_ml_kit/objects/grid/processing/on_image_inter_barcode_data.dart';
import 'package:flutter_google_ml_kit/objects/grid/rolling_grid.dart';
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

  ///TODO: Convert to InterBarcodeVector

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

    // //4. Start Generating Coordinates in the independant Grids.
    // for (IndependantRollingGrid independantGrid in grid.independantGrids) {
    //   //i. Run though averagedInterBarcodeVectors.
    //   for (InterBarcodeVector vector in averagedInterBarcodeVectors
    //       .where((element) => !usedInterBarcodeVectors.contains(element))
    //       .toList()) {
    //     //ii. Find the fixed coordinates.
    //     List<String> fixedCoordinates =
    //         independantGrid.coordinates.map((e) => e.barcodeUID).toList();

    //     if (fixedCoordinates.contains(vector.startBarcodeUID) ||
    //         fixedCoordinates.contains(vector.endBarcodeUID)) {
    //       //iii. Add new coordinate.
    //       Coordinate newCoordinate = independantGrid.addCoordinate(vector);

    //       //iv. Move averagedVector to usedInterBarcodeVectors.
    //       usedInterBarcodeVectors.add(vector);
    //       averagedInterBarcodeVectors.remove(vector);

    //       //v. Check if this coordinate exists within the same grid.
    //       int index = masterGrid.coordinates!.indexWhere((element) =>
    //           element.barcodeUID == newCoordinate.barcodeUID &&
    //           element.gridID == newCoordinate.gridID);

    //       if (index != -1) {
    //         //vi. It exsists in the same grid.
    //         Coordinate storedCoordinate = masterGrid.coordinates![index];
    //         //vii. Check if its coordinate is not null.
    //         if (storedCoordinate.coordinate != null) {
    //           //Check if the coordinate has moved.
    //           if (hasMoved(newCoordinate, storedCoordinate, 10)) {
    //             masterGrid.updateCoordinate(newCoordinate);

    //             //TODO: If the coordinate has moved within the current grid.

    //             // log('coordiante has moved within current grid.');
    //             // log('new coordinate: $newCoordinate');
    //             // log('old coordinate: $storedCoordinate');

    //             sendPort.send(['Update', jsonEncode(newCoordinate.toJson())]);
    //           }
    //         } else {
    //           //viii. Do something if it's coordinate is null.
    //           //TODO: if the Coordinates Position is null

    //           // log('coordiante needs to be given a position within current grid.');
    //           // log('new coordinate: $newCoordinate');
    //           // log('old coordinate: $storedCoordinate');
    //         }
    //       } else {
    //         //vi. It does not exist in the same grid.
    //         List<Coordinate> foundCoordinates = masterGrid.coordinates!
    //             .where(
    //                 (element) => element.barcodeUID == newCoordinate.barcodeUID)
    //             .toList();

    //         if (foundCoordinates.isNotEmpty) {
    //           //vii. Coordinate has been found in a different grid.
    //           //TODO: Code to update a coordinates grid and Position.

    //           // log('Coordinate has not been found in current grid.');
    //           // log('However it has been found somewhere else.');
    //           // log(foundCoordinates.toString());
    //         } else {
    //           //Coordinate has not been found anywhere.
    //           //log('This coordinate has not been found anywhere.');
    //           //TODO: Maybe ignore this ?
    //         }
    //       }
    //     }
    //   }
    // }
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
    if (similarVectors.length >= 8) {
      //iii. Sort by vector length.
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

// ///Checks if the coordinate's positions are within a given error (mm)
// bool hasMoved(
//     Coordinate newCoordinate, Coordinate storedCoordinate, double error) {
//   if (storedCoordinate.coordinate!.x + error >= newCoordinate.coordinate!.x &&
//       storedCoordinate.coordinate!.x - error <= newCoordinate.coordinate!.x &&
//       storedCoordinate.coordinate!.y + error >= newCoordinate.coordinate!.y &&
//       storedCoordinate.coordinate!.y - error <= newCoordinate.coordinate!.y &&
//       storedCoordinate.coordinate!.z + error >= newCoordinate.coordinate!.z &&
//       storedCoordinate.coordinate!.z - error <= newCoordinate.coordinate!.z) {
//     return false;
//   }
//   return true;
// }
