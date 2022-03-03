import 'package:hive/hive.dart';
part 'barcode_photo_entry.g.dart';

@HiveType(typeId: 7)

///Contains data related to a barcode such as size and name
class BarcodePhotosEntry extends HiveObject {
  BarcodePhotosEntry({required this.barcodeID, required this.photoData});

  ///Barcode's ID
  @HiveField(0)
  late int barcodeID;

  ///Barcode Diagonal side length in mm.
  @HiveField(1)
  late Map<String, List<String>> photoData;

  @override
  String toString() {
    return '$barcodeID\n $photoData';
  }
}
