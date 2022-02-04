import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/scanningAdapters/consolidated_data_adapter.dart';
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
  List<RealInterBarcodeOffset> RealInterBarcodeOffsets =
      addRealInterBarcodeOffsets(allInterBarcodeData.toSet().toList());

  //List of all barcodes Scanned - deduplicated.
  List<RealBarcodePosition> realBarcodePositions =
      addRealBarcodePositions(RealInterBarcodeOffsets);

  realBarcodePositions[realBarcodePositions
      .indexWhere((element) => element.uid == '1')] = origin;

  // Go through all realInterbarcode data at least realInterBarcodeData.length times (Little bit of overkill)
  //TODO: Add check to check if any Interbarcodedatas without offset exists.

  for (int i = 0; i <= RealInterBarcodeOffsets.length; i++) {
    for (RealBarcodePosition endBarcodeRealPosition in realBarcodePositions) {
      if (endBarcodeRealPosition.interBarcodeOffset == null) {
        //This list contains all RealInterBarcode Offsets that contains the endBarcode
        List<RealInterBarcodeOffset> interBarcodeOffsetsContainingEndBarcode =
            RealInterBarcodeOffsets.where((interBarcodeData) =>
                    (interBarcodeData.uidStart == endBarcodeRealPosition.uid) ||
                    (interBarcodeData.uidEnd == endBarcodeRealPosition.uid))
                .toList();

        //This list contains all realBarcodePositions with a Offset to the Origin
        List<RealBarcodePosition> realBarcodePositionWithOffset =
            realBarcodePositions
                .where((realBarcodePosition) =>
                    realBarcodePosition.interBarcodeOffset != null)
                .toList();

        if (realBarcodePositionWithOffset.any((element) {
          for (RealInterBarcodeOffset singleInterBarcodeData
              in interBarcodeOffsetsContainingEndBarcode) {
            if (singleInterBarcodeData.uidStart == element.uid ||
                singleInterBarcodeData.uidEnd == element.uid) {
              return true;
            }
          }
          return false;
        })) {
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

          if (interBarcodeOffsetsContainingEndBarcode.any((element) {
            for (RealBarcodePosition singleRealBarcodePosition
                in realBarcodePositionWithOffset) {
              if (startRealBarcodePosition.uid == element.uidStart ||
                  startRealBarcodePosition.uid == element.uidEnd) {
                return true;
              }
            }
            return false;
          })) {
            RealInterBarcodeOffset interBarcodeOffset =
                interBarcodeOffsetsContainingEndBarcode.firstWhere(
              (element) {
                for (RealBarcodePosition singleRealBarcodePosition
                    in realBarcodePositionWithOffset) {
                  if (startRealBarcodePosition.uid == element.uidStart ||
                      startRealBarcodePosition.uid == element.uidEnd) {
                    return true;
                  }
                }
                return false;
              },
            );
            // print(endBarcodeRealPosition.uid);
            // print(startRealBarcodePosition);
            // print(interBarcodeOffset);
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
              endBarcodeRealPosition.timestamp = interBarcodeOffset.timestamp;
            }
          }
        }
      }
    }
  }
  print(realBarcodePositions);

  for (RealBarcodePosition realBarcodePosition in realBarcodePositions) {
    realPositionalData.put(
        realBarcodePosition.uid,
        RealBarcodePostionEntry(
            uid: realBarcodePosition.uid,
            offset: offsetToTypeOffset(realBarcodePosition.interBarcodeOffset!),
            distanceFromCamera: 0,
            fixed: false,
            timestamp: realBarcodePosition.timestamp!));
  }

  // Get set of all barcode UID that were scanned. -> Write to List<RealPositionData>                   DONE :)
  // get origin barcode UID and Update to have ( 0,0 ) Position (Origin 0,0 , hardcoded global const )  DONE :)

  // magic loop start.

  // for each barcode in list
  //    check if current barcode has offset , if yes , skip , if no do this :                                       DONE :)
  //       Find Path to origin ->  1. get all interbarcodedatas with start or end barcode as current barcode UID.
  //                               2. check if any of these have a offset , if yes continue to 3 if not continue to next interBarcodeData
  //                               3. store offset of barcode with current barcode and origin barcode as position (ensure that barcode with offset is start , if not reverse vector)

  //magic loop end.

  // for (RealBarcodePosition realWorkingData in realPositionData.values) {
  //   realPositionalData.put(
  //       realWorkingData.uid,
  //       RealPositionData(
  //           uid: realWorkingData.uid,
  //           offset: offsetToTypeOffset(realWorkingData.interBarcodeOffset),
  //           distanceFromCamera: 0,
  //           fixed: false,
  //           timestamp: realWorkingData.timestamp));
  // }

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

  return '';
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
