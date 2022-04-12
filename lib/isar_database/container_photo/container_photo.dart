import 'package:isar/isar.dart';
part 'container_photo.g.dart';

@Collection()
class ContainerPhoto {
  int id = Isar.autoIncrement;

  late String containerUID;

  late String photoPath;

  @override
  String toString() {
    return 'UID: $containerUID: Tag: $photoPath';
  }

  Map toJson() => {
        'id': id,
        'containerUID': containerUID,
        'photoPath': photoPath,
      };

  ContainerPhoto fromJson(Map<String, dynamic> json) {
    return ContainerPhoto()
      ..id = json['id']
      ..containerUID = json['containerUID']
      ..photoPath = json['photoPath'];
  }
}
