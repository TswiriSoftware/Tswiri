import 'package:isar/isar.dart';
part 'container_photo.g.dart';

@Collection()
class ContainerPhoto {
  int id = Isar.autoIncrement;

  late String containerUID;

  late String photoPath;

  late String photoThumbnailPath;

  @override
  String toString() {
    return 'UID: $containerUID: Tag: $photoPath';
  }

  Map toJson() => {
        'id': id,
        'containerUID': containerUID,
        'photoPath': photoPath.split('/').last,
        'photoThumbnailPath': photoThumbnailPath.split('/').last,
      };

  ContainerPhoto fromJson(Map<String, dynamic> json, String storagepath) {
    return ContainerPhoto()
      ..id = json['id']
      ..containerUID = json['containerUID']
      ..photoPath = storagepath + json['photoPath']
      ..photoThumbnailPath = storagepath + json['photoThumbnailPath'];
  }
}
