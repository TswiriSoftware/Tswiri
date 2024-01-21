import 'package:isar/isar.dart';
part 'cataloged_container.g.dart';

///Stores details about a container (Created by user).
///
///  - ```containerUID``` Unique identifier.
///  - ```containerTypeID``` Type of container [ContainerType].
///  - ```name``` Name of the container.
///  - ```description``` Description of the container.
///  - ```barcodeUID``` Barcode linked to this container.
@Collection()
@Name("CatalogedContainer")
class CatalogedContainer {
  Id id = Isar.autoIncrement;

  ///UID.
  @Name("containerUID")
  @Index(unique: true)
  late String containerUID;

  ///Container Type.
  @Name("containerTypeID")
  late int containerTypeID;

  ///Container Name.
  @Name("name")
  late String? name;

  ///Description.
  @Name("description")
  late String? description;

  ///Linked BarcodeUID
  @Name("barcodeUID")
  late String? barcodeUID;

  // @override
  // bool operator ==(Object other) {
  //   return other is CatalogedContainer &&
  //       id == other.id &&
  //       containerType == other.containerType &&
  //       containerUID == other.containerUID &&
  //       name == other.name &&
  //       description == other.description &&
  //       barcodeUID == other.barcodeUID;
  // }

  @override
  String toString() {
    return '\nUID: $containerUID, Type: $containerTypeID, Name: $name, Description: $description, BarcodeUID $barcodeUID';
  }

  Map toJson() => {
        'id': id,
        'containerUID': containerUID,
        'containerTypeID': containerTypeID,
        'name': name,
        'description': description,
        'barcodeUID': barcodeUID,
      };

  CatalogedContainer fromJson(Map<String, dynamic> json) {
    return CatalogedContainer()
      ..id = json['id']
      ..containerUID = json['containerUID']
      ..containerTypeID = json['containerTypeID']
      ..name = json['name']
      ..description = json['description']
      ..barcodeUID = json['barcodeUID'];
  }
}
