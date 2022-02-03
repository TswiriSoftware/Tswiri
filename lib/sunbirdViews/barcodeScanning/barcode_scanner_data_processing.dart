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
  Box realPositionalData = await Hive.openBox(realPositionalDataBox);

  //TODO: Fix naming (Real , on Image etc etc.)
  Map<String, ConsolidatedDataHiveObject> realPositionalDataMap =
      realPositionalData.toMap().map((key, value) => MapEntry(key, value));

  List<RealInterBarcodeData> realInterBarcodeDataList = [];

  addFixedPoint(realPositionalDataMap);

  //Remove all duplicates for allInterBarcode data.
  List<RawOnImageInterBarcodeData> allDeduplicatedInterBarcodeData =
      allInterBarcodeData.toSet().toList();

  for (RawOnImageInterBarcodeData interBarcodeDataInstance
      in allDeduplicatedInterBarcodeData) {
    RealInterBarcodeData processedOnImageBarcodeData =
        processRawOnImageBarcodeData(interBarcodeDataInstance);
    realInterBarcodeDataList.add(processedOnImageBarcodeData);
  }
  //print(realInterBarcodeDataList);

  for (RealInterBarcodeData realInterBarcodeDataInstance
      in realInterBarcodeDataList) {
    ConsolidatedDataHiveObject consolidatedDataHiveObject;
    if (realPositionalDataMap
        .containsKey(realInterBarcodeDataInstance.uidStart)) {
      TypeOffsetHiveObject relativeRealOffset = offsetToTypeOffset(
          typeOffsetToOffset(
                  realPositionalDataMap[realInterBarcodeDataInstance.uidStart]!
                      .offset) +
              realInterBarcodeDataInstance.interBarcodeOffset);

      consolidatedDataHiveObject = ConsolidatedDataHiveObject(
          uid: realInterBarcodeDataInstance.uidEnd,
          offset: relativeRealOffset,
          distanceFromCamera: realInterBarcodeDataInstance.distanceFromCamera,
          fixed: false,
          timestamp: realInterBarcodeDataInstance.timestamp);
      realPositionalDataMap.update(
        consolidatedDataHiveObject.uid,
        (value) => consolidatedDataHiveObject,
        ifAbsent: () => consolidatedDataHiveObject,
      );
    } else if (realPositionalDataMap
        .containsKey(realInterBarcodeDataInstance.uidEnd)) {
      TypeOffsetHiveObject relativeRealOffset = offsetToTypeOffset(
          typeOffsetToOffset(
                  realPositionalDataMap[realInterBarcodeDataInstance.uidEnd]!
                      .offset) -
              realInterBarcodeDataInstance.interBarcodeOffset);

      consolidatedDataHiveObject = ConsolidatedDataHiveObject(
          uid: realInterBarcodeDataInstance.uidStart,
          offset: relativeRealOffset,
          distanceFromCamera: realInterBarcodeDataInstance.distanceFromCamera,
          fixed: false,
          timestamp: realInterBarcodeDataInstance.timestamp);
      realPositionalDataMap.update(
        consolidatedDataHiveObject.uid,
        (value) => consolidatedDataHiveObject,
        ifAbsent: () => consolidatedDataHiveObject,
      );
    }
  }

  for (ConsolidatedDataHiveObject consolidatedRealBarcodeData
      in realPositionalDataMap.values) {
    realPositionalData.put(
        consolidatedRealBarcodeData.uid, consolidatedRealBarcodeData);
    print(consolidatedRealBarcodeData);
  }

  //TODO: Implement tree rebuilding
  return '';
}

void addFixedPoint(
    Map<String, ConsolidatedDataHiveObject> consolidatedDataMap) {
  if (!consolidatedDataMap.containsKey('1')) {
    consolidatedDataMap.putIfAbsent(
        '1',
        () => ConsolidatedDataHiveObject(
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

RealInterBarcodeData processRawOnImageBarcodeData(
    RawOnImageInterBarcodeData interBarcodeDataInstance) {
  ProcessedOnImageInterBarcodeData processedOnImageBarcodeDataInstance;

  RealInterBarcodeData realInterBarcodeDataInstance = RealInterBarcodeData(
      uid: interBarcodeDataInstance.uid,
      uidStart: interBarcodeDataInstance.startBarcodeID,
      uidEnd: interBarcodeDataInstance.endBarcodeID,
      interBarcodeOffset: interBarcodeDataInstance.realInterBarcodeOffset,
      distanceFromCamera: 0,
      timestamp: interBarcodeDataInstance.timestamp);

  return realInterBarcodeDataInstance;
}
