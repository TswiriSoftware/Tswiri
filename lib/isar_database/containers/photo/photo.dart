import 'dart:developer';

import 'package:isar/isar.dart';

part 'photo.g.dart';

@Collection()
class Photo {
  ///ID.
  int id = Isar.autoIncrement;

  ///ContainerUID.
  late String containerUID;

  ///PhotoPath.
  late String photoPath;

  ///PhotoThumbnailPath.
  late String thumbnailPath;

  @override
  String toString() {
    return '\nID: $id, containerID: $containerUID ';
  }

  Map toJson() => {
        'id': id,
        'containerUID': containerUID,
        'photoPath': photoPath.split('/').last,
        'thumbnailPath': thumbnailPath.split('/').last,
      };

  Photo fromJson(Map<String, dynamic> json, String storagePath) {
    String photoFilePath = '$storagePath/sunbird/' + json['photoPath'];
    log(photoFilePath);
    String photoThumbnail = '$storagePath/sunbird/' + json['thumbnailPath'];
    return Photo()
      ..id = json['id']
      ..containerUID = json['containerUID']
      ..photoPath = photoFilePath
      ..thumbnailPath = photoThumbnail;
  }
}
