import 'package:fast_immutable_collections/src/ilist/list_extension.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/raw_data_adapter.dart';

Map<String, RelativeQrCodes> deduplicateRawData(Map rawData) {
  Map<String, RelativeQrCodes> processedData = {};
  List uids = [];
  uids.clear();
  rawData.forEach((key, value) {
    RelativeQrCodes data = value;
    uids.add(data.uidStart);
    uids.removeDuplicates();
    if (!uids.contains(data.uidEnd)) {
      var qrCodesVector = RelativeQrCodes(
          uid: data.uid,
          uidStart: data.uidStart,
          uidEnd: data.uidEnd,
          x: data.x,
          y: data.y,
          timestamp: data.timestamp);
      processedData.update(
        data.uid,
        (value) => qrCodesVector,
        ifAbsent: () => qrCodesVector,
      );
    }
  });
  return processedData;
}
