import 'package:isar/isar.dart';
part 'container_isar.g.dart';

@Collection()
class ContainerEntry {
  int id = Isar.autoIncrement;

  late String containerUID;

  late String containerType;

  late String? name;

  late String? description;

  late String? barcodeUID;

  @override
  String toString() {
    return 'UID: $containerUID,\nType: $containerType,\nName: $name,\nDescription: $description,\nBarcodeUID $barcodeUID\n';
  }
}
