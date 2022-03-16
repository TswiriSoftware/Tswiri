import 'package:flutter_google_ml_kit/databaseAdapters/containerAdapter/conatiner_type_adapter.dart';
import 'package:isar/isar.dart';
part 'container_isar.g.dart';

@Collection()
class ContainerEntry {
  int id = Isar.autoIncrement;

  late String containerUID;

  @ContainerTypeConverter()
  late ContainerType containerType;

  late String? name;

  late String? description;

  late String? barcodeUID;

  @override
  String toString() {
    return 'UID: $containerUID,\nType: $containerType,\nName: $name,\nDescription: $description,\nBarcodeUID $barcodeUID';
  }
}

class ContainerTypeConverter extends TypeConverter<ContainerType, int> {
  const ContainerTypeConverter(); // Converters need to have an empty const constructor

  @override
  ContainerType fromIsar(int containerTypeIndex) {
    return ContainerType.values[containerTypeIndex];
  }

  @override
  int toIsar(ContainerType containerType) {
    return containerType.index;
  }
}
