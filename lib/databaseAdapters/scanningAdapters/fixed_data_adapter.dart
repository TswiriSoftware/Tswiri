import 'package:flutter_google_ml_kit/databaseAdapters/typeAdapters/type_offset_adapter.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/type_offset_converters.dart';
import 'package:hive/hive.dart';
part 'fixed_data_adapter.g.dart';

@HiveType(typeId: 0)
class FixedDataHiveObject extends HiveObject {
  ///This objects stores the real offset between barcodes aswell as the Z offset relative to a fixed bacodes.
  FixedDataHiveObject({
    required this.uid,
    required this.fixed,
  });

  //Barcode's ID or Displayvalue
  @HiveField(0)
  late String uid;

  //Real offset relative to a fixed barcode.
  @HiveField(1)
  late bool fixed;
}
