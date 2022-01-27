import 'package:flutter/cupertino.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/rawDataInjectorFunctions/raw_data_functions.dart';
import 'package:flutter_google_ml_kit/functions/dataManipulation/add_fixed_point.dart';
import 'package:flutter_google_ml_kit/functions/dataManipulation/deduplicate_raw_data.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/on_image_inter_barcode_data.dart';
import 'package:flutter_google_ml_kit/objects/barcode_marker.dart';
import 'package:flutter_google_ml_kit/objects/inter_barcode_real_data.dart';
import 'package:hive/hive.dart';

import 'consolidate_processed_data.dart';

processRawOnImageData(
    Map rawOnImageDataMap, Box consolidatedDataBox, Box lookupTable) {
  Map<String, OnImageInterBarcodeData> processedData =
      deduplicateRawData(rawOnImageDataMap);

  List<RealInterBarcodeData> realInterBarcodeDataList = [];
  Map<String, BarcodeMarker> consolidatedDataMap = {};

  processedData.forEach((key, value) {
    OnImageInterBarcodeData onImageBarcodeData = value;

    Offset realInterBarcodeOffset = convertOnImageOffsetToRealOffset(
      aveDiagonalSideLength: onImageBarcodeData.aveDiagonalLength,
      onImageInterBarcodeOffset: Offset(onImageBarcodeData.interBarcodeOffset.x,
          onImageBarcodeData.interBarcodeOffset.y),
    );

    List<double> imageSizesLookupTable = getImageSizes(lookupTable.toMap());

    print(value.aveDiagonalLength);
    // double distanceFromCamera = calaculateDistanceFormCamera(
    //     value.aveDiagonalLength, lookupTable.toMap(), imageSizesLookupTable);

    RealInterBarcodeData realBarcodeData = RealInterBarcodeData(
        uid: onImageBarcodeData.uid,
        uidStart: onImageBarcodeData.uidStart,
        uidEnd: onImageBarcodeData.uidEnd,
        interBarcodeOffset: realInterBarcodeOffset,
        distanceFromCamera: 0,
        timestamp: value.timestamp);

    realInterBarcodeDataList.add(realBarcodeData);
  });

  if (realInterBarcodeDataList.isNotEmpty) {
    addFixedPoint(realInterBarcodeDataList.first, consolidatedDataMap);
  }

  consolidateProcessedData(
      realInterBarcodeDataList, consolidatedDataMap, consolidatedDataBox);
}

Offset convertOnImageOffsetToRealOffset(
    {required Offset onImageInterBarcodeOffset,
    required double aveDiagonalSideLength}) {
  return onImageInterBarcodeOffset / aveDiagonalSideLength;
}
