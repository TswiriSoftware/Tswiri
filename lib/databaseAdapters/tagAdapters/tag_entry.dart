import 'package:hive/hive.dart';
part 'tag_entry.g.dart';

@HiveType(typeId: 4)
class TagEntry extends HiveObject {
  ///This objects stores the real offset between barcodes aswell as the Z offset relative to a fixed bacodes.
  TagEntry({
    required this.tag,
  });

  //Barcode's ID or Displayvalue
  @HiveField(0)
  late String tag;
}
