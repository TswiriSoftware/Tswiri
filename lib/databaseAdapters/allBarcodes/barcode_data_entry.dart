import 'package:hive/hive.dart';
part 'barcode_data_entry.g.dart';

@HiveType(typeId: 6)

///Contains data related to a barcode such as size and name
class BarcodeDataEntry extends HiveObject {
  BarcodeDataEntry(
      {required this.uid,
      required this.barcodeSize,
      required this.isMarker,
      required this.description});

  ///Barcode's ID
  @HiveField(0)
  late String uid;

  ///Barcode Diagonal side length in mm.
  @HiveField(1)
  late double barcodeSize;

  ///Barcode Diagonal side length in mm.
  @HiveField(2)
  late bool isMarker;

  ///Barcode Diagonal side length in mm.
  @HiveField(3)
  late String description;
}
