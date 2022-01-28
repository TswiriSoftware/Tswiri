import 'dart:ui';
import 'package:flutter_google_ml_kit/databaseAdapters/consolidated_data_adapter.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/type_offset_adapter.dart';
import 'package:flutter_google_ml_kit/objects/barcode_marker.dart';
import 'package:flutter_google_ml_kit/objects/real_inter_barcode_data.dart';
import 'package:hive/hive.dart';

consolidateProcessedData(List<RealInterBarcodeData> realInterBarcodeDataList,
    Map<String, BarcodeMarker> consolidatedData, Box consolidatedDataBox) {
  for (int i = 0; i < 10; i++) {
    for (var interBarcodeVector in realInterBarcodeDataList) {
      if (consolidatedData.containsKey(interBarcodeVector.uidStart) &&
          !consolidatedData.containsKey(interBarcodeVector.uidEnd)) {
        Offset position =
            consolidatedData[interBarcodeVector.uidStart]!.offset +
                interBarcodeVector.interBarcodeOffset;

        BarcodeMarker point = BarcodeMarker(
            id: interBarcodeVector.uidEnd,
            offset: position,
            fixed: false,
            distanceFromCamera: interBarcodeVector.distanceFromCamera);
        consolidatedData.update(
          interBarcodeVector.uidEnd,
          (value) => point,
          ifAbsent: () => point,
        );
      } else if (consolidatedData.containsKey(interBarcodeVector.uidEnd) &&
          !consolidatedData.containsKey(interBarcodeVector.uidStart)) {
        Offset position = consolidatedData[interBarcodeVector.uidEnd]!.offset +
            (-interBarcodeVector.interBarcodeOffset);

        BarcodeMarker point = BarcodeMarker(
            id: interBarcodeVector.uidStart,
            offset: position,
            fixed: false,
            distanceFromCamera: interBarcodeVector.distanceFromCamera);
        consolidatedData.update(
          interBarcodeVector.uidStart,
          (value) => point,
          ifAbsent: () => point,
        );
      }
    }

    consolidatedData.forEach((key, value) {
      consolidatedDataBox.put(
          value.id,
          ConsolidatedData(
              uid: value.id,
              offset: TypeOffset(x: value.offset.dx, y: value.offset.dy),
              distanceFromCamera: value.distanceFromCamera,
              fixed: value.fixed));
    });
  }
}
