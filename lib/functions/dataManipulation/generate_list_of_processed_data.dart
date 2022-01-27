import 'package:flutter/cupertino.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/on_image_inter_barcode_data.dart';
import 'package:flutter_google_ml_kit/objects/inter_barcode_offset.dart';
import 'package:hive/hive.dart';

List<InterBarcodeOffset> listProcessedData(Box processedDataBox) {
  List<InterBarcodeOffset> processedDataList = [];
  var processedData = processedDataBox.toMap();

  processedData.forEach((key, value) {
    OnImageInterBarcodeData data = value;
    InterBarcodeOffset listData = InterBarcodeOffset(
        startQrCode: data.uidStart,
        endQrCode: data.uidEnd,
        offset: Offset(data.interBarcodeOffset.x, data.interBarcodeOffset.y));
    processedDataList.add(listData);
  });

  return processedDataList;
}
