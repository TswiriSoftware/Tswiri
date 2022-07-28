import 'package:isar/isar.dart';
part 'cataloged_grid.g.dart';

@Collection()
@Name("CatalogedGrid")
class CatalogedGrid {
  int id = Isar.autoIncrement;

  ///Barcode UID.
  @Name("barcodeUID")
  late String barcodeUID;

  ///Barcode UID.
  @Name("parentBarcodeUID")
  late String? parentBarcodeUID;

  @override
  String toString() {
    return '\nbarcodeUID: $barcodeUID';
  }
}
