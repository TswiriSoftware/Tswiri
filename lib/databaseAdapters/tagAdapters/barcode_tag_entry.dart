import 'package:hive/hive.dart';
part 'barcode_tag_entry.g.dart';

@HiveType(typeId: 3)
class BarcodeTagEntry extends HiveObject {
  ///This objects a single barcodeID and a single tag its Key is barcodeID_tag
  ///
  ///ex. 7_tools, 1_documents
  BarcodeTagEntry({
    required this.id,
    required this.tag,
  });

  //Barcode's ID or Displayvalue
  @HiveField(0)
  late int id;

  //tag
  @HiveField(1)
  late String tag;
}
