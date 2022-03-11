import 'package:hive/hive.dart';
part 'shelf_entry.g.dart';

@HiveType(typeId: 8)

///Contains data related to a barcode such as size and name
class ShelfEntry extends HiveObject {
  ShelfEntry(
      {required this.uid, required this.name, required this.description});

  ///Shelf ID
  @HiveField(0)
  late int uid;

  ///User defined name.
  @HiveField(1)
  late String name;

  //User defined description.
  @HiveField(2)
  late String description;

  @override
  String toString() {
    return 'id: $uid\nName: $name,\nDesc: $description';
  }
}
