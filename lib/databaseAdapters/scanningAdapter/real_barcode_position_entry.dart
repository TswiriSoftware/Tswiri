import 'package:flutter_google_ml_kit/databaseAdapters/typeAdapters/type_offset_adapter.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/type_offset_converters.dart';
import 'package:hive/hive.dart';

part 'real_barcode_position_entry.g.dart';

@HiveType(typeId: 0)
class RealBarcodePositionEntry extends HiveObject {
  ///This objects stores the real offset between barcodes aswell as the Z offset relative to a fixed bacodes.
  RealBarcodePositionEntry(
      {required this.uid,
      required this.offset,
      required this.zOffset,
      required this.isMarker,
      required this.shelfUID,
      required this.timestamp});

  //Barcode's ID or Displayvalue
  @HiveField(0)
  late String uid;

  //Real offset relative to a fixed barcode.
  @HiveField(1)
  late TypeOffset offset;

  //z Offset
  @HiveField(2)
  late double zOffset;

  //Is the barcode a fixed barcode ?
  @HiveField(3)
  late bool isMarker;

  //The timestamp
  @HiveField(4)
  late int shelfUID;

  //The timestamp
  @HiveField(5)
  late int timestamp;

  @override
  String toString() {
    return '$uid, ${typeOffsetToOffset(offset)}, $timestamp ';
  }
}
