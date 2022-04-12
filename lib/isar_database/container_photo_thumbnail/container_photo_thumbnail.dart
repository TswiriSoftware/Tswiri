import 'package:isar/isar.dart';
part 'container_photo_thumbnail.g.dart';

@Collection()
class ContainerPhotoThumbnail {
  int id = Isar.autoIncrement;

  late String photoPath;

  late String thumbnailPhotoPath;

  @override
  String toString() {
    return 'PhotoPath: $photoPath: ThumbnailPhotoPath: $thumbnailPhotoPath';
  }

  Map toJson() => {
        'id': id,
        'photoPath': photoPath,
        'thumbnailPhotoPath': thumbnailPhotoPath,
      };

  ContainerPhotoThumbnail fromJson(Map<String, dynamic> json) {
    return ContainerPhotoThumbnail()
      ..id = json['id']
      ..photoPath = json['photoPath']
      ..thumbnailPhotoPath = json['thumbnailPhotoPath'];
  }
}
