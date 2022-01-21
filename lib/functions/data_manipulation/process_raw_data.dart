import 'package:flutter_google_ml_kit/functions/data_manipulation/deduplicate_raw_data.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/raw_data_adapter.dart';
import 'package:hive/hive.dart';

processRawData(Box rawDataBox, Box processedDataBox) {
  Map rawData = rawDataBox.toMap();
  Map<String, RelativeQrCodes> processedData = deduplicateRawData(rawData);
  processedData.forEach((key, value) {
    processedDataBox.put(key, value);
  });
}
