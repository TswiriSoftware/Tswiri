import 'package:isar/isar.dart';
part 'marker.g.dart';

@Collection()
class Marker {
  int id = Isar.autoIncrement;

  late String barcodeUID;

  late String parentContainerUID;

  @override
  String toString() {
    return 'barcodeUID: $barcodeUID, containerUID: $parentContainerUID';
  }
}
