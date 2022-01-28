import 'package:flutter_google_ml_kit/databaseAdapters/type_offset_adapter.dart';
import 'package:hive/hive.dart';
part 'on_image_inter_barcode_data.g.dart';

@HiveType(typeId: 0)
class OnImageInterBarcodeDataHiveObject extends HiveObject {
  OnImageInterBarcodeDataHiveObject(
      {required this.uid,
      required this.uidStart,
      required this.uidEnd,
      required this.interBarcodeOffset,
      required this.aveDiagonalLength,
      required this.timestamp});

  ///uid = uidStart_uidEnd.
  @HiveField(0)
  late String uid;

  ///uid of the start barcode.
  @HiveField(1)
  late String uidStart;

  ///uid of the end barcode.
  @HiveField(2)
  late String uidEnd;

  ///The inter barcode offset on the image.
  @HiveField(3)
  late TypeOffset interBarcodeOffset;

  ///The average diagonal length of the two barcodes.
  @HiveField(4)
  late double aveDiagonalLength;

  ///Timestamp of when the barcodes where scanned.
  @HiveField(5)
  late int timestamp;
}
