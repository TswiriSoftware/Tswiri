import 'package:isar/isar.dart';
part 'marker.g.dart';

@Collection()
@Name("Marker")
class Marker {
  int id = Isar.autoIncrement;

  //Generation Time.
  @Name("containerUID")
  late String? containerUID;

  ///Range Start.
  @Name("barcodeUID")
  late String barcodeUID;

  @override
  String toString() {
    return '\nparentContainerUID: $containerUID, barcodeUID: $barcodeUID';
  }
}
