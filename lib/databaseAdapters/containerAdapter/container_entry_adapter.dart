import 'package:flutter_google_ml_kit/databaseAdapters/containerAdapter/vector_3_entry_adapter.dart';
import 'package:hive/hive.dart';

import '../../storageSystem/photo.dart';
import 'conatiner_type_adapter.dart';
part 'container_entry_adapter.g.dart';

@HiveType(typeId: 2)
class ContainerEntryOLD extends HiveObject {
  ContainerEntryOLD(
      {required this.containerUID,
      this.containerType,
      this.parentUID,
      this.name,
      this.description,
      this.barcodeUID,
      this.children});

  ///UID containerType_timestamp
  @HiveField(0)
  late String containerUID;

  ///Parent container's UID
  @HiveField(1)
  late String? parentUID;

  ///Userdefined name
  @HiveField(2)
  late String? name;

  ///Userdefined description
  @HiveField(3)
  late String? description;

  ///ContainerType
  @HiveField(4)
  late ContainerType? containerType;

  ///BarcodeUID
  @HiveField(5)
  late String? barcodeUID;

  ///containerUID's of children
  @HiveField(6)
  late List<String>? children;

  @override
  String toString() {
    return 'UID: $containerUID,\nType: $containerType,\nName: $name,\nDescription: $description,\nParentUID $parentUID,\nBarcodeUID $barcodeUID,\nChildren $children';
  }
}
