import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/data_processing/barcode_scanner_data_processing_functions.dart';
import 'package:flutter_google_ml_kit/global_values/shared_prefrences.dart';
import 'package:flutter_google_ml_kit/isar_database/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/marker/marker.dart';
import 'package:flutter_google_ml_kit/isar_database/real_interbarcode_vector_entry/real_interbarcode_vector_entry.dart';
import 'package:flutter_google_ml_kit/objects/raw_on_image_barcode_data.dart';
import 'package:flutter_google_ml_kit/objects/raw_on_image_inter_barcode_data.dart';
import 'package:flutter_google_ml_kit/objects/real_barcode_position.dart';
import 'package:flutter_google_ml_kit/objects/real_inter_barcode_offset.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcode_scanning/barcode_position_scanner/functions/build_real_inter_barcode_offsets.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcode_scanning/barcode_position_scanner/functions/functions.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckInterBarcodeData extends StatefulWidget {
  const CheckInterBarcodeData(
      {Key? key,
      required this.allRawOnImageBarcodeData,
      required this.containerEntry})
      : super(key: key);
  final List<RawOnImageBarcodeData> allRawOnImageBarcodeData;
  final ContainerEntry containerEntry;
  @override
  State<CheckInterBarcodeData> createState() => _CheckInterBarcodeDataState();
}

class _CheckInterBarcodeDataState extends State<CheckInterBarcodeData> {
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
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        'Checking Positions',
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  Widget _body() {
    return FutureBuilder<List<RealInterBarcodeVectorEntry>>(
      future: checkPositions(widget.allRawOnImageBarcodeData),
      builder: (context, snapshot) {
        if (snapshot.hasData && mounted) {
          List<RealInterBarcodeVectorEntry> data = snapshot.data!;
          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Text(
                        data[index].startBarcodeUID +
                            ' => ' +
                            data[index].endBarcodeUID,
                      ),
                    ],
                  ),
                );
              });
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<List<RealInterBarcodeVectorEntry>> checkPositions(
      List<RawOnImageBarcodeData> allRawOnImageBarcodeData) async {
    //1. Build all OnImageInterBarcodeData.
    List<RawOnImageInterBarcodeData> allOnImageInterBarcodeData =
        buildAllOnImageInterBarcodeData(allRawOnImageBarcodeData);

    final prefs = await SharedPreferences.getInstance();
    double focalLength = prefs.getDouble(focalLengthPreference) ?? 0;

    //2. Build RealInterBarcodeOffsets.
    List<RealInterBarcodeOffset> allRealInterBarcodeOffsets =
        buildAllRealInterBarcodeOffsets(
      allOnImageInterBarcodeData: allOnImageInterBarcodeData,
      database: isarDatabase!,
      focalLength: focalLength,
    );

    //3. Find all uniqueRealInterBarcodeOffsets.
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

    List<RealInterBarcodeVectorEntry> newData = [];
    int creation = DateTime.now().millisecondsSinceEpoch;
    for (RealInterBarcodeOffset interBarcodeOffset
        in finalRealInterBarcodeOffsets) {
      RealInterBarcodeVectorEntry vectorEntry = RealInterBarcodeVectorEntry()
        ..startBarcodeUID = interBarcodeOffset.uidStart
        ..endBarcodeUID = interBarcodeOffset.uidEnd
        ..x = interBarcodeOffset.offset.dx
        ..y = interBarcodeOffset.offset.dy
        ..z = interBarcodeOffset.zOffset
        ..timestamp = interBarcodeOffset.timestamp
        ..creationTimestamp = creation;
      newData.add(vectorEntry);
    }

    //5. Build Grid around the found container.
    String foundBarcodeUID = widget.containerEntry.barcodeUID!;
    int foundContainerIndex = newData.indexWhere((element) =>
        element.startBarcodeUID == foundBarcodeUID ||
        element.endBarcodeUID == foundBarcodeUID);

    if (foundContainerIndex != -1) {}

    List<RealBarcodePosition> newRealBarcodePositions =
        generateGridFromPoint(newData, widget.containerEntry.barcodeUID!);

    //Comparisons.
    List<RealInterBarcodeVectorEntry> oldData =
        isarDatabase!.realInterBarcodeVectorEntrys.where().findAllSync();

    List<RealBarcodePosition> oldRealBarcodePositions =
        generateGridFromPoint(oldData, widget.containerEntry.barcodeUID!);
    //log('old: ' + oldRealBarcodePositions.toString());

    //log('new: ' + newRealBarcodePositions.toString());

    //TODO: Implement propper null checks.

    List<String> movedBarcodes = [];
    for (RealBarcodePosition item in newRealBarcodePositions) {
      RealBarcodePosition newPosition = item;
      RealBarcodePosition? oldPosition = oldRealBarcodePositions
          .where((element) => element.uid == newPosition.uid)
          .first;
      if (check2(newPosition, oldPosition)) {
        movedBarcodes.add(newPosition.uid);
      }
    }
    log(movedBarcodes.toString());

    return newData;
  }

  bool check2(
      RealBarcodePosition? newPosition, RealBarcodePosition? oldPosition) {
    if (newPosition != null && oldPosition != null) {
      double errorValue = 50; // max error value in mm
      double currentX = newPosition.offset!.dx;
      double currentXLowerBoundry = currentX - (errorValue);
      double currentXUpperBoundry = currentX + (errorValue);

      double currentY = newPosition.offset!.dy;
      double currentYLowerBoundry = currentY - (errorValue);
      double currentYUpperBoundry = currentY + (errorValue);

      double storedX = oldPosition.offset!.dx;
      double storedY = oldPosition.offset!.dy;

      if (storedX <= currentXUpperBoundry &&
          storedX >= currentXLowerBoundry &&
          storedY <= currentYUpperBoundry &&
          storedY >= currentYLowerBoundry) {
        return false;
      } else {
        return true;
      }
    }
    return false;
  }

  bool check(
      RealInterBarcodeVectorEntry current, RealInterBarcodeVectorEntry stored) {
    double errorValue = 50; // max error value in mm
    double currentX = current.x;
    double currentXLowerBoundry = currentX - (errorValue);
    double currentXUpperBoundry = currentX + (errorValue);

    double currentY = current.y;
    double currentYLowerBoundry = currentY - (errorValue);
    double currentYUpperBoundry = currentY + (errorValue);

    double storedX = stored.x;
    double storedY = stored.y;

    if (storedX <= currentXUpperBoundry &&
        storedX >= currentXLowerBoundry &&
        storedY <= currentYUpperBoundry &&
        storedY >= currentYLowerBoundry) {
      return false;
    } else {
      return true;
    }
  }
}

List<RealBarcodePosition> generateGridFromPoint(
    List<RealInterBarcodeVectorEntry> newInterBarcodeVectors,
    String barcodeUID) {
  //3. Get Markers
  List<Marker> markers = isarDatabase!.markers.where().findAllSync();

  if (markers.isEmpty) {
    log('No Markers');
    return [];
  }

  //4. Pick Origin
  Marker origin = Marker()
    ..barcodeUID = barcodeUID
    ..parentContainerUID = '';

  List<String> barcodes = [];

  List<RealInterBarcodeOffset> allRealInterBarcodeOffsets = [];
  for (RealInterBarcodeVectorEntry data in newInterBarcodeVectors) {
    allRealInterBarcodeOffsets.add(
      RealInterBarcodeOffset(
        uid: data.startBarcodeUID + '-' + data.endBarcodeUID,
        uidStart: data.startBarcodeUID,
        uidEnd: data.endBarcodeUID,
        offset: Offset(data.x, data.y),
        zOffset: data.z,
        timestamp: data.timestamp,
      ),
    );
    //Add unique barcodes to barcodes.
    if (!barcodes.contains(data.startBarcodeUID)) {
      barcodes.add(data.startBarcodeUID);
    } else if (!barcodes.contains(data.endBarcodeUID)) {
      barcodes.add(data.endBarcodeUID);
    }
  }

  //6. Generate list of barcodePositions, positions are null at this stage, we want to calculate the positions.

//7. Populate the orgin.
  List<RealBarcodePosition> realBarcodePositions = [];
  realBarcodePositions.add(RealBarcodePosition(
      uid: origin.barcodeUID,
      offset: const Offset(0, 0),
      zOffset: 0,
      timestamp: 0));

  for (String barcode in barcodes) {
    if (barcode != origin.barcodeUID) {
      realBarcodePositions.add(
        RealBarcodePosition(uid: barcode),
      );
    }
  }

  //8. Find all unique RealInterBarcodeOffsets.
  List<RealInterBarcodeOffset> uniqueRealInterBarcodeOffsets =
      allRealInterBarcodeOffsets.toSet().toList();

  //log(uniqueRealInterBarcodeOffsets.toString());

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
            uniqueRealInterBarcodeOffsets
                .where((element) =>
                    element.uidStart == endBarcodeRealPosition.uid ||
                    element.uidEnd == endBarcodeRealPosition.uid)
                .toList();

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
              endBarcodeRealPosition.zOffset = (startBarcode.zOffset! +
                  relevantBarcodeOffset[interBarcodeOffsetIndex].zOffset);
            } else if (relevantBarcodeOffset[interBarcodeOffsetIndex]
                    .uidStart ==
                endBarcodeRealPosition.uid) {
              //Calculate the interBarcodeOffset
              endBarcodeRealPosition.offset = startBarcode.offset! -
                  relevantBarcodeOffset[interBarcodeOffsetIndex].offset;
              //Calculate the z difference from start barcode
              endBarcodeRealPosition.zOffset = startBarcode.zOffset! -
                  relevantBarcodeOffset[interBarcodeOffsetIndex].zOffset;
              //log(endBarcodeRealPosition.toString());
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

  //log(realBarcodePositions.toString());
  return realBarcodePositions;
}
