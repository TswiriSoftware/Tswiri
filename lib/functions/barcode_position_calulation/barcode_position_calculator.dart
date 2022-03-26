import 'dart:developer';
import 'dart:ui';

import 'package:flutter_google_ml_kit/functions/dataProccessing/barcode_scanner_data_processing_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/container_relationship/container_relationship.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/marker/marker.dart';
import 'package:flutter_google_ml_kit/objects/real_barcode_position.dart';
import 'package:flutter_google_ml_kit/objects/real_inter_barcode_offset.dart';
import 'package:isar/isar.dart';

import '../../isar_database/container_entry/container_entry.dart';
import '../../isar_database/real_interbarcode_vector_entry/real_interbarcode_vector_entry.dart';

List<RealBarcodePosition> calculateRealBarcodePositions(
    {required String parentUID}) {
  //1. Get childrenWithBarcodes ContainerEntry(s) with barcodes using parentUID.
  List<String> allChildrenUIDs = isarDatabase!.containerRelationships
      .filter()
      .parentUIDMatches(parentUID)
      .containerUIDProperty()
      .findAllSync();

  List<ContainerEntry> childrenWithBarcodes = isarDatabase!.containerEntrys
      .where()
      .repeat(
          allChildrenUIDs,
          (q, String containerUID) =>
              q.filter().containerUIDMatches(containerUID))
      .findAllSync()
      .where((element) => element.barcodeUID != null)
      .toList();

  if (childrenWithBarcodes.isEmpty) {
    log('No Children With Barcodes');
    return [];
  }

  //2. Get RealInterBarcodeVectorEntrys.
  List<RealInterBarcodeVectorEntry> interBarcodeVectors = isarDatabase!
      .realInterBarcodeVectorEntrys
      .where()
      .repeat(
          childrenWithBarcodes,
          (q, ContainerEntry element) => q
              .filter()
              .startBarcodeUIDMatches(element.barcodeUID!)
              .or()
              .endBarcodeUIDMatches(element.barcodeUID!))
      .findAllSync();

  if (childrenWithBarcodes.isEmpty) {
    log('No interbarcodes vectors');
    return [];
  }

  //3. Get Markers
  List<Marker> markers = isarDatabase!.markers
      .filter()
      .parentContainerUIDMatches(parentUID)
      .findAllSync();

  if (markers.isEmpty) {
    log('No Markers');
    return [];
  }

  //4. Pick Origin
  Marker? origin;

  //Parent ContainerUID
  ContainerEntry parentContainer = isarDatabase!.containerEntrys
      .filter()
      .containerUIDMatches(parentUID)
      .findFirstSync()!;

  if (parentContainer.barcodeUID != null) {
    //TODO: implement check for null values.
    origin = markers
        .where((element) => element.barcodeUID == parentContainer.barcodeUID)
        .first;
  } else {
    origin = markers.first;
  }

  //5. Build RealInterBarcodeOffset list.
  //TODO: implement timestamp

  List<String> barcodes = [];

  List<RealInterBarcodeOffset> allRealInterBarcodeOffsets = [];
  for (RealInterBarcodeVectorEntry data in interBarcodeVectors) {
    allRealInterBarcodeOffsets.add(
      RealInterBarcodeOffset(
        uid: data.startBarcodeUID + '-' + data.endBarcodeUID,
        uidStart: data.startBarcodeUID,
        uidEnd: data.endBarcodeUID,
        offset: Offset(data.x, data.y),
        zOffset: data.z,
        timestamp: 0,
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
