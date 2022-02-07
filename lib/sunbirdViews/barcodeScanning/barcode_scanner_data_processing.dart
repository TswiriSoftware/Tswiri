import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/scanningAdapters/real_barocode_position_entry.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/type_offset_converters.dart';
import 'package:flutter_google_ml_kit/globalValues/global_hive_databases.dart';
import 'package:flutter_google_ml_kit/globalValues/origin_data.dart';
import 'package:flutter_google_ml_kit/objects/raw_on_image_barcode_data.dart';
import 'package:flutter_google_ml_kit/objects/real_inter_barcode_offset.dart';
import 'package:flutter_google_ml_kit/objects/real_barcode_position.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'consolidated_database_view.dart';

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
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

Future processData(List<RawOnImageInterBarcodeData> allInterBarcodeData) async {
  Box realPositionalData = await Hive.openBox(realPositionDataBoxName);

  //All interBarcode Data from scan - deduplicated
  List<RealInterBarcodeOffset> realInterBarcodeOffsets =
      addRealInterBarcodeOffsets(allInterBarcodeData.toSet().toList());

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //List of all barcodes Scanned - deduplicated.
  List<RealBarcodePosition> realBarcodePositions =
      addRealBarcodePositions(realInterBarcodeOffsets);

  realBarcodePositions[realBarcodePositions
      .indexWhere((element) => element.uid == '1')] = origin;

  // Go through all realInterbarcode data at least realInterBarcodeData.length times (Little bit of overkill)
  //TODO: Add check to check if any Interbarcodedatas without offset exists.

  for (int i = 0; i <= realInterBarcodeOffsets.length; i++) {
    for (RealBarcodePosition endBarcodeRealPosition in realBarcodePositions) {
      if (endBarcodeRealPosition.interBarcodeOffset == null) {
        //This list contains all RealInterBarcode Offsets that contains the endBarcode
        List<RealInterBarcodeOffset> interBarcodeOffsetsContainingEndBarcode =
            realInterBarcodeOffsets
                .where((interBarcodeData) =>
                    (interBarcodeData.uidStart == endBarcodeRealPosition.uid) ||
                    (interBarcodeData.uidEnd == endBarcodeRealPosition.uid))
                .toList();

        //This list contains all realBarcodePositions with a Offset to the Origin
        List<RealBarcodePosition> realBarcodePositionWithOffset =
            realBarcodePositions
                .where((realBarcodePosition) =>
                    realBarcodePosition.interBarcodeOffset != null)
                .toList();

        //Checks if any barcode with offset to origin exsists and is contained in the list interBarcodeOffsetsContainingEndBarcode.
        if (realBarcodePositionWithOffset.any((barcodeWithOffsetToOrigin) {
          for (RealInterBarcodeOffset singleInterBarcodeData
              in interBarcodeOffsetsContainingEndBarcode) {
            if (singleInterBarcodeData.uidStart ==
                    barcodeWithOffsetToOrigin.uid ||
                singleInterBarcodeData.uidEnd ==
                    barcodeWithOffsetToOrigin.uid) {
              return true;
            }
          }
          return false;
        })) {
          //returns the first barcode with offset to origin that is contained in the list interBarcodeOffsetsContainingEndBarcode.
          RealBarcodePosition startRealBarcodePosition =
              realBarcodePositionWithOffset.firstWhere(
            (element) {
              for (RealInterBarcodeOffset singleInterBarcodeData
                  in interBarcodeOffsetsContainingEndBarcode) {
                if (singleInterBarcodeData.uidStart == element.uid ||
                    singleInterBarcodeData.uidEnd == element.uid) {
                  return true;
                }
              }
              return false;
            },
          );

          //Checks if any RealBarcodePosition contains startRealBarcodePosition. (Double checks)
          if (interBarcodeOffsetsContainingEndBarcode.any((element) {
            if (startRealBarcodePosition.uid == element.uidStart ||
                startRealBarcodePosition.uid == element.uidEnd) {
              return true;
            }
            return false;
          })) {
            //Returns the first interBarcodeOffset where the startRealBarcodePosition is contained.
            RealInterBarcodeOffset interBarcodeOffset =
                interBarcodeOffsetsContainingEndBarcode.firstWhere(
              (element) {
                if (startRealBarcodePosition.uid == element.uidStart ||
                    startRealBarcodePosition.uid == element.uidEnd) {
                  return true;
                }
                return false;
              },
            );
            endBarcodeRealPosition.timestamp = interBarcodeOffset.timestamp;

            if (interBarcodeOffset.uidEnd == endBarcodeRealPosition.uid) {
              endBarcodeRealPosition.interBarcodeOffset =
                  startRealBarcodePosition.interBarcodeOffset! +
                      interBarcodeOffset.interBarcodeOffset;
            } else if (interBarcodeOffset.uidStart ==
                endBarcodeRealPosition.uid) {
              endBarcodeRealPosition.interBarcodeOffset =
                  startRealBarcodePosition.interBarcodeOffset! -
                      interBarcodeOffset.interBarcodeOffset;
            }
          }
        }
      }
    }

    for (RealBarcodePosition realBarcodePosition in realBarcodePositions) {
      //Checks that the interBarcodeOffset is not null and then creates an entry
      if (realBarcodePosition.interBarcodeOffset != null) {
        //Creates an entry for each realBarcodePosition
        realPositionalData.put(
            realBarcodePosition.uid,
            RealBarcodePostionEntry(
                uid: realBarcodePosition.uid,
                offset:
                    offsetToTypeOffset(realBarcodePosition.interBarcodeOffset!),
                distanceFromCamera: 0,
                fixed: false,
                timestamp: realBarcodePosition.timestamp!));
      }
    }

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    //TODO: Fix naming (Real , on Image etc etc.)
    //TODO; to list no map

    // Get set of all barcode UID that were scanned. -> Write to List<RealPositionData>                   DONE :)
    // get origin barcode UID and Update to have ( 0,0 ) Position (Origin 0,0 , hardcoded global const )  DONE :)

    // magic loop start.

    // for each barcode in list
    //    check if current barcode has offset , if yes , skip , if no do this :                                       DONE :)
    //       Find Path to origin ->  1. get all interbarcodedatas with start or end barcode as current barcode UID.
    //                               2. check if any of these have a offset , if yes continue to 3 if not continue to next interBarcodeData
    //                               3. store offset of barcode with current barcode and origin barcode as position (ensure that barcode with offset is start , if not reverse vector)

    //magic loop end.

    //^^^ repeat magic loop until we dont have barcodes without offsets in List<RealPositionData>

    //   }
    //print(allScannedBarcodes);

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // Map<String, RealBarcodePosition> realInterBarcodeOffsetsMap = {};

    // //Add origin
    // realInterBarcodeOffsetsMap.putIfAbsent(
    //     '1', () => RealBarcodePosition('1', const Offset(0, 0), 0));

    // for (int i = 0; i <= realInterBarcodeOffsets.length; i++) {
    //   for (RealInterBarcodeOffset realInterBarcodeOffset
    //       in realInterBarcodeOffsets) {
    //     //If realInterBarcodeOffsetMap contains uidEnd or uidStart then it will put the uidStart or uidEnd respectively,
    //     //aswell as calculate the realBarcodePosition relative to the startBarcodePosition
    //     RealBarcodePosition realBarcodePosition = calculateRealBarcodePosition(
    //         realInterBarcodeOffsetsMap, realInterBarcodeOffset);
    //     //Checks that the RealBarcodePosition does not contain a null value and then enters it to the database.
    //     if (realBarcodePosition.interBarcodeOffset != null) {
    //       realInterBarcodeOffsetsMap.putIfAbsent(
    //           realInterBarcodeOffset.uid, () => realBarcodePosition);
    //     }
    //   }

    //   for (RealBarcodePosition realInterBarcodeOffset
    //       in realInterBarcodeOffsetsMap.values) {
    //     print(realInterBarcodeOffset);
    //     realPositionalData.put(
    //         realInterBarcodeOffset.uid,
    //         RealBarcodePostionEntry(
    //             uid: realInterBarcodeOffset.uid,
    //             offset: offsetToTypeOffset(
    //                 realInterBarcodeOffset.interBarcodeOffset!),
    //             distanceFromCamera: 0,
    //             fixed: false,
    //             timestamp: realInterBarcodeOffset.timestamp!));
    //   }

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    return '';
  }
}

List<RealBarcodePosition> addRealBarcodePositions(
  List<RealInterBarcodeOffset> allRealInterBarcodeData,
) {
  List<RealBarcodePosition> realPositionData = [];
  List<RealBarcodePosition> allBarcodesInScan = [];
  for (RealInterBarcodeOffset interBarcodeData in allRealInterBarcodeData) {
    allBarcodesInScan.addAll([
      RealBarcodePosition(interBarcodeData.uidStart, null, null),
      RealBarcodePosition(interBarcodeData.uidEnd, null, null)
    ]);
  }

  realPositionData = allBarcodesInScan.toSet().toList();
  return realPositionData;
}

List<RealInterBarcodeOffset> addRealInterBarcodeOffsets(
    List<RawOnImageInterBarcodeData> allDeduplicatedInterBarcodeData) {
  List<RealInterBarcodeOffset> allRealInterBarcodeData = [];
  for (RawOnImageInterBarcodeData interBarcodeDataInstance
      in allDeduplicatedInterBarcodeData) {
    RealInterBarcodeOffset realInterBarcodeDataInstance =
        interBarcodeDataInstance.realInterBarcodeData;
    allRealInterBarcodeData.add(realInterBarcodeDataInstance);
    //print(interBarcodeDa
    //taInstance);
  }
  return allRealInterBarcodeData;
}

List<RealInterBarcodeOffset> findDatasContainingCurrentBarcode(
    List<RealInterBarcodeOffset> realInterBarcodeData,
    RealBarcodePosition workingData) {
  return realInterBarcodeData
      .where((element) =>
          workingData.uid == element.uidStart ||
          workingData.uid == element.uidEnd)
      .toList();
}

ElevatedButton proceedButton(BuildContext context) {
  return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const HiveDatabaseConsolidationView()));
      },
      child: const Icon(Icons.check_circle_outline_rounded));
}

///Checks if the start or end Barcode is present in the realInterBarcodeMap.
///
///If the start barcode is present it will calculate the realPosition accordingly.
///If the end barcode is present it will calculate the realPosition accordingly.
///
///If neither the start or end barcode is present it will return a null value.
RealBarcodePosition calculateRealBarcodePosition(
    Map<String, RealBarcodePosition> realInterBarcodeOffsetsMap,
    RealInterBarcodeOffset realInterBarcodeOffset) {
  //Checks if start Barcode is present
  if (realInterBarcodeOffsetsMap.containsKey(realInterBarcodeOffset.uidStart)) {
    return RealBarcodePosition(
        realInterBarcodeOffset.uidEnd,
        realInterBarcodeOffsetsMap[realInterBarcodeOffset.uidStart]!
                .interBarcodeOffset! +
            realInterBarcodeOffset.interBarcodeOffset,
        realInterBarcodeOffset.timestamp);
  }
  //Checks if end Barcode uid is present.
  else if (realInterBarcodeOffsetsMap
      .containsKey(realInterBarcodeOffset.uidEnd)) {
    return RealBarcodePosition(
        realInterBarcodeOffset.uidStart,
        realInterBarcodeOffsetsMap[realInterBarcodeOffset.uidEnd]!
                .interBarcodeOffset! -
            realInterBarcodeOffset.interBarcodeOffset,
        realInterBarcodeOffset.timestamp);
  }
  return RealBarcodePosition('0', null, null);
}
