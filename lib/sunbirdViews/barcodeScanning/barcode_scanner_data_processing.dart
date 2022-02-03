import 'package:fast_immutable_collections/src/ilist/list_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/scanningAdapters/consolidated_data_adapter.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/typeAdapters/type_offset_adapter.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/calculate_offset_between_points.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/rawDataFunctions/data_capturing_functions.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/type_offset_converters.dart';
import 'package:flutter_google_ml_kit/globalValues/global_hive_databases.dart';
import 'package:flutter_google_ml_kit/objects/raw_on_image_barcode_data.dart';
import 'package:flutter_google_ml_kit/objects/on_image_inter_barcode_data.dart';
import 'package:flutter_google_ml_kit/objects/real_inter_barcode_data.dart';
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

  //TODO: Fix naming (Real , on Image etc etc.)
  //TODO; to list no map
  Map<String, RealPositionData> realPositionalDataMap = {};
      //realPositionalData.toMap().map((key, value) => MapEntry(key, value));

  List<RealInterBarcodeData> realInterBarcodeDataList = [];

  addFixedPoint(realPositionalDataMap);

  //Remove all duplicates for allInterBarcode data.
  List<RawOnImageInterBarcodeData> allDeduplicatedInterBarcodeData =
      allInterBarcodeData.toSet().toList();

  for (RawOnImageInterBarcodeData interBarcodeDataInstance
      in allDeduplicatedInterBarcodeData) {
    RealInterBarcodeData realInterBarcodeData =
        interBarcodeDataInstance.realInterBarcodeData;
    realInterBarcodeDataList.add(realInterBarcodeData);
  }
  //print(realInterBarcodeDataList);


 // Get set of all barcode UID that were scanned. -> Write to List<RealPositionData>
 // get origin barcode UID and Update to have ( 0,0 ) Position (Origin 0,0 , hardcoded global const )

 // magic loop start.

 // for each barcode in list 
 //    check if current barcode has offset , if yes , skip , if no do this :
 //       Find Path to origin ->  1. get all interbarcodedatas with start or end barcode as current barcode UID. 
 //                               2. check if any of these have a offset , if yes continue to 3 if not continue to next interBarcodeData
 //                               3. store offset of barcode with current barcode and origin barcode as position (ensure that barcode with offset is start , if not reverse vector) 
 
 //magic loop end.

 //^^^ repeat magic loop until we dont have barcodes without offsets in List<RealPositionData>


  for (RealInterBarcodeData realInterBarcodeData
      in realInterBarcodeDataList) {
    RealPositionData realPositionData;
    if (realPositionalDataMap
        .containsKey(realInterBarcodeData.uidStart)) {
      realPositionData = RealPositionData(
          uid: realInterBarcodeData.uidEnd,
          offset: offsetToTypeOffset(typeOffsetToOffset(
                  realPositionalDataMap[realInterBarcodeData.uidStart]!
                      .offset) +
              realInterBarcodeData.interBarcodeOffset),
          distanceFromCamera: realInterBarcodeData.distanceFromCamera,
          fixed: false,
          timestamp: realInterBarcodeData.timestamp);
      realPositionalDataMap.update(
        realPositionData.uid,
        (value) => realPositionData,
        ifAbsent: () => realPositionData,
      );
    } else if (realPositionalDataMap
        .containsKey(realInterBarcodeData.uidEnd)) {
      realPositionData = RealPositionData(
          uid: realInterBarcodeData.uidStart,
          offset: offsetToTypeOffset(typeOffsetToOffset(
                  realPositionalDataMap[realInterBarcodeData.uidEnd]!
                      .offset) -
              realInterBarcodeData.interBarcodeOffset),
          distanceFromCamera: realInterBarcodeData.distanceFromCamera,
          fixed: false,
          timestamp: realInterBarcodeData.timestamp);
      realPositionalDataMap.update(
        realPositionData.uid,
        (value) => realPositionData,
        ifAbsent: () => realPositionData,
      );
    }
  }

  for (RealPositionData consolidatedRealBarcodeData
      in realPositionalDataMap.values) {
    realPositionalData.put(
        consolidatedRealBarcodeData.uid, consolidatedRealBarcodeData);
    print(consolidatedRealBarcodeData);
  }

  //TODO: Implement tree rebuilding
  return '';
}

void addFixedPoint(
    Map<String, RealPositionData> consolidatedDataMap) {
  if (!consolidatedDataMap.containsKey('1')) {
    consolidatedDataMap.putIfAbsent(
        '1',
        () => RealPositionData(
            uid: '1',
            offset: TypeOffsetHiveObject(x: 0, y: 0),
            distanceFromCamera: 0,
            fixed: true,
            timestamp: DateTime.now().millisecondsSinceEpoch));
  }
}

ElevatedButton proceedButton(BuildContext context) {
  return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const HiveDatabaseConsolidationView()));
      },
      child: const Icon(Icons.check_circle_outline_rounded));
}

