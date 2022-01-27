import 'package:flutter_google_ml_kit/databaseAdapters/type_offset_adapter.dart';
import 'package:hive/hive.dart';
part 'on_image_inter_barcode_data.g.dart';

@HiveType(typeId: 0)
class OnImageInterBarcodeData extends HiveObject {
  OnImageInterBarcodeData(
      {required this.uid,
      required this.uidStart,
      required this.uidEnd,
      required this.interBarcodeOffset,
      required this.aveDiagonalLength,
      required this.timestamp});

  @HiveField(0)
  late String uid;

  @HiveField(1)
  late String uidStart;

  @HiveField(2)
  late String uidEnd;

  @HiveField(3)
  late TypeOffset interBarcodeOffset;

  @HiveField(4)
  late double aveDiagonalLength;

  @HiveField(5)
  late int timestamp;

  @override
  String toString() {
    return '$uidStart, $uidEnd, $aveDiagonalLength, $timestamp';
  }
}
