// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';
import 'dart:isolate';
import 'package:flutter/painting.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:tswiri_database/export.dart';
import 'package:tswiri_database/functions/data/data_processing.dart';
import 'package:tswiri_database/functions/other/coordinate_translator.dart';
import 'package:tswiri_database/mobile_database.dart';
import 'package:tswiri_database/models/acclerometer/acceleromter_data.dart';
import 'package:tswiri_database/models/inter_barcode/on_image_barcode_data.dart';

import 'dart:math' as math;

import 'package:vector_math/vector_math_64.dart' as vm;

void navigationImageProcessor(List init) {
  //1. InitalMessage.
  int id = init[0]; //[0] ID.
  SendPort sendPort = init[1]; //[1] SendPort.
  String isarDirectory = init[2]; //[2] Isar directory.
  // double focalLength = init[3]; //[3] focalLength //Not Required anymore ?
  String selectedBarcodeUID = init[4]; //[4] SelectedContainer BarcodeUID
  double defualtBarcodeSize = init[5]; //[5] Default Barcode Size.
  int selectedBarcodeGrid = init[6]; //SelectedBarcodeGridUID.

  //2. ReceivePort.
  ReceivePort receivePort = ReceivePort();
  sendPort.send([
    'Sendport', //[0] Identifier.
    receivePort.sendPort, //[1] Sendport
  ]);

  //3. Isar Connection.
  Isar isar = initiateMobileIsar(directory: isarDirectory, inspector: false);
  List<CatalogedBarcode> barcodeProperties =
      isar.catalogedBarcodes.where().findAllSync();

  //5. Spawn BarcodeScanner.
  BarcodeScanner barcodeScanner = BarcodeScanner(
    formats: [
      BarcodeFormat.qrCode,
    ],
  );

  //6. Image Config
  InputImageData? inputImageData;
  Size? absoluteSize;
  Size? canvasSize;

  //7. GridProcessor
  SendPort? gridProcessor;

  //8. All Coordinates.
  List<CatalogedCoordinate> coordinates =
      isar.catalogedCoordinates.where().findAllSync();

  //9. Target Coordinate
  CatalogedCoordinate targetCoordinate = coordinates
      .firstWhere((element) => element.barcodeUID == selectedBarcodeUID);

  //Parent Grids.
  CatalogedGrid targetGrid =
      isar.catalogedGrids.getSync(targetCoordinate.gridUID)!;

  List<CatalogedGrid> parentGrids = [];

  if (targetGrid.parentBarcodeUID != null) {
    CatalogedCoordinate? catalogedCoordinate = isar.catalogedCoordinates
        .filter()
        .barcodeUIDMatches(targetGrid.barcodeUID)
        .findFirstSync();

    int i = 1;
    while (catalogedCoordinate != null && i < 100) {
      CatalogedGrid? catalogedGrid =
          isar.catalogedGrids.getSync(catalogedCoordinate.gridUID);

      if (catalogedGrid != null) {
        parentGrids.add(catalogedGrid);

        if (catalogedGrid.parentBarcodeUID != null) {
          catalogedCoordinate = isar.catalogedCoordinates
              .filter()
              .barcodeUIDMatches(catalogedGrid.parentBarcodeUID!)
              .findFirstSync();
          if (catalogedCoordinate != null) {
            catalogedGrid =
                isar.catalogedGrids.getSync(catalogedCoordinate.gridUID);
          }
        } else {
          catalogedCoordinate = null;
        }
      } else {
        catalogedCoordinate = null;
      }

      i++;
    }

    // log(parentGrids.toString());
  }

  List<CatalogedCoordinate> parentCoordinates = [];

  for (var parentGrid in parentGrids) {
    parentCoordinates.addAll(isar.catalogedCoordinates
        .filter()
        .gridUIDEqualTo(parentGrid.id)
        .findAllSync());
  }

  // log(parentGrids.length.toString());
  // log(parentGrids.toString());

  void _processImage(message) async {
    if (inputImageData != null && canvasSize != null) {
      InputImage inputImage = InputImage.fromBytes(
        bytes:
            (message[1] as TransferableTypedData).materialize().asUint8List(),
        inputImageData: inputImageData!,
      );

      final List<Barcode> barcodes =
          await barcodeScanner.processImage(inputImage);

      double? averageOnImageBarcodeSize;
      Offset? averageOffsetToBarcode;
      bool openMe = false;
      List onImageBarcodeDatas = [];

      List<dynamic> barcodeToPaint = [];

      for (Barcode barcode in barcodes) {
        List<Offset> conrnerPoints = <Offset>[];
        List<math.Point<num>> cornerPoints = barcode.cornerPoints!;

        for (var point in cornerPoints) {
          double x = translateX(point.x.toDouble(),
              inputImageData!.imageRotation, canvasSize!, inputImageData!.size);
          double y = translateY(point.y.toDouble(),
              inputImageData!.imageRotation, canvasSize!, inputImageData!.size);

          conrnerPoints.add(Offset(x, y));
        }

        //Add selected Bacode data.
        if (selectedBarcodeUID == barcode.displayValue) {
          barcodeToPaint = [
            barcode.displayValue, //Display value. [0]
            [
              //On Screen Points [1]
              conrnerPoints[0].dx,
              conrnerPoints[0].dy,
              conrnerPoints[1].dx,
              conrnerPoints[1].dy,
              conrnerPoints[2].dx,
              conrnerPoints[2].dy,
              conrnerPoints[3].dx,
              conrnerPoints[3].dy,
            ],
          ];
        }

        //Build onImageBarcodeData.
        OnImageBarcodeData onImageBarcodeData = OnImageBarcodeData(
          barcodeUID: barcode.displayValue!,
          onImageCornerPoints: [
            Offset(cornerPoints[0].x.toDouble(), cornerPoints[0].y.toDouble()),
            Offset(cornerPoints[1].x.toDouble(), cornerPoints[1].y.toDouble()),
            Offset(cornerPoints[2].x.toDouble(), cornerPoints[2].y.toDouble()),
            Offset(cornerPoints[3].x.toDouble(), cornerPoints[3].y.toDouble()),
          ],
          timestamp: message[3],
          accelerometerData: AccelerometerData(
            accelerometerEvent: vm.Vector3(
              message[2][0],
              message[2][1],
              message[2][2],
            ),
            userAccelerometerEvent: vm.Vector3(
              message[2][3],
              message[2][4],
              message[2][5],
            ),
          ),
        );

        onImageBarcodeDatas.add(onImageBarcodeData.toMessage());

        //Calculate phone angle.
        double phoneAngle =
            onImageBarcodeData.accelerometerData.calculatePhoneAngle();

        //Calculate screenCenterPoint.
        Offset screenCenterPoint = rotateOffset(
            offset: Offset(inputImageData!.size.height / 2,
                inputImageData!.size.width / 2),
            angleRadians: phoneAngle);

        //Calculate Barcode Center Point.
        Offset barcodeCenterPoint = rotateOffset(
            offset: onImageBarcodeData.barcodeCenterPoint,
            angleRadians: phoneAngle);

        //Calculate offset to Screen Center.
        Offset offsetToScreenCenter = barcodeCenterPoint - screenCenterPoint;

        //Calculate OnImageDiagonalLength.
        double onImageDiagonalLength = onImageBarcodeData.barcodeDiagonalLength;

        //Update averageOnImageBarcodeSize.
        if (averageOnImageBarcodeSize == null) {
          averageOnImageBarcodeSize = onImageDiagonalLength;
        } else {
          averageOnImageBarcodeSize =
              (averageOnImageBarcodeSize + onImageDiagonalLength) / 2;
        }

        //Find real barcode Size if it exists.
        double barcodeDiagonalLength = defualtBarcodeSize;
        if (barcodeProperties
            .any((element) => element.barcodeUID == barcode.displayValue)) {
          barcodeDiagonalLength = barcodeProperties
              .firstWhere(
                  (element) => element.barcodeUID == barcode.displayValue)
              .diagonalSideLength();
        }

        //Calculate the startBarcodeMMperPX.
        double startBarcodeMMperPX =
            onImageDiagonalLength / barcodeDiagonalLength;

        //Calcualte the realOffsetToScreenCenter.
        Offset realOffsetToScreenCenter =
            offsetToScreenCenter / startBarcodeMMperPX;

        int coordinateIndex = coordinates.indexWhere(
            (element) => element.barcodeUID == barcode.displayValue);

        if (coordinateIndex != -1) {
          //Coordiante found.
          CatalogedCoordinate catalogedCoordinate =
              coordinates[coordinateIndex];

          if (catalogedCoordinate.gridUID == selectedBarcodeGrid) {
            //In the correct grid.
            Offset realScreenCenter = Offset(catalogedCoordinate.coordinate!.x,
                    catalogedCoordinate.coordinate!.y) -
                realOffsetToScreenCenter;

            Offset offsetToBarcode = rotateOffset(
              offset: Offset(
                    targetCoordinate.coordinate!.x,
                    targetCoordinate.coordinate!.y,
                  ) -
                  realScreenCenter,
              angleRadians:
                  -onImageBarcodeData.accelerometerData.calculatePhoneAngle(),
            );

            averageOffsetToBarcode ??= offsetToBarcode;
          } else {
            //In the wrong grid.
            int gridIndex = parentGrids.indexWhere(
                (element) => element.id == catalogedCoordinate.gridUID);

            if (gridIndex != -1) {
              //Current Grid IS a parent of the targetBarcode.
              //Grid Reference.
              CatalogedGrid currentGrid = parentGrids[gridIndex];

              //Grid coordinates.
              List<CatalogedCoordinate> currentCoordinates = parentCoordinates
                  .where((element) => element.gridUID == currentGrid.id)
                  .toList();

              int indexOfParentBarcode = currentCoordinates.indexWhere(
                  (element) =>
                      element.barcodeUID == targetGrid.parentBarcodeUID);

              if (indexOfParentBarcode != -1) {
                //We are 1 grid above the target Grid

                CatalogedCoordinate targetCoordinate =
                    currentCoordinates[indexOfParentBarcode];

                //In the correct grid.
                Offset realScreenCenter = Offset(
                        catalogedCoordinate.coordinate!.x,
                        catalogedCoordinate.coordinate!.y) -
                    realOffsetToScreenCenter;

                Offset offsetToBarcode = rotateOffset(
                  offset: Offset(
                        targetCoordinate.coordinate!.x,
                        targetCoordinate.coordinate!.y,
                      ) -
                      realScreenCenter,
                  angleRadians: -onImageBarcodeData.accelerometerData
                      .calculatePhoneAngle(),
                );

                averageOffsetToBarcode ??= offsetToBarcode;
                openMe = true;
                if (targetCoordinate.barcodeUID == barcode.displayValue) {
                  barcodeToPaint = [
                    barcode.displayValue, //Display value. [0]
                    [
                      //On Screen Points [1]
                      conrnerPoints[0].dx,
                      conrnerPoints[0].dy,
                      conrnerPoints[1].dx,
                      conrnerPoints[1].dy,
                      conrnerPoints[2].dx,
                      conrnerPoints[2].dy,
                      conrnerPoints[3].dx,
                      conrnerPoints[3].dy,
                    ],
                  ];
                }
              } else {
                //We are more than 1 grid above the target grid.

                //Find the target barcode.
                CatalogedGrid targetGrid = parentGrids[gridIndex - 1];

                int indexOfTargetCoordinate = currentCoordinates.indexWhere(
                    (element) =>
                        element.barcodeUID == targetGrid.parentBarcodeUID);

                if (indexOfTargetCoordinate != -1) {
                  CatalogedCoordinate targetCoordinate =
                      currentCoordinates[indexOfTargetCoordinate];

                  //In the correct grid.
                  Offset realScreenCenter = Offset(
                          catalogedCoordinate.coordinate!.x,
                          catalogedCoordinate.coordinate!.y) -
                      realOffsetToScreenCenter;

                  Offset offsetToBarcode = rotateOffset(
                    offset: Offset(
                          targetCoordinate.coordinate!.x,
                          targetCoordinate.coordinate!.y,
                        ) -
                        realScreenCenter,
                    angleRadians: -onImageBarcodeData.accelerometerData
                        .calculatePhoneAngle(),
                  );

                  averageOffsetToBarcode ??= offsetToBarcode;
                  openMe = true;
                  if (targetCoordinate.barcodeUID == barcode.displayValue) {
                    barcodeToPaint = [
                      barcode.displayValue, //Display value. [0]
                      [
                        //On Screen Points [1]
                        conrnerPoints[0].dx,
                        conrnerPoints[0].dy,
                        conrnerPoints[1].dx,
                        conrnerPoints[1].dy,
                        conrnerPoints[2].dx,
                        conrnerPoints[2].dy,
                        conrnerPoints[3].dx,
                        conrnerPoints[3].dy,
                      ],
                    ];
                  }
                } else {
                  //TODO: ERROR.
                }
              }
            } else {
              //Current Grid is NOT a parent of the targetBarcode and the app cant find a way to the target.

              List errorMessage = [
                'error',
                'wrong_grid',
                targetCoordinate.gridUID, //Target Grid
                parentGrids.map((e) => e.id).toList(), //List Of Parent Grids.
              ];

              sendPort.send(errorMessage);
            }
          }
        } else {
          //Coordiante not found anywhere. aka barcode is unkown to the app.
          List errorMessage = [
            'error',
            'unkown_barcode',
          ];
          sendPort.send(errorMessage);
        }
      }

      List painterMessage = [
        'painterMessage', // [0]
        averageOnImageBarcodeSize ?? defualtBarcodeSize, // [1].
        //Average Offset to barcode [2].
        [
          averageOffsetToBarcode?.dx ?? 0,
          averageOffsetToBarcode?.dy ?? 0,
        ],
        barcodeToPaint, // Selected Barcode on Screen Points [3].
        openMe, //Should openBox [4]
      ];

      sendPort.send(painterMessage);

      if (gridProcessor != null) {
        gridProcessor!.send(onImageBarcodeDatas);
      }
    }
  }

  receivePort.listen((message) {
    if (message[0] == 'ImageProcessorConfig') {
      //Abosulte Image Size.
      absoluteSize = Size(message[1], message[2]);

      //Canvas size.
      canvasSize = Size(message[4], message[5]);

      //InputImageData.
      inputImageData = InputImageData(
        size: absoluteSize!,
        imageRotation: InputImageRotation.rotation90deg,
        inputImageFormat: InputImageFormat.values.elementAt(message[3]),
        planeData: null,
      );

      //Grid Processor.
      gridProcessor = message[6];

      // log('I$id: InputImageData Configured');
    } else if (message[0] == 'process') {
      _processImage(message);
    } else if (message[0] == 'update') {
      CatalogedCoordinate newCoordinate =
          catalogedCoordinateFromMessage(message);

      //Find the coordinate that has moved.
      int index = coordinates.indexWhere(
          (element) => element.barcodeUID == newCoordinate.barcodeUID);

      if (index != -1) {
        //If it exsits remove it and add the new coordiante.
        coordinates.removeAt(index);
        coordinates.add(newCoordinate);

        if (targetCoordinate.barcodeUID == newCoordinate.barcodeUID) {
          //If the target coordinate has moved update it.
          targetCoordinate = newCoordinate;
        }
      } else {
        coordinates.add(newCoordinate);
      }
    }
  });
}
