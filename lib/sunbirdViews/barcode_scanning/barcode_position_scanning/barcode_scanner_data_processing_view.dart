import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/allBarcodes/barcode_data_entry.dart';

import 'package:flutter_google_ml_kit/functions/dataProccessing/barcode_scanner_data_processing_functions.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter_google_ml_kit/globalValues/global_hive_databases.dart';
import 'package:flutter_google_ml_kit/globalValues/shared_prefrences.dart';
import 'package:flutter_google_ml_kit/objects/raw_on_image_barcode_data.dart';
import 'package:flutter_google_ml_kit/objects/raw_on_image_inter_barcode_data.dart';
import 'package:flutter_google_ml_kit/objects/real_inter_barcode_offset.dart';
import 'package:flutter_google_ml_kit/objects/real_barcode_position.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../databaseAdapters/calibrationAdapter/distance_from_camera_lookup_entry.dart';
import '../../../databaseAdapters/scanningAdapter/real_barcode_position_entry.dart';
import '../../../widgets/barcode_scanning_widgets/real_position_display_widget_old.dart';
import 'real_barcode_position_database_visualization_view.dart';

class BarcodeScannerDataProcessingView extends StatefulWidget {
  const BarcodeScannerDataProcessingView(
      {Key? key,
      required this.allRawOnImageBarcodeData,
      required this.shelfUID})
      : super(key: key);

  final List<RawOnImageBarcodeData> allRawOnImageBarcodeData;
  final int shelfUID;
  @override
  _BarcodeScannerDataProcessingViewState createState() =>
      _BarcodeScannerDataProcessingViewState();
}

class _BarcodeScannerDataProcessingViewState
    extends State<BarcodeScannerDataProcessingView> {
  @override
  void initState() {
    super.initState();
  }

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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            RealBarcodePositionDatabaseVisualizationView(
                                shelfUID: widget.shelfUID))).then((value) =>
                    processData(
                        widget.allRawOnImageBarcodeData, widget.shelfUID));
              },
              child: const Icon(Icons.check_circle_outline_rounded),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Processing Data'),
      ),
      body: Center(
        child: FutureBuilder<List<RealBarcodePosition>>(
          future: processData(widget.allRawOnImageBarcodeData, widget.shelfUID),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<RealBarcodePosition> data = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.only(top: 2.5),
                child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return RealPositionDisplayWidget(
                          realBarcodePosition: data[index]);
                    }),
              );
            } else if (snapshot.hasError) {
              return Text(
                "${snapshot.error}",
                style: const TextStyle(fontSize: 20, color: deeperOrange),
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

//1. Get all initial data that will be used.
//
//  1.1 getMatchedCalibrationData (This is the lookupTable that allows for distance from camera calculations)
//  1.2 getGeneratedBarcodeData (This list contains all the real life barcode sizes)
//
//2. Build a list of all onImageInterBarcodeData based on allRawOnImageBarcodeData.
//
//3. Create list containing AllRealInterBarcodeOffsets and uniqueRealInterBarcodeOffsets.
//
//  3.1 buildAllRealInterBarcodeOffsets.
//    i. Takes the phones rotation into consideration
//    ii. It calculates the real distance between barcodes.
//    iii. It calculates the distance between the barcodes and the camera.
//
//  3.2 uniqueRealInterBarcodeOffsets
//    i. Removes duplicate realInterBarcodeOffsets.
//
//4. processRealInterBarcodeData
//    i. Removes data outleirs
//    ii. Calculates averages with the remaining data.
//

Future<List<RealBarcodePosition>> processData(
    List<RawOnImageBarcodeData> allRawOnImageBarcodeData, int shelfUID) async {
  //1.1 List of all matchedCalibration Data
  List<DistanceFromCameraLookupEntry> distanceFromCameraLookup =
      await getMatchedCalibrationData();

  //1.2 This list contains all barcodes and their real life sizes.
  List<BarcodeDataEntry> allBarcodes = await getAllExistingBarcodes();

  //2. This list contains all onImageInterBarcodeData.
  List<RawOnImageInterBarcodeData> allOnImageInterBarcodeData =
      buildAllOnImageInterBarcodeData(allRawOnImageBarcodeData);

  //3.1 Calculates all real interBarcodeOffsets.
  //Get the camera's focal length
  final prefs = await SharedPreferences.getInstance();
  double focalLength = prefs.getDouble(focalLengthPreference) ?? 0;

  //Check Function for details.
  List<RealInterBarcodeOffset> allRealInterBarcodeOffsets =
      buildAllRealInterBarcodeOffsets(
    allOnImageInterBarcodeData: allOnImageInterBarcodeData,
    calibrationLookupTable: distanceFromCameraLookup,
    allBarcodes: allBarcodes,
    focalLength: focalLength,
  );

  //3.2 This list contains only unique realInterBarcodeOffsets
  List<RealInterBarcodeOffset> uniqueRealInterBarcodeOffsets =
      allRealInterBarcodeOffsets.toSet().toList();

  //4. To build the list of final RealInterBarcodeOffsets we:
  //  i. Remove all the outliers from allOnImageInterBarcodeData
  //  ii. Then use the uniqueRealInterBarcodeOffsets as a reference to
  //      calculate the average from allRealInterBarcodeOffsets.
  List<RealInterBarcodeOffset> finalRealInterBarcodeOffsets =
      processRealInterBarcodeData(
          uniqueRealInterBarcodeOffsets: uniqueRealInterBarcodeOffsets,
          listOfRealInterBarcodeOffsets: allRealInterBarcodeOffsets);

  //List of unique barcodes that we want to write the positions of.
  List<RealBarcodePosition> realBarcodePositions =
      extractListOfScannedBarcodes(finalRealInterBarcodeOffsets, allBarcodes);

  // //Populate origin
  // if (realBarcodePositions.any((element) => element.isMarker == true)) {
  //   int index =
  //       realBarcodePositions.indexWhere((element) => element.isMarker == true);
  //   RealBarcodePosition origin = realBarcodePositions[index];

  //   realBarcodePositions[index] = RealBarcodePosition(
  //       uid: origin.uid,
  //       zOffset: 0,
  //       offset: const Offset(0, 0),

  //       timestamp: 0);
  // } else {
  //   //If the origin was not scanned then the app will throw an error
  //   return Future.error('Error: No Fixed Barcodes.');
  // }

  int nonNullPositions = 1;
  int nonNullPositionsInPreviousIteration = realBarcodePositions.length - 1;

  for (int i = 0; i <= uniqueRealInterBarcodeOffsets.length;) {
    nonNullPositionsInPreviousIteration = nonNullPositions;
    for (RealBarcodePosition endBarcodeRealPosition in realBarcodePositions) {
      if (endBarcodeRealPosition.offset == null) {
        //startBarcode : The barcode that we are going to use as a reference (has offset relative to origin)
        //endBarcode : the barcode whose Real Position we are trying to find in this step , if we cant , we will skip and see if we can do so in the next round.
        // we are going to add the interbarcode offset between start and end barcodes to obtain the "position" of the end barcode.

        //This list contains all RealInterBarcode Offsets that contains the endBarcode.
        List<RealInterBarcodeOffset> relevantBarcodeOffset =
            getRelevantInterBarcodeOffsets(
                uniqueRealInterBarcodeOffsets, endBarcodeRealPosition);

        //This list contains all realBarcodePositions with a Offset (effectivley to the Origin).
        List<RealBarcodePosition> barcodesWithOffset =
            getBarcodesWithOffset(realBarcodePositions);

        //Finds a relevant startBarcode based on the relevantInterbarcodeOffsets and BarcodesWithOffset.
        int startBarcodeIndex =
            findStartBarcodeIndex(barcodesWithOffset, relevantBarcodeOffset);

        if (indexIsValid(startBarcodeIndex)) {
          //RealBarcodePosition of startBarcode.
          RealBarcodePosition startBarcode =
              barcodesWithOffset[startBarcodeIndex];

          //Index of InterBarcodeOffset which contains startBarcode.
          int interBarcodeOffsetIndex = findInterBarcodeOffset(
              relevantBarcodeOffset, startBarcode, endBarcodeRealPosition);

          if (indexIsValid(interBarcodeOffsetIndex)) {
            //Determine whether to add or subtract the interBarcode Offset.
            endBarcodeRealPosition.timestamp =
                relevantBarcodeOffset[interBarcodeOffsetIndex].timestamp;
            if (relevantBarcodeOffset[interBarcodeOffsetIndex].uidEnd ==
                endBarcodeRealPosition.uid) {
              //Calculate the interBarcodeOffset
              endBarcodeRealPosition.offset = startBarcode.offset! +
                  relevantBarcodeOffset[interBarcodeOffsetIndex].offset;
              //Calculate the z difference from start barcode
              // endBarcodeRealPosition.zOffset = startBarcode.zOffset +
              //     relevantBarcodeOffset[interBarcodeOffsetIndex].zOffset;
            } else if (relevantBarcodeOffset[interBarcodeOffsetIndex]
                    .uidStart ==
                endBarcodeRealPosition.uid) {
              //Calculate the interBarcodeOffset
              endBarcodeRealPosition.offset = startBarcode.offset! -
                  relevantBarcodeOffset[interBarcodeOffsetIndex].offset;
              //Calculate the z difference from start barcode
              // endBarcodeRealPosition.zOffset = startBarcode.zOffset -
              //     relevantBarcodeOffset[interBarcodeOffsetIndex].zOffset;
            }

            //log(startBarcode.startBarcodeDistanceFromCamera.toString());

            nonNullPositions++;
          }
        }
        //else "Skip"
      }
    }
    i++;
    //If all barcodes have been mapped it will break the loop.
    if (nonNullPositions == nonNullPositionsInPreviousIteration) {
      break;
    }
  }

  //Open realPositionalData box.
  Box<RealBarcodePositionEntry> realPositionalData =
      await Hive.openBox(realPositionsBoxName);

  await realPositionalData.clear();

  //Writes data to Hive Database
  for (RealBarcodePosition realBarcodePosition in realBarcodePositions) {
    writeValidBarcodePositionsToDatabase(
        realBarcodePosition, realPositionalData, shelfUID);
  }

  //Sort realBarcodePositions by uid numericalvalue.
  realBarcodePositions
      .sort((a, b) => int.parse(a.uid).compareTo(int.parse(b.uid)));

  return realBarcodePositions;
}
