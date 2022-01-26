import 'dart:ui';

import 'package:flutter_google_ml_kit/databaseAdapters/consolidated_data_adapter.dart';
import 'package:flutter_google_ml_kit/objects/barcode_marker.dart';
import 'package:flutter_google_ml_kit/objects/inter_barcode_vector.dart';
import 'package:vector_math/vector_math.dart';
import 'package:hive/hive.dart';

consolidateProcessedData(List<InterBarcodeVector> processedDataList,
    Map<String, BarcodeMarker> consolidatedData, Box consolidatedDataBox) {
  for (int i = 0; i < 10; i++) {
    for (var interBarcodeVector in processedDataList) {
      if (consolidatedData.containsKey(interBarcodeVector.startQrCode) &&
          !consolidatedData.containsKey(interBarcodeVector.endQrCode)) {
        String id = interBarcodeVector.endQrCode;
        Offset position =
            consolidatedData[interBarcodeVector.startQrCode]!.position +
                interBarcodeVector.offset;

        BarcodeMarker point =
            BarcodeMarker(id: id, position: position, fixed: false);
        consolidatedData.update(
          id,
          (value) => point,
          ifAbsent: () => point,
        );
      } else if (consolidatedData.containsKey(interBarcodeVector.endQrCode) &&
          !consolidatedData.containsKey(interBarcodeVector.startQrCode)) {
        String id = interBarcodeVector.startQrCode;
        Offset position =
            consolidatedData[interBarcodeVector.endQrCode]!.position +
                (-interBarcodeVector.offset);

        BarcodeMarker point =
            BarcodeMarker(id: id, position: position, fixed: false);
        consolidatedData.update(
          id,
          (value) => point,
          ifAbsent: () => point,
        );
      }
    }

    consolidatedData.forEach((key, value) {
      print('$key , ${value.position}');
      consolidatedDataBox.put(
          value.id,
          ConsolidatedData(
              uid: value.id,
              X: value.position.dx,
              Y: value.position.dy,
              fixed: value.fixed));
    });
  }
}
