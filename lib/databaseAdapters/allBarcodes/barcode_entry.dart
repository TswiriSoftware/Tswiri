import 'package:hive/hive.dart';
part 'barcode_entry.g.dart';

@HiveType(typeId: 6)

///Contains data related to a barcode such as size and name
class BarcodeDataEntry extends HiveObject {
  BarcodeDataEntry({
    required this.barcodeID,
    required this.barcodeSize,
  });

  ///Barcode's ID
  @HiveField(0)
  late int barcodeID;

  ///Barcode Physical size in mm
  @HiveField(1)
  late double barcodeSize;
}
