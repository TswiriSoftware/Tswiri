import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/calibrationAdapters/matched_calibration_data_adapter.dart';
import 'package:flutter_google_ml_kit/functions/dataProccessing/barcode_scanner_data_processing_functions.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter_google_ml_kit/globalValues/global_hive_databases.dart';
import 'package:flutter_google_ml_kit/globalValues/origin_data.dart';
import 'package:flutter_google_ml_kit/objects/raw_on_image_barcode_data.dart';
import 'package:flutter_google_ml_kit/objects/real_inter_barcode_offset.dart';
import 'package:flutter_google_ml_kit/objects/real_barcode_position.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'consolidated_database_visualization_view.dart';

class BarcodeScannerDataProcessingView extends StatefulWidget {
  const BarcodeScannerDataProcessingView(
      {Key? key, required this.allInterBarcodeData})
      : super(key: key);

  final List<RawOnImageInterBarcodeData> allInterBarcodeData;

  @override
  _BarcodeScannerDataProcessingViewState createState() =>
      _BarcodeScannerDataProcessingViewState();
}

class _BarcodeScannerDataProcessingViewState
    extends State<BarcodeScannerDataProcessingView> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: null,
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) =>
                        const ConsolidatedDatabaseVisualization()));
              },
              child: const Icon(Icons.check_circle_outline_rounded),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Processing Data'),
      ),
      body: Center(
        child: FutureBuilder(
          future: processData(widget.allInterBarcodeData),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return proceedButton(context);
            } else if (snapshot.hasError) {
              return Text(
                "${snapshot.error}",
                style: TextStyle(fontSize: 20, color: deeperOrange),
              );
            }
            // By default, show a loading spinner
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

//Implement data viewing

Future processData(List<RawOnImageInterBarcodeData> allInterBarcodeData) async {
  Box realPositionalData = await Hive.openBox(realPositionDataBoxName);
  Box<MatchedCalibrationDataHiveObject> matchedCalibrationDataBox =
      await Hive.openBox(matchedDataHiveBoxName);

  List<MatchedCalibrationDataHiveObject> matchedCalibrationData =
      matchedCalibrationDataBox.values.toList();

  List<RealInterBarcodeOffset> allRealInterBarcodeOffsets =
      addRealInterBarcodeOffsets(allInterBarcodeData, matchedCalibrationData);

  //All interBarcode Data from scan - deduplicated
  List<RealInterBarcodeOffset> deduplicatedRealInterBarcodeOffsets =
      addRealInterBarcodeOffsets(
          allInterBarcodeData.toSet().toList(), matchedCalibrationData);

  matchedCalibrationDataBox.close();

  //Calculates the average of each RealInterBarcode Data and removes outliers
  removeOutliers(deduplicatedRealInterBarcodeOffsets, allRealInterBarcodeOffsets);

  //List of all barcodes Scanned - deduplicated.
  List<RealBarcodePosition> realBarcodePositions =
      extractListOfScannedBarcodes(deduplicatedRealInterBarcodeOffsets);

  //Populate origin

  if (realBarcodePositions.any((element) => element.uid == '1')) {
    realBarcodePositions[
            realBarcodePositions.indexWhere((element) => element.uid == '1')] =
        origin(realBarcodePositions);
  } else {
    return Future.error('Error: Origin Not Scanned');
  }

  // ignore: todo
  //TODO: add error/exception when origin not in list.

  // print('realBarcodePositions');
  // for (RealBarcodePosition realBarcodePosition in realBarcodePositions) {
  //   print(realBarcodePosition);
  // }

  // Go through all realInterbarcode data at least realInterBarcodeData.length times (Little bit of overkill)
  //TODO: do while barcodes without offsets are getiing less.

  int nonNullPositions = 1;
  int nullPositions = realBarcodePositions.length;

  for (int i = 0; i <= deduplicatedRealInterBarcodeOffsets.length;) {
    for (RealBarcodePosition endBarcodeRealPosition in realBarcodePositions) {
      if (endBarcodeRealPosition.interBarcodeOffset == null) {
        //startBarcode : The barcode that we are going to use a reference (has offset relative to origin)
        //endBarcode : the barcode whose Real Position we are trying to find in this step , if we cant , we will skip and see if we can do so in the next round.
        // we are going to add the interbarcode offset between start and end barcodes to obtain the "position" of the end barcode.

        //This list contains all RealInterBarcode Offsets that contains the endBarcode.
        List<RealInterBarcodeOffset> relevantInterBarcodeOffsets =
            getRelevantInterBarcodeOffsets(
                deduplicatedRealInterBarcodeOffsets, endBarcodeRealPosition);

        //This list contains all realBarcodePositions with a Offset (effectivley to the Origin).
        List<RealBarcodePosition> barcodesWithOffset =
            getBarcodesWithOffset(realBarcodePositions);

        //sorts by least amount of steps to origin
        barcodesWithOffset.sort(mySortComparison);

        int startBarcodeIndex = findStartBarcodeIndex(
            barcodesWithOffset, relevantInterBarcodeOffsets);

        if (indexIsValid(startBarcodeIndex)) {
          //RealBarcodePosition of startBarcode.
          RealBarcodePosition startBarcode =
              barcodesWithOffset[startBarcodeIndex];

          //Index of InterBarcodeOffset which contains startBarcode.
          int interBarcodeOffsetIndex = findInterBarcodeOffset(
              relevantInterBarcodeOffsets,
              startBarcode,
              endBarcodeRealPosition);

          if (indexIsValid(interBarcodeOffsetIndex)) {
            //Determine whether to add or subtract the interBarcode Offset.
            determinesInterBarcodeOffsetDirection(
                relevantInterBarcodeOffset:
                    relevantInterBarcodeOffsets[interBarcodeOffsetIndex],
                endBarcodeRealPosition: endBarcodeRealPosition,
                startBarcode: startBarcode);
            nonNullPositions++;
          }
        }
        //else "Skip"
      }
    }
    i++;
    if (nonNullPositions == nullPositions) {
      break;
    }
  }

  //Writes data to Hive Database
  for (RealBarcodePosition realBarcodePosition in realBarcodePositions) {
    writeValidBarcodePositionsToDatabase(
        realBarcodePosition, realPositionalData);
  }
  return '';
}

List<RealInterBarcodeOffset> removeOutliers(List<RealInterBarcodeOffset> deduplicatedRealInterBarcodeOffsets, List<RealInterBarcodeOffset> allRealInterBarcodeOffsets) {
  //Calculates the average of each RealInterBarcode Data and removes outliers
  for (RealInterBarcodeOffset realInterBacrodeOffset
      in deduplicatedRealInterBarcodeOffsets) {
    //All similar interBarcodeOffsets ex 1_2 will return all 1_2 interbarcodeOffsets
    List<RealInterBarcodeOffset> similarInterBarcodeOffsets =
        findSimilarInterBarcodeOffsets(
            allRealInterBarcodeOffsets, realInterBacrodeOffset);
  
    //Sort similarInterBarcodeOffsets by distance
    similarInterBarcodeOffsets.sort((a, b) =>
        a.interBarcodeOffset.distance.compareTo(b.interBarcodeOffset.distance));
  
    //Indexes
    int medianIndex = (similarInterBarcodeOffsets.length ~/ 2);
    int q1Index = ((similarInterBarcodeOffsets.length / 2) ~/ 2);
    int q3Index = medianIndex + q1Index;
  
    //Values
    double median =
        similarInterBarcodeOffsets[medianIndex].interBarcodeOffset.distance;
    double q1 =
        (similarInterBarcodeOffsets[q1Index].interBarcodeOffset.distance +
                median) /
            2;
    double q3 =
        (similarInterBarcodeOffsets[q3Index].interBarcodeOffset.distance +
                median) /
            2;
    double interQRange = q3 - q1;
    double q1Boundry = q1 - interQRange * 1.5; //Lower boundry
    double q3Boundry = q3 + interQRange * 1.5; //Upper boundry
  
    //Remove data outside the boundries
    similarInterBarcodeOffsets.removeWhere((element) =>
        element.interBarcodeOffset.distance <= q1Boundry &&
        element.interBarcodeOffset.distance >= q3Boundry);
  
    //Loops through all similar interBarcodeOffsets to calculate the average
    for (RealInterBarcodeOffset similarInterBarcodeOffset
        in similarInterBarcodeOffsets) {
      calculateAverageOffsets(
          similarInterBarcodeOffset, realInterBacrodeOffset);
      realInterBacrodeOffset.distanceFromCamera =
          (realInterBacrodeOffset.distanceFromCamera +
                  similarInterBarcodeOffset.distanceFromCamera) /
              2;
    }
  }
   List<RealInterBarcodeOffset> hello = [];

  return hello;
}
