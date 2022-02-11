import 'package:hive/hive.dart';
part 'barcode_entry.g.dart';

@HiveType(typeId: 6)
class BarcodeData extends HiveObject {
  BarcodeData({
    required this.barcodeID,
    this.barcodeName,
    required this.barcodeSize,
  });

  //Barcode's ID
  @HiveField(0)
  late int barcodeID;

  //Barcode Name ??
  @HiveField(1)
  late String? barcodeName;

  //Barcode Physical size in mm
  @HiveField(2)
  late double barcodeSize;
}
