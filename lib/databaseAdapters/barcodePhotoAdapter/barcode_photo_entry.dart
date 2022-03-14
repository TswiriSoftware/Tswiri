import 'package:hive/hive.dart';
part 'barcode_photo_entry.g.dart';

@HiveType(typeId: 7)
class BarcodePhotosEntry extends HiveObject {
  BarcodePhotosEntry({required this.uid, required this.photoData});

  @HiveField(0)
  late String uid;

  @HiveField(1)
  late Map<String, List<String>> photoData;

  @override
  String toString() {
    return '$uid\n $photoData';
  }
}
