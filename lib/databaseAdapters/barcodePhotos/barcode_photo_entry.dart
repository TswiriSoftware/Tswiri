import 'package:hive/hive.dart';
part 'barcode_photo_entry.g.dart';

@HiveType(typeId: 7)

///Contains data related to a barcode such as size and name
class BarcodePhotoEntry extends HiveObject {
  BarcodePhotoEntry(
      {required this.barcodeID,
      required this.photoPath,
      required this.photoTags});

  ///Barcode's ID
  @HiveField(0)
  late int barcodeID;

  ///Barcode Diagonal side length in mm.
  @HiveField(1)
  late String photoPath;

  ///Barcode Diagonal side length in mm.
  @HiveField(2)
  late List<String> photoTags;

  @override
  String toString() {
    return '\n$barcodeID\n $photoPath\n Tags: $photoTags\n';
  }
}
