import 'dart:ui';
import 'package:flutter_google_ml_kit/databaseAdapters/scanningAdapters/consolidated_data_adapter.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/type_offset_converters.dart';
import 'package:flutter_google_ml_kit/objects/barcode_marker.dart';
import 'package:flutter_google_ml_kit/objects/real_inter_barcode_data.dart';
import 'package:hive/hive.dart';

consolidateProcessedData(
    List<RealInterBarcodeData> realInterBarcodeDataList,
    Map<String, RealBarcodeMarker> consolidatedDataMap,
    Box consolidatedDataBox) {
  for (int i = 0; i < 10; i++) {
    for (var interBarcodeVector in realInterBarcodeDataList) {
      if (consolidatedDataMap.containsKey(interBarcodeVector.uidStart) &&
          !consolidatedDataMap.containsKey(interBarcodeVector.uidEnd)) {
        Offset position =
            consolidatedDataMap[interBarcodeVector.uidStart]!.offset +
                interBarcodeVector.interBarcodeOffset;

        //caluclate Z offset correctly
        // double realDistanceRelative =
        //     consolidatedDataMap[interBarcodeVector.uidStart]!
        //             .distanceFromCamera -
        //         interBarcodeVector.distanceFromCamera;

        RealBarcodeMarker point = RealBarcodeMarker(
            id: interBarcodeVector.uidEnd,
            offset: position,
            fixed: false,
            distanceFromCamera: interBarcodeVector.distanceFromCamera);
        consolidatedDataMap.update(
          interBarcodeVector.uidEnd,
          (value) => point,
          ifAbsent: () => point,
        );
      } else if (consolidatedDataMap.containsKey(interBarcodeVector.uidEnd) &&
          !consolidatedDataMap.containsKey(interBarcodeVector.uidStart)) {
        Offset position =
            consolidatedDataMap[interBarcodeVector.uidEnd]!.offset +
                (-interBarcodeVector.interBarcodeOffset);

        // double realDistanceRelative =
        //     consolidatedDataMap[interBarcodeVector.uidEnd]!.distanceFromCamera -
        //         interBarcodeVector.distanceFromCamera;

        RealBarcodeMarker point = RealBarcodeMarker(
            id: interBarcodeVector.uidStart,
            offset: position,
            fixed: false,
            distanceFromCamera: interBarcodeVector.distanceFromCamera);
        consolidatedDataMap.update(
          interBarcodeVector.uidStart,
          (value) => point,
          ifAbsent: () => point,
        );
      }
    }

    consolidatedDataMap.forEach((key, realBarcodeMarker) {
      consolidatedDataBox.put(
          realBarcodeMarker.id,
          ConsolidatedDataHiveObject(
              uid: realBarcodeMarker.id,
              offset: offsetToTypeOffset(realBarcodeMarker.offset),
              distanceFromCamera: realBarcodeMarker.distanceFromCamera,
              fixed: realBarcodeMarker.fixed));
    });
  }
}
