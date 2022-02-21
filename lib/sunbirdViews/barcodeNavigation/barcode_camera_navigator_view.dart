import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/VisionDetectorViews/camera_view.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/scanningAdapters/real_barocode_position_entry.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/type_offset_converters.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter_google_ml_kit/globalValues/global_hive_databases.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcodeNavigation/painter/barcode_navigation_painter.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:hive/hive.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:vector_math/vector_math.dart';
import '../../databaseAdapters/allBarcodes/barcode_entry.dart';
import '../../databaseAdapters/calibrationAdapters/matched_calibration_data_adapter.dart';
import '../../functions/dataProccessing/barcode_scanner_data_processing_functions.dart';
import '../../objects/accelerometer_data.dart';
import '../../objects/raw_on_image_barcode_data.dart';
import '../../objects/raw_on_image_inter_barcode_data.dart';
import '../../objects/real_inter_barcode_offset.dart';
import 'dart:developer';

class BarcodeCameraNavigatorView extends StatefulWidget {
  final String qrcodeID;
  const BarcodeCameraNavigatorView({Key? key, required this.qrcodeID})
      : super(key: key);

  @override
  _BarcodeCameraNavigatorViewState createState() =>
      _BarcodeCameraNavigatorViewState();
}

class _BarcodeCameraNavigatorViewState
    extends State<BarcodeCameraNavigatorView> {
  BarcodeScanner barcodeScanner =
      GoogleMlKit.vision.barcodeScanner([BarcodeFormat.qrCode]);

  bool isBusy = false;
  CustomPaint? customPaint;

  //Used in finding the barcode.
  Map<String, Offset> realBarcodePosition = {};

  //Used to check if any barcodes have moved.
  //TODO: Convert allRealInterBarcodeOffsets to a map of type:
  //Map<String, List<RealInterBarcodeOffset>> : String is the startBarcodeUID_endBarcodeUID and then a list of RealInterBarcodeOffsets.
  List<RealInterBarcodeOffset> allRealInterBarcodeOffsets = [];
  Set<RealInterBarcodeOffset> finalSetRealInterBarcodeOffsets = {};

  Set<int> checksOut = {};
  Set<int> allScannedBarcodes = {};

  Vector3 accelerometerEvent = Vector3(0, 0, 0);
  Vector3 userAccelerometerEvent = Vector3(0, 0, 0);

  @override
  void initState() {
    accelerometerEvents.listen((AccelerometerEvent event) {
      accelerometerEvent = Vector3(event.x, event.y, event.z);
    });
    userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      userAccelerometerEvent = Vector3(event.x, event.y, event.z);
    });

    super.initState();
  }

  @override
  void dispose() {
    barcodeScanner.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [],
          ),
        ),
        body: CameraView(
          color: limeGreenMuted,
          title: 'Barcode Finder',
          customPaint: customPaint,
          onImage: (inputImage) {
            processImage(inputImage);
          },
        ));
  }

  Future<void> processImage(InputImage inputImage) async {
    //This list contains all realBarcodePositions.
    Box<RealBarcodePostionEntry> realBarcodePositionDataBox =
        await Hive.openBox(realPositionDataBoxName);

    //This list contains all generated barcodes and their real life sizes.
    List<BarcodeDataEntry> barcodeDataEntries = await getGeneratedBarcodeData();

    // List of all matchedCalibration Data
    List<MatchedCalibrationDataHiveObject> matchedCalibrationData =
        await getMatchedCalibrationData();

    if (realBarcodePositionDataBox.isNotEmpty) {
      realBarcodePosition = getBarcodeRealPosition(realBarcodePositionDataBox);

      if (isBusy) return;
      isBusy = true;
      final barcodes = await barcodeScanner.processImage(inputImage);

      if (inputImage.inputImageData?.size != null &&
          inputImage.inputImageData?.imageRotation != null) {
        if (barcodes.length >= 2) {
          //1. Get all the onImageBarcodeData from the current Istance.

          //OnImageBarcodeData in this istance.
          List<RawOnImageBarcodeData> allRawOnImageBarcodeData = [
            RawOnImageBarcodeData(
                barcodes: barcodes,
                timestamp: DateTime.now().millisecondsSinceEpoch,
                accelerometerData: getAccelerometerData())
          ];

          // This list contains all onImageInterBarcodeData from the image instant.
          List<RawOnImageInterBarcodeData> allOnImageInterBarcodeData =
              buildAllOnImageInterBarcodeData(allRawOnImageBarcodeData);

          // Builds and adds all the real realInterBarcodeOffsets in this instance.
          allRealInterBarcodeOffsets.addAll(buildAllRealInterBarcodeOffsets(
              allOnImageInterBarcodeData: allOnImageInterBarcodeData,
              matchedCalibrationData: matchedCalibrationData,
              barcodeDataEntries: barcodeDataEntries));

          //This code above can be run sustainably.//

        }

        //Once AllRealInterBarcodeOffsets reaches a length where each barcode has been scanned at least 4 times.
        //We can run futher processing and clear the backlog.
        //We can then isolate the barcodes which have moved by comparing their positional vectors with the stored vectors.
        //We give some degree of error so we dont get false positives.
        if (allRealInterBarcodeOffsets.length >= barcodes.length * 4) {
          //Add all unique realInterBarcodeOffsets.
          Set<RealInterBarcodeOffset> uniqueRealInterBarcodeOffsets = {};
          uniqueRealInterBarcodeOffsets
              .addAll(allRealInterBarcodeOffsets.toSet());

          //This adds all builds the tree from all scanned barcodes.
          finalSetRealInterBarcodeOffsets.addAll(processRealInterBarcodeData(
              uniqueRealInterBarcodeOffsets:
                  uniqueRealInterBarcodeOffsets.toList(),
              allRealInterBarcodeOffsets: allRealInterBarcodeOffsets));

          //Clears the list so it can be repopulated.
          allRealInterBarcodeOffsets.clear();

          for (RealInterBarcodeOffset realInterBarcodeOffset
              in finalSetRealInterBarcodeOffsets) {
            //Retrive stored StartBarcodePosition
            RealBarcodePostionEntry startBarcodePosition =
                realBarcodePositionDataBox
                    .get(realInterBarcodeOffset.uidStart)!;
            //Retrive stored EndBarcodePosition
            RealBarcodePostionEntry endBarcodePosition =
                realBarcodePositionDataBox.get(realInterBarcodeOffset.uidEnd)!;
            //Calculate the stored RealInterBarcodePosition.
            Offset storedInterbarcodeOffset =
                typeOffsetToOffset(endBarcodePosition.offset) -
                    typeOffsetToOffset(startBarcodePosition.offset);

            //This is to calculate the amount of positional error we allow for.
            double currentX = realInterBarcodeOffset.realInterBarcodeOffset.dx;
            double currentXLowerBoundry = currentX - (10);
            double currentXUpperBoundry = currentX + (10);

            double currentY = realInterBarcodeOffset.realInterBarcodeOffset.dy;
            double currentYLowerBoundry = currentY - (10);
            double currentYUpperBoundry = currentY + (10);

            double storedX = storedInterbarcodeOffset.dx;
            double storedY = storedInterbarcodeOffset.dy;

            allScannedBarcodes.addAll({
              int.parse(realInterBarcodeOffset.uidStart),
              int.parse(realInterBarcodeOffset.uidEnd)
            });

            if (storedX <= currentXUpperBoundry &&
                storedX >= currentXLowerBoundry &&
                storedY <= currentYUpperBoundry &&
                storedY >= currentYLowerBoundry) {
              realInterBarcodeOffset.checksOut = true;
              checksOut.addAll({
                int.parse(realInterBarcodeOffset.uidStart),
                int.parse(realInterBarcodeOffset.uidEnd)
              });
            } else {
              realInterBarcodeOffset.checksOut = false;
            }
            // if (realInterBarcodeOffset.checked == false) {
            //   log('Not Correct:');
            //   log(realInterBarcodeOffset.uid +
            //       ', ' +
            //       realInterBarcodeOffset.realInterBarcodeOffset.dx.toString() +
            //       ', ' +
            //       realInterBarcodeOffset.realInterBarcodeOffset.dy.toString());
            //   log('${realInterBarcodeOffset.uidStart}_${realInterBarcodeOffset.uidEnd}, ${storedInterbarcodeOffset.dx}, ${storedInterbarcodeOffset.dy}');
            // }
          }
        }

        // log(checksOut.toString());
        // log(allScannedBarcodes.toString());

        log('These barcodes have moved: ' +
            allScannedBarcodes
                .where((element) => !checksOut.contains(element))
                .toString());

        final painter = BarcodeDetectorPainterNavigation(
            barcodes,
            inputImage.inputImageData!.size,
            inputImage.inputImageData!.imageRotation,
            realBarcodePosition,
            widget.qrcodeID);
        customPaint = CustomPaint(painter: painter);
      } else {
        customPaint = null;
      }
      isBusy = false;
      if (mounted) {
        setState(() {});
      }
    }
  }

  Map<String, Offset> getBarcodeRealPosition(Box barcodeRealPosition) {
    Map map = barcodeRealPosition.toMap();
    Map<String, Offset> barcodeReaPositionMap = {};
    map.forEach((key, value) {
      RealBarcodePostionEntry data = value;
      barcodeReaPositionMap.update(
        key,
        (value) => Offset(data.offset.x, data.offset.y),
        ifAbsent: () => Offset(data.offset.x, data.offset.y),
      );
    });
    return barcodeReaPositionMap;
  }

  ///This stores the AccelerometerEvent and UserAccelerometerEvent at an instant.
  AccelerometerData getAccelerometerData() {
    return AccelerometerData(
        accelerometerEvent: accelerometerEvent,
        userAccelerometerEvent: userAccelerometerEvent);
  }
}
