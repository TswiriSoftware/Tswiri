import 'package:fast_immutable_collections/src/ilist/list_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/scanningAdapters/consolidated_data_adapter.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/typeAdapters/type_offset_adapter.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/calculate_offset_between_points.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/rawDataFunctions/data_capturing_functions.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/rawDataFunctions/data_processing_functions.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/type_offset_converters.dart';

import 'package:flutter_google_ml_kit/globalValues/global_hive_databases.dart';
import 'package:flutter_google_ml_kit/objects/barcode_pairs_data_instance.dart';
import 'package:flutter_google_ml_kit/objects/on_image_inter_barcode_data.dart';
import 'package:flutter_google_ml_kit/objects/real_inter_barcode_data.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcodeScanning/scanningToolsView/barcode_scanning_tools_view.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BarcodeScannerDataProcessingView extends StatefulWidget {
  const BarcodeScannerDataProcessingView(
      {Key? key, required this.barcodePairsData})
      : super(key: key);

  final List<BarcodePairDataInstance> barcodePairsData;

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
          future: processData(widget.barcodePairsData),
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

Future processData(List<BarcodePairDataInstance> barcodePairsData) async {
  Box consolidatedDataBox = await Hive.openBox(consolidatedDataHiveBox);

  Map<String, ConsolidatedDataHiveObject> consolidatedDataMap =
      consolidatedDataBox.toMap().map((key, value) => MapEntry(key, value));

  Map<String, OnImageInterBarcodeData> onImageInterBarcodeDataMap =
      deduplicateData(generateOnImageInterBarcodeDataMap(barcodePairsData));

  Map<String, RealInterBarcodeData> realInterBarcodeDataMap =
      generateRealInterBarcodeMap(onImageInterBarcodeDataMap);

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

  realInterBarcodeDataMap.forEach((key, value) {
    if (consolidatedDataMap.containsKey(value.uidStart) &&
        !consolidatedDataMap.containsKey(value.uidEnd)) {
      Offset offset =
          typeOffsetToOffset(consolidatedDataMap[value.uidStart]!.offset) +
              -value.interBarcodeOffset;
      ConsolidatedDataHiveObject consolidatedPoint = ConsolidatedDataHiveObject(
          uid: value.uidEnd,
          offset: offsetToTypeOffset(offset),
          distanceFromCamera: 0,
          fixed: false,
          timestamp: value.timestamp);

      consolidatedDataMap.update(
        value.uidEnd,
        (value) => consolidatedPoint,
        ifAbsent: () => consolidatedPoint,
      ); //putIfAbsent(value.uidEnd, () => consolidatedPoint);
    } else if (consolidatedDataMap.containsKey(value.uidEnd) &&
        !consolidatedDataMap.containsKey(value.uidEnd)) {}
  });

  print("consolidatedDataMap: ");
  consolidatedDataMap.forEach((key, value) {
    consolidatedDataBox.put(key, value);
    print(value);
  });

  return '';
}

ElevatedButton proceedButton(BuildContext context) {
  return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const BarcodeScanningView()));
      },
      child: const Icon(Icons.check_circle_outline_rounded));
}

OnImageInterBarcodeData calculateAverageOnImageInterBarcodeData(
    OnImageInterBarcodeData storedInterBarcodeData,
    OnImageInterBarcodeData interBarcodeData) {
  OnImageInterBarcodeData averageInterBarcodeData = OnImageInterBarcodeData(
      startBarcodeID: storedInterBarcodeData.startBarcodeID,
      startDiagonalLength: (storedInterBarcodeData.startDiagonalLength +
              interBarcodeData.startDiagonalLength) /
          2,
      endBarcodeID: storedInterBarcodeData.endBarcodeID,
      endDiagonalLength: (storedInterBarcodeData.endDiagonalLength +
              interBarcodeData.endDiagonalLength) /
          2,
      interBarcodeOffsetonImage:
          (storedInterBarcodeData.interBarcodeOffsetonImage +
                  interBarcodeData.interBarcodeOffsetonImage) /
              2,
      timestamp: interBarcodeData.timestamp,
      uid:
          '${interBarcodeData.startBarcodeID}_${interBarcodeData.endBarcodeID}');

  return averageInterBarcodeData;
}

Map<String, OnImageInterBarcodeData> generateOnImageInterBarcodeDataMap(
    List<BarcodePairDataInstance> barcodePairsData) {
  Map<String, OnImageInterBarcodeData> barcodePairsDataMap = {};

  if (barcodePairsData.isNotEmpty) {
    barcodePairsData.forEach((element) {
      OnImageInterBarcodeData interBarcodeData = OnImageInterBarcodeData(
          startBarcodeID: element.startBarcode.displayValue.toString(),
          startDiagonalLength:
              averageBarcodeDiagonalLength(element.startBarcode),
          endBarcodeID: element.endBarcode.displayValue.toString(),
          endDiagonalLength: averageBarcodeDiagonalLength(element.endBarcode),
          interBarcodeOffsetonImage: calculateOffsetBetweenTwoPoints(
              calculateBarcodeCenterPoint(element.startBarcode),
              calculateBarcodeCenterPoint(element.endBarcode)),
          timestamp: element.timestamp,
          uid: '${element.startBarcode}_${element.endBarcode}');

      String barcodePairUID =
          '${interBarcodeData.startBarcodeID}_${interBarcodeData.endBarcodeID}';

      if (barcodePairsDataMap.containsKey(barcodePairUID)) {
        barcodePairsDataMap.update(
            barcodePairUID,
            (value) => calculateAverageOnImageInterBarcodeData(
                barcodePairsDataMap[barcodePairUID]!, interBarcodeData));
      } else {
        barcodePairsDataMap.putIfAbsent(barcodePairUID, () => interBarcodeData);
      }
    });
  }

  return barcodePairsDataMap;
}

Map<String, RealInterBarcodeData> generateRealInterBarcodeMap(
    Map<String, OnImageInterBarcodeData> onImageInterBarcodeDataMap) {
  Map<String, RealInterBarcodeData> realInterBarcodeDataMap = {};
  if (onImageInterBarcodeDataMap.isNotEmpty) {
    onImageInterBarcodeDataMap.forEach((key, value) {
      Offset realInterBarcodeOffset = convertOnImageOffsetToRealOffset(
          onImageInterBarcodeOffset: value.interBarcodeOffsetonImage,
          aveDiagonalSideLength:
              (value.startDiagonalLength + value.endDiagonalLength) / 2);

      RealInterBarcodeData realBarcodeData = RealInterBarcodeData(
          uid: key,
          uidStart: value.startBarcodeID,
          uidEnd: value.endBarcodeID,
          interBarcodeOffset: realInterBarcodeOffset,
          distanceFromCamera: 0,
          timestamp: value.timestamp);
      realInterBarcodeDataMap.putIfAbsent(key, () => realBarcodeData);
    });
  }

  return realInterBarcodeDataMap;
}

Map<String, OnImageInterBarcodeData> deduplicateData(
    Map<String, OnImageInterBarcodeData> onImageInterBarcodeDataMap) {
  Map<String, OnImageInterBarcodeData> deduplicatedData = {};
  List uids = [];

  onImageInterBarcodeDataMap.forEach((key, value) {
    uids.add(value.startBarcodeID);
    uids.removeDuplicates();
    if (!uids.contains(value.endBarcodeID)) {
      OnImageInterBarcodeData onImageInterBarcodeData = OnImageInterBarcodeData(
          uid: value.uid,
          startBarcodeID: value.startBarcodeID,
          startDiagonalLength: value.startDiagonalLength,
          endBarcodeID: value.endBarcodeID,
          endDiagonalLength: value.endDiagonalLength,
          interBarcodeOffsetonImage: value.interBarcodeOffsetonImage,
          timestamp: value.timestamp);
      deduplicatedData.update(
        value.uid,
        (value) => onImageInterBarcodeData,
        ifAbsent: () => onImageInterBarcodeData,
      );
    }
  });

  return deduplicatedData;
}
