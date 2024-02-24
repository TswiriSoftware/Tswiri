import 'package:isar/isar.dart';
part 'marker.g.dart';

//TODO: finish comments.
@Collection()
@Name("Marker")
class Marker {
  Id id = Isar.autoIncrement;

  //Generation Time.
  @Name("containerUID")
  late String? containerUUID;

  ///Range Start.
  @Name("barcodeUID")
  late String barcodeUUID;

  @override
  String toString() {
    return '\nparentContainerUID: $containerUUID, barcodeUID: $barcodeUUID';
  }
}
