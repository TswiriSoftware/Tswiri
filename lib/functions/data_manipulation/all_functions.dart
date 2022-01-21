import 'package:fast_immutable_collections/src/ilist/list_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/raw_data_adapter.dart';

List<dynamic> deduplicateRawData(List<dynamic> rawDataBox) {
  var rawData = rawDataBox.toMap();
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
      processedDataBox.put(key, qrCodesVector);
    }
  });
  print('processedDataBox: ${processedDataBox.toMap()}');
  return processedDataBox
}