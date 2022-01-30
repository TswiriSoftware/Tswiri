import 'package:flutter/cupertino.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/scanningAdapters/on_image_inter_barcode_data.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/rawDataFunctions/data_processing_functions.dart';
import 'package:flutter_google_ml_kit/functions/dataManipulation/deduplicate_raw_data.dart';
import 'package:flutter_google_ml_kit/objects/barcode_marker.dart';
import 'package:flutter_google_ml_kit/objects/real_inter_barcode_data.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'consolidate_processed_data.dart';

processRawOnImageData(
    Map rawOnImageDataMap, Box consolidatedDataBox, SharedPreferences prefs) {
  Map<String, OnImageInterBarcodeDataHiveObject> processedData =
      deduplicateRawOnImageData(rawOnImageDataMap);

  List<RealInterBarcodeData> realInterBarcodeDataList = [];
  Map<String, RealBarcodeMarker> consolidatedDataMap = {};

  processedData.forEach((key, value) {
    OnImageInterBarcodeDataHiveObject onImageBarcodeData = value;

    Offset realInterBarcodeOffset = convertOnImageOffsetToRealOffset(
      aveDiagonalSideLength:
          (value.startDiagonalLength + value.endDiagonalLength) / 2,
      onImageInterBarcodeOffset: Offset(onImageBarcodeData.interBarcodeOffset.x,
          onImageBarcodeData.interBarcodeOffset.y),
    );

    double distanceFromCamera = calaculateDistanceFormCamera(
        (value.startDiagonalLength + value.endDiagonalLength) / 2, prefs);

    RealInterBarcodeData realBarcodeData = RealInterBarcodeData(
        uid: onImageBarcodeData.uid,
        uidStart: onImageBarcodeData.uidStart,
        uidEnd: onImageBarcodeData.uidEnd,
        interBarcodeOffset: realInterBarcodeOffset,
        distanceFromCamera: distanceFromCamera,
        timestamp: value.timestamp);

    realInterBarcodeDataList.add(realBarcodeData);
  });

  if (realInterBarcodeDataList.isNotEmpty) {
    addFixedPoint(realInterBarcodeDataList.first, consolidatedDataMap);
  }

  consolidateProcessedData(
      realInterBarcodeDataList, consolidatedDataMap, consolidatedDataBox);
}
