import 'package:isar/isar.dart';
part 'container_entry.g.dart';

@Collection()
class ContainerEntry {
  int id = Isar.autoIncrement;

  ///UID.
  late String containerUID;

  ///Container Type.
  late String containerType;

  ///Container Name.
  late String? name;

  ///Description.
  late String? description;

  ///Linked BarcodeUID
  late String? barcodeUID;

  // @override
  // bool operator ==(Object other) {
  //   return other is ContainerEntry &&
  //       id == other.id &&
  //       containerType == other.containerType &&
  //       containerUID == other.containerUID &&
  //       name == other.name &&
  //       description == other.description &&
  //       barcodeUID == other.barcodeUID;
  // }

  @override
  String toString() {
    return '\nUID: $containerUID, Type: $containerType, Name: $name, Description: $description, BarcodeUID $barcodeUID';
  }

  Map toJson() => {
        'id': id,
        'containerUID': containerUID,
        'containerType': containerType,
        'name': name,
        'description': description,
        'barcodeUID': barcodeUID,
      };

  ContainerEntry fromJson(Map<String, dynamic> json) {
    return ContainerEntry()
      ..id = json['id']
      ..containerUID = json['containerUID']
      ..containerType = json['containerType']
      ..name = json['name']
      ..description = json['description']
      ..barcodeUID = json['barcodeUID'];
  }
}
