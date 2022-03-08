import 'package:hive/hive.dart';
part 'barcode_photo_entry.g.dart';

@HiveType(typeId: 7)

///Contains data related to a barcode such as size and name
class BarcodePhotosEntry extends HiveObject {
  BarcodePhotosEntry({required this.uid, required this.photoData});

  ///Barcode's ID
  @HiveField(0)
  late int uid;

  ///Barcode Diagonal side length in mm.
  @HiveField(1)
  late Map<String, List<String>> photoData;

  @override
  String toString() {
    return '$uid\n $photoData';
  }
}
