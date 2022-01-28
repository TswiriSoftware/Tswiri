// ignore: implementation_imports
import 'package:fast_immutable_collections/src/ilist/list_extension.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/on_image_inter_barcode_data.dart';

Map<String, OnImageInterBarcodeDataHiveObject> deduplicateRawOnImageData(
    Map rawData) {
  Map<String, OnImageInterBarcodeDataHiveObject> processedData = {};
  List uids = [];
  uids.clear();
  rawData.forEach((key, value) {
    OnImageInterBarcodeDataHiveObject data = value;
    uids.add(data.uidStart);
    uids.removeDuplicates();
    if (!uids.contains(data.uidEnd)) {
      var qrCodesVector = OnImageInterBarcodeDataHiveObject(
        uid: data.uid,
        uidStart: data.uidStart,
        uidEnd: data.uidEnd,
        interBarcodeOffset: data.interBarcodeOffset,
        startDiagonalLength: data.startDiagonalLength,
        endDiagonalLength: data.endDiagonalLength,
        timestamp: data.timestamp,
      );
      processedData.update(
        data.uid,
        (value) => qrCodesVector,
        ifAbsent: () => qrCodesVector,
      );
    }
  });
  return processedData;
}
