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

  List<RealInterBarcodeOffset> allRealInterBarcodeOffsets =
      addRealInterBarcodeOffsets(allInterBarcodeData);

  //All interBarcode Data from scan - deduplicated
  List<RealInterBarcodeOffset> deduplicatedRealInterBarcodeOffsets =
      addRealInterBarcodeOffsets(allInterBarcodeData.toSet().toList());

  // print('Initial Values');
  // for (RealInterBarcodeOffset a in allRealInterBarcodeOffsets) {
  //   print(a);
  // }

  for (RealInterBarcodeOffset realInterBacrodeOffset
      in deduplicatedRealInterBarcodeOffsets) {
    List<RealInterBarcodeOffset> similarInterBarcodeOffsets =
        allRealInterBarcodeOffsets
            .where((element) =>
                (element.uidStart == realInterBacrodeOffset.uidStart &&
                    element.uidEnd == realInterBacrodeOffset.uidEnd) ||
                (element.uidEnd == realInterBacrodeOffset.uidStart &&
                    element.uidStart == realInterBacrodeOffset.uidEnd))
            .toList();

    for (RealInterBarcodeOffset similarInterBarcodeOffset
        in similarInterBarcodeOffsets) {
      if (similarInterBarcodeOffset.uidStart ==
              realInterBacrodeOffset.uidStart &&
          similarInterBarcodeOffset.uidEnd == realInterBacrodeOffset.uidEnd) {
        realInterBacrodeOffset.interBarcodeOffset =
            (realInterBacrodeOffset.interBarcodeOffset +
                    similarInterBarcodeOffset.interBarcodeOffset) /
                2;
      } else if (similarInterBarcodeOffset.uidEnd ==
              realInterBacrodeOffset.uidStart &&
          similarInterBarcodeOffset.uidStart == realInterBacrodeOffset.uidEnd) {
        realInterBacrodeOffset.interBarcodeOffset =
            (realInterBacrodeOffset.interBarcodeOffset +
                    (-similarInterBarcodeOffset.interBarcodeOffset)) /
                2;
      }
    }
  }

  //List of all barcodes Scanned - deduplicated.
  List<RealBarcodePosition> realBarcodePositions =
      allScannedBarcodes(deduplicatedRealInterBarcodeOffsets);

  //Populate origin
  realBarcodePositions[
          realBarcodePositions.indexWhere((element) => element.uid == '1')] =
      RealBarcodePosition('1', Offset(0, 0), 0, 0);

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

        //barcodesWithOffset.sort(mySortComparison);

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

void writeValidBarcodePositionsToDatabase(
    RealBarcodePosition realBarcodePosition, Box<dynamic> realPositionalData) {
  if (realBarcodePosition.interBarcodeOffset != null) {
    //Creates an entry for each realBarcodePosition
    realPositionalData.put(
        realBarcodePosition.uid,
        RealBarcodePostionEntry(
            uid: realBarcodePosition.uid,
            offset: offsetToTypeOffset(realBarcodePosition.interBarcodeOffset!),
            distanceFromCamera: 0,
            fixed: false,
            timestamp: realBarcodePosition.timestamp!));
  }
}

bool indexIsValid(int index) => index != -1;

///Considers the InterBarcodeOffset Offset's Direction
void determinesInterBarcodeOffsetDirection(
    {required RealInterBarcodeOffset relevantInterBarcodeOffset,
    required RealBarcodePosition endBarcodeRealPosition,
    required RealBarcodePosition startBarcode}) {
  if (relevantInterBarcodeOffset.uidEnd == endBarcodeRealPosition.uid) {
    endBarcodeRealPosition.interBarcodeOffset =
        startBarcode.interBarcodeOffset! +
            relevantInterBarcodeOffset.interBarcodeOffset;
    // endBarcodeRealPosition.numberOfBarcodesFromOrigin =
    //     1 + startBarcode.numberOfBarcodesFromOrigin!;
    endBarcodeRealPosition.timestamp = relevantInterBarcodeOffset.timestamp;
  } else if (relevantInterBarcodeOffset.uidStart ==
      endBarcodeRealPosition.uid) {
    endBarcodeRealPosition.interBarcodeOffset =
        startBarcode.interBarcodeOffset! -
            relevantInterBarcodeOffset.interBarcodeOffset;
    // endBarcodeRealPosition.numberOfBarcodesFromOrigin =
    //     1 + startBarcode.numberOfBarcodesFromOrigin!;
    endBarcodeRealPosition.timestamp = relevantInterBarcodeOffset.timestamp;
  }
}

///Finds the interBarcodeOffset which contains the start Barcode
int findInterBarcodeOffset(
    List<RealInterBarcodeOffset> relevantInterBarcodeOffsets,
    RealBarcodePosition startBarcode,
    RealBarcodePosition endBarcodeRealPosition) {
  return relevantInterBarcodeOffsets.indexWhere((element) {
    if ((startBarcode.uid == element.uidStart &&
            endBarcodeRealPosition.uid == element.uidEnd) ||
        (startBarcode.uid == element.uidEnd &&
            endBarcodeRealPosition.uid == element.uidStart)) {
      return true;
    }
    return false;
  });
}

///Find a relevant the start barcode
int findStartBarcodeIndex(List<RealBarcodePosition> barcodesWithOffset,
    List<RealInterBarcodeOffset> relevantInterBarcodeOffsets) {
  return barcodesWithOffset.indexWhere((barcodeWithOffsetToOrigin) {
    for (RealInterBarcodeOffset singleInterBarcodeData
        in relevantInterBarcodeOffsets) {
      if (singleInterBarcodeData.uidStart == barcodeWithOffsetToOrigin.uid ||
          singleInterBarcodeData.uidEnd == barcodeWithOffsetToOrigin.uid) {
        return true;
      }
    }
    return false;
  });
}

///Finds all barcodes with a offset (to the origin).
List<RealBarcodePosition> getBarcodesWithOffset(
    List<RealBarcodePosition> realBarcodePositions) {
  return realBarcodePositions
      .where((realBarcodePosition) =>
          realBarcodePosition.interBarcodeOffset != null)
      .toList();
}

List<RealInterBarcodeOffset> getRelevantInterBarcodeOffsets(
    List<RealInterBarcodeOffset> realInterBarcodeOffsets,
    RealBarcodePosition endBarcodeRealPosition) {
  return realInterBarcodeOffsets
      .where((interBarcodeData) =>
          (interBarcodeData.uidStart == endBarcodeRealPosition.uid) ||
          (interBarcodeData.uidEnd == endBarcodeRealPosition.uid))
      .toList();
}

///Creates a list of all scanned barcodes , but with null positions , they still need to be populated.
List<RealBarcodePosition> allScannedBarcodes(
  List<RealInterBarcodeOffset> allRealInterBarcodeData,
) {
  List<RealBarcodePosition> realPositionData = [];
  List<RealBarcodePosition> allBarcodesInScan = [];
  for (RealInterBarcodeOffset interBarcodeData in allRealInterBarcodeData) {
    allBarcodesInScan.addAll([
      RealBarcodePosition(interBarcodeData.uidStart, null, null, null),
      RealBarcodePosition(interBarcodeData.uidEnd, null, null, null)
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

int mySortComparison(RealBarcodePosition a, RealBarcodePosition b) {
  if (a.numberOfBarcodesFromOrigin != null &&
      b.numberOfBarcodesFromOrigin != null) {
    if (a.numberOfBarcodesFromOrigin! < b.numberOfBarcodesFromOrigin!) {
      return -1;
    } else if (a.numberOfBarcodesFromOrigin! > b.numberOfBarcodesFromOrigin!) {
      return 1;
    } else {
      return 0;
    }
  } else if (a.numberOfBarcodesFromOrigin != null &&
      b.numberOfBarcodesFromOrigin == null) {
    return -1;
  } else if (a.numberOfBarcodesFromOrigin == null &&
      b.numberOfBarcodesFromOrigin != null) {
    return 1;
  } else {
    return 0;
  }
}
