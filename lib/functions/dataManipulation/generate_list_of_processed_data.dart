import 'package:vector_math/vector_math.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/raw_data_adapter.dart';
import 'package:flutter_google_ml_kit/objects/inter_barcode_vector.dart';
import 'package:hive/hive.dart';

List<InterBarcodeVector> listProcessedData(Box processedDataBox) {
  List<InterBarcodeVector> processedDataList = [];
  var processedData = processedDataBox.toMap();

  processedData.forEach((key, value) {
    RelativeQrCodes data = value;
    InterBarcodeVector listData = InterBarcodeVector(
        startQrCode: data.uidStart,
        endQrCode: data.uidEnd,
        vector: Vector2(data.x, data.y));
    processedDataList.add(listData);
  });

  return processedDataList;
}
