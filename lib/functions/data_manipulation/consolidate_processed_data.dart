import 'package:flutter_google_ml_kit/databaseAdapters/consolidated_data_adapter.dart';
import 'package:flutter_google_ml_kit/objects/barcode_marker.dart';
import 'package:flutter_google_ml_kit/objects/inter_barcode_vector.dart';
import 'package:vector_math/vector_math.dart';
import 'package:hive/hive.dart';

consolidateProcessedData(List<InterBarcodeVector> processedDataList,
    Map<String, BarcodeMarker> consolidatedData, Box consolidatedDataBox) {
  for (var i = 0; i < processedDataList.length; i++) {
    if (consolidatedData.containsKey(processedDataList[i].startQrCode)) {
      String id = processedDataList[i].endQrCode;
      Vector2 position =
          consolidatedData[processedDataList[i].startQrCode]!.position +
              processedDataList[i].vector;
      BarcodeMarker point =
          BarcodeMarker(id: id, position: position, fixed: false);
      consolidatedData.update(
        id,
        (value) => point,
        ifAbsent: () => point,
      );
    } else if (consolidatedData.containsKey(processedDataList[i].endQrCode)) {
      String id = processedDataList[i].startQrCode;
      Vector2 position =
          consolidatedData[processedDataList[i].endQrCode]!.position +
              (processedDataList[i].vector * -1);

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
    consolidatedDataBox.put(
        value.id,
        ConsolidatedData(
            uid: value.id,
            X: value.position.x,
            Y: value.position.y,
            fixed: value.fixed));
  });
}
