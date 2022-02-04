import 'package:fast_immutable_collections/src/ilist/list_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/scanningAdapters/consolidated_data_adapter.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/typeAdapters/type_offset_adapter.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/calculate_offset_between_points.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/rawDataFunctions/data_capturing_functions.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/type_offset_converters.dart';
import 'package:flutter_google_ml_kit/globalValues/global_hive_databases.dart';
import 'package:flutter_google_ml_kit/globalValues/origin_data.dart';
import 'package:flutter_google_ml_kit/objects/raw_on_image_barcode_data.dart';
import 'package:flutter_google_ml_kit/objects/on_image_inter_barcode_data.dart';
import 'package:flutter_google_ml_kit/objects/real_inter_barcode_data.dart';
import 'package:flutter_google_ml_kit/objects/real_working_data.dart';
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

  List<RealInterBarcodeData> realInterBarcodeDataList = [];

  Map<String, RealWorkingData> realWorkingData = {};
  realWorkingData.putIfAbsent(
      '1', () => RealWorkingData('1', const Offset(0, 0), 0));

  for (int i = 0; i <= realInterBarcodeDataList.length; i++) {
    for (RealInterBarcodeData interBarcodeData in realInterBarcodeDataList) {
      if (realWorkingData.containsKey(interBarcodeData.uidStart)) {
        realWorkingData.putIfAbsent(
            interBarcodeData.uidEnd,
            () => RealWorkingData(
                interBarcodeData.uidEnd,
                (realWorkingData[interBarcodeData.uidStart]!
                        .interBarcodeOffset +
                    interBarcodeData.interBarcodeOffset),
                interBarcodeData.timestamp));
      } else if (realWorkingData.containsKey(interBarcodeData.uidEnd)) {
        realWorkingData.putIfAbsent(
            interBarcodeData.uidStart,
            () => RealWorkingData(
                interBarcodeData.uidStart,
                realWorkingData[interBarcodeData.uidEnd]!.interBarcodeOffset -
                    interBarcodeData.interBarcodeOffset,
                interBarcodeData.timestamp));
      }
    }
  }

  realWorkingData.forEach((key, value) {
    print(value);
    realPositionalData.put(
        key,
        RealPositionData(
            uid: key,
            offset: offsetToTypeOffset(value.interBarcodeOffset),
            distanceFromCamera: 0,
            fixed: false,
            timestamp: value.timestamp));
  });

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

List<RealInterBarcodeData> findDatasContainingCurrentBarcode(
    List<RealInterBarcodeData> realInterBarcodeData,
    RealWorkingData workingData) {
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

// List<RealWorkingData> extractAllScannedBarcodes(
//     List<RealInterBarcodeData> realInterBarcodeDataList) {
//   List<RealWorkingData> allScannedBarcodes = [];
//   for (RealInterBarcodeData interBarcodeData in realInterBarcodeDataList) {
//     if (interBarcodeData.uidStart != '1') {
//       allScannedBarcodes.add(RealWorkingData(
//           interBarcodeData.uidStart, null, interBarcodeData.timestamp));
//     } else if (interBarcodeData.uidEnd != '1') {
//       allScannedBarcodes.add(RealWorkingData(
//           interBarcodeData.uidEnd, null, interBarcodeData.timestamp));
//     }
//   }
//   allScannedBarcodes.toSet().toList();

//   return allScannedBarcodes;
// }

////////////
////////////
///
//Contains Sets of linked Barcodes
  // List<RealInterBarcodeData> realInterBarcodeData = [];

  // //Remove all duplicates for allInterBarcode data.
  // List<RawOnImageInterBarcodeData> allDeduplicatedInterBarcodeData =
  //     allInterBarcodeData.toSet().toList();

  // for (RawOnImageInterBarcodeData interBarcodeDataInstance
  //     in allDeduplicatedInterBarcodeData) {
  //   RealInterBarcodeData realInterBarcodeDataInstance =
  //       interBarcodeDataInstance.realInterBarcodeData;
  //   realInterBarcodeData.add(realInterBarcodeDataInstance);
  // }

  // List<RealWorkingData> allScannedBarcodes = [];
  // allScannedBarcodes.addAll(extractAllScannedBarcodes(realInterBarcodeData));
  // allScannedBarcodes.add(origin);

  // for (RealWorkingData workingData in allScannedBarcodes) {
  //   List<RealInterBarcodeData> datasContainingCurrentBarcodeID = [];
  //   List<RealWorkingData> allValidScannedBarcodes = [];
  //   if (workingData.interBarcodeOffset == null) {
  //     //Current working barcode ID.
  //     print(workingData.uid);

  //     datasContainingCurrentBarcodeID.addAll(
  //         findDatasContainingCurrentBarcode(realInterBarcodeData, workingData));

  //     allValidScannedBarcodes.addAll(allScannedBarcodes
  //         .where((element) => element.interBarcodeOffset != null));

  //     print(
  //         'datasContainingCurrentBarcodeID: $datasContainingCurrentBarcodeID');
  //     print('allValidScannedBarcodes: $allValidScannedBarcodes');

  //     List<RealInterBarcodeData> validRealInterBarcodeData;

  //     validRealInterBarcodeData = datasContainingCurrentBarcodeID
  //         .where((element) => allValidScannedBarcodes.any((data) =>
  //             element.uidStart == data.uid || element.uidEnd == data.uid))
  //         .toList();

  //     if(validRealInterBarcodeData.isNotEmpty && validRealInterBarcodeData.first.uidStart == workingData.uid){
        
  //     }  


  //  }



////////////////
///////////////
