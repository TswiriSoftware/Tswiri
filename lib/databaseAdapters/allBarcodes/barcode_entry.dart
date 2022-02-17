import 'package:hive/hive.dart';
part 'barcode_entry.g.dart';

@HiveType(typeId: 6)

///Contains data related to a barcode such as size and name
class BarcodeDataEntry extends HiveObject {
  BarcodeDataEntry(
      {required this.barcodeID,
      required this.barcodeSize,
      required this.isFixed});

  ///Barcode's ID
  @HiveField(0)
  late int barcodeID;

  ///Barcode Diagonal side length in mm.
  @HiveField(1)
  late double barcodeSize;

  ///Barcode Diagonal side length in mm.
  @HiveField(2)
  late bool isFixed;
}
