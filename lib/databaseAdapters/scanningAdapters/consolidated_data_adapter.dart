import 'package:flutter_google_ml_kit/databaseAdapters/typeAdapters/type_offset_adapter.dart';
import 'package:hive/hive.dart';
part 'consolidated_data_adapter.g.dart';

@HiveType(typeId: 1)
class ConsolidatedDataHiveObject extends HiveObject {
  ///This objects stores the real offset between barcodes aswell as the Z offset relative to a fixed bacodes.
  ConsolidatedDataHiveObject(
      {required this.uid,
      required this.offset,
      required this.distanceFromCamera,
      required this.fixed});

  //Barcode's ID or Displayvalue
  @HiveField(0)
  late String uid;

  //Real offset relative to a fixed barcode.
  @HiveField(1)
  late TypeOffsetHiveObject offset;

  //Z Offset relative to a fixed barcode
  @HiveField(2)
  late double distanceFromCamera;

  //Is the barcode a fixed barcode ?
  @HiveField(3)
  late bool fixed;
}
