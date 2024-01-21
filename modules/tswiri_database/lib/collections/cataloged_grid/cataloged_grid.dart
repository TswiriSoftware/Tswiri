import 'package:isar/isar.dart';
part 'cataloged_grid.g.dart';

///TODO: finish commenting.

///Stores details about a container (Created by user).
///
///  - ```containerUID``` Unique identifier.
///  - ```containerTypeID``` Type of container [ContainerType].
///  - ```name``` Name of the container.
///  - ```description``` Description of the container.
///  - ```barcodeUID``` Barcode linked to this container.
///

@Collection()
@Name("CatalogedGrid")
class CatalogedGrid {
  Id id = Isar.autoIncrement;

  ///Barcode UID.
  @Name("barcodeUID")
  late String barcodeUID;

  ///Parent Container Barcode UID.
  @Name("parentBarcodeUID")
  late String? parentBarcodeUID;

  @override
  String toString() {
    return '\nbarcodeUID: $barcodeUID, parentBarcodeUID: $parentBarcodeUID';
  }
}
