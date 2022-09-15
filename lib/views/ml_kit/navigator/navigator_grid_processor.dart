// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';
import 'dart:isolate';

import 'package:tswiri_database/export.dart';
import 'package:tswiri_database/functions/data/data_processing_isolates.dart';
import 'package:tswiri_database/mobile_database.dart';
import 'package:tswiri_database/models/inter_barcode/inter_barcode_vector.dart';
import 'package:vector_math/vector_math_64.dart' as vm;

///This is a isolate that updates positions (improve this over time.)
void gridProcessor(List init) {
  //1. InitalMessage.
  SendPort sendPort = init[0]; //[0] SendPort.
  String isarDirectory = init[1]; //[1] Isar directory
  double focalLength = init[2]; // [2] focalLength
  double defualtBarcodeSize = init[3]; //[3] Default Barcode Size.

  //2. ReceivePort.
  ReceivePort receivePort = ReceivePort();
  sendPort.send([
    'Sendport', //[0] Identifier.
    receivePort.sendPort, //[1] Sendport
  ]);

  //3. Isar Connection.
  Isar isar = initiateMobileIsar(directory: isarDirectory);
  List<CatalogedBarcode> barcodeProperties =
      isar.catalogedBarcodes.where().findAllSync();

  //4. Get all coordiantes.
  List<CatalogedCoordinate> storedCoordinates =
      isar.catalogedCoordinates.where().findAllSync();

  //5. Get all markers.
  List<Marker> markers = isar.markers.where().findAllSync();

  //6. Get all fixed coordinates.
  List<CatalogedCoordinate> currentFixedCoordinates = isar.catalogedCoordinates
      .filter()
      .repeat(markers,
          (q, Marker element) => q.barcodeUIDMatches(element.barcodeUID))
      .findAllSync();

  //7. List of fixed BarcodeUIDs.
  List<String> currentFixedBarcodes =
      currentFixedCoordinates.map((e) => e.barcodeUID).toList();

  // log('GP: Setup Complete');

  List<InterBarcodeVector> realVectors = [];
  List<InterBarcodeVector> averagedInterBarcodeVectors = [];
  List<InterBarcodeVector> usedInterBarcodeVectors = [];

  /// this function is called by
  void processBarcodes(List message) {
    //1. Create realInterBarcodeVectors.
    List<InterBarcodeVector> interBarcodeVectorEntries =
        createInterBarcodeVectors(
      message,
      barcodeProperties,
      focalLength,
      defualtBarcodeSize,
      defualtBarcodeSize,
    );

    //2. Add new interBarcodeVectors. (If it has already been averaged then it is not added to this list.)
    for (InterBarcodeVector vector in interBarcodeVectorEntries) {
      if (!averagedInterBarcodeVectors.contains(vector) &&
          !usedInterBarcodeVectors.contains(vector)) {
        realVectors.add(vector);
      }
    }

    //3. Average the InterBarcodeVectors.
    List<InterBarcodeVector> newAveragedVectors =
        averageInterBarcodeVectors(realVectors);

    for (InterBarcodeVector averagedVector in newAveragedVectors) {
      //i. Add any new averaged interbarcode vectors.
      if (!averagedInterBarcodeVectors.contains(averagedVector) &&
          !usedInterBarcodeVectors.contains(averagedVector)) {
        averagedInterBarcodeVectors.add(averagedVector);
      }
    }

    //4. Start Building grids from fixed coordinates.
    for (var interBarcodeVector in averagedInterBarcodeVectors) {
      CatalogedCoordinate? newFixedCoordinate;

      if (currentFixedBarcodes.contains(interBarcodeVector.startBarcodeUID)) {
        //Marker found with StartBarcodeUID.
        //i. Get the fixed Coordinate.
        CatalogedCoordinate fixedCoordinate =
            currentFixedCoordinates.firstWhere(
          (element) => element.barcodeUID == interBarcodeVector.startBarcodeUID,
        );

        //ii. Calculate the new coordinate.
        vm.Vector3 coordinate = vm.Vector3(
          fixedCoordinate.coordinate!.x + interBarcodeVector.vector3.x,
          fixedCoordinate.coordinate!.y + interBarcodeVector.vector3.y,
          fixedCoordinate.coordinate!.z + interBarcodeVector.vector3.z,
        );

        //iii. Create the new CatalogedCoordinate.
        newFixedCoordinate = CatalogedCoordinate()
          ..barcodeUID = interBarcodeVector.endBarcodeUID
          ..coordinate = coordinate
          ..gridUID = fixedCoordinate.gridUID
          ..rotation = null
          ..timestamp = DateTime.now().millisecondsSinceEpoch;

        //iv. Add the new CatalogedCoordinate.
        if (!currentFixedBarcodes.contains(newFixedCoordinate.barcodeUID)) {
          currentFixedCoordinates.add(newFixedCoordinate);
          currentFixedBarcodes.add(newFixedCoordinate.barcodeUID);
        }

        //v. Move averagedInterBarcodeVector to used.
        usedInterBarcodeVectors.add(interBarcodeVector);
      } else if (currentFixedBarcodes
          .contains(interBarcodeVector.endBarcodeUID)) {
        //Marker found with EndBarcodeUID.
        //i. Get the fixed Coordinate.
        CatalogedCoordinate fixedCoordinate =
            currentFixedCoordinates.firstWhere(
          (element) => element.barcodeUID == interBarcodeVector.endBarcodeUID,
        );
        //ii. Calculate the new coordinate.
        vm.Vector3 coordinate = vm.Vector3(
          fixedCoordinate.coordinate!.x - interBarcodeVector.vector3.x,
          fixedCoordinate.coordinate!.y - interBarcodeVector.vector3.y,
          fixedCoordinate.coordinate!.z - interBarcodeVector.vector3.z,
        );
        //iii. Create the new CatalogedCoordinate.
        newFixedCoordinate = CatalogedCoordinate()
          ..barcodeUID = interBarcodeVector.startBarcodeUID
          ..coordinate = coordinate
          ..gridUID = fixedCoordinate.gridUID
          ..rotation = null
          ..timestamp = DateTime.now().millisecondsSinceEpoch;

        //iv. Add the new CatalogedCoordinate.
        if (!currentFixedBarcodes.contains(newFixedCoordinate.barcodeUID)) {
          currentFixedCoordinates.add(newFixedCoordinate);
          currentFixedBarcodes.add(newFixedCoordinate.barcodeUID);
        }

        //v. Move averagedInterBarcodeVector to used.
        usedInterBarcodeVectors.add(interBarcodeVector);
      }

      if (newFixedCoordinate != null) {
        //v. Check if coordiante has moved...

        int indexOfMatchingStoredCoordinate = storedCoordinates.indexWhere(
            (element) => element.barcodeUID == newFixedCoordinate!.barcodeUID);

        if (indexOfMatchingStoredCoordinate != -1) {
          CatalogedCoordinate matchingCoordinate =
              storedCoordinates[indexOfMatchingStoredCoordinate];

          if (matchingCoordinate.gridUID == newFixedCoordinate.gridUID) {
            //The Grid UIDs DO match.

            bool moved = hasMoved(
              newFixedCoordinate,
              matchingCoordinate,
              5,
            );

            if (moved) {
              List message = newFixedCoordinate.toMessage();
              sendPort.send(message);
              isar.writeTxnSync((isar) {
                isar.catalogedCoordinates
                    .filter()
                    .barcodeUIDMatches(newFixedCoordinate!.barcodeUID)
                    .deleteFirstSync();
                isar.catalogedCoordinates.putSync(newFixedCoordinate);
              });
            }
          } else {
            //The Grid UIDs DO NOT match.
            //Check if the barcode is a marker.
            int index = markers.indexWhere(
              (element) => element.barcodeUID == newFixedCoordinate!.barcodeUID,
            );

            if (index == -1) {
              //it is NOT a marker.
              List message = newFixedCoordinate.toMessage();
              sendPort.send(message);
              isar.writeTxnSync((isar) {
                isar.catalogedCoordinates
                    .filter()
                    .barcodeUIDMatches(newFixedCoordinate!.barcodeUID)
                    .deleteFirstSync();
                isar.catalogedCoordinates.putSync(newFixedCoordinate);
              });
            } else {
              //it IS a marker.
              //TODO: HORIFIED.. Throw a 'very' unintrucive error :D.
            }
          }
        }
      }
    }

    // log(currentFixedCoordinates.toString());
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
