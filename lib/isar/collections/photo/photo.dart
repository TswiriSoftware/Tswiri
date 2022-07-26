import 'dart:ui';

import 'package:sunbird/isar/isar_database.dart';
part 'photo.g.dart';

@Collection()
@Name("Photo")
class Photo {
  ///ID.
  int id = Isar.autoIncrement;

  ///ContainerUID.
  @Name("containerUID")
  late String? containerUID;

  ///Photo Name.
  @Name("photoName")
  late int photoName;

  ///Photo Extention.
  @Name("extention")
  late String extention;

  ///Thumbnail Name.
  @Name("thumbnailName")
  late String thumbnailName;

  ///Thumbnail Extention.
  @Name("thumbnailExtention")
  late String thumbnailExtention;

  ///Photo Size.
  @Name("photoSize")
  @SizeConverter()
  late Size photoSize;

  // @override
  // bool operator ==(Object other) {
  //   return other is Photo &&
  //       id == other.id &&
  //       containerUID == other.containerUID &&
  //       photoPath.split('/').last == other.photoPath.split('/').last &&
  //       thumbnailPath.split('/').last == other.thumbnailPath.split('/').last;
  // }

  @override
  String toString() {
    return '\nID: $id, containerID: $containerUID ';
  }

  String getPhotoPath() {
    return '${photoDirectory!.path}/$photoName.$extention';
  }

  String getPhotoThumbnailPath() {
    return '${photoDirectory!.path}/${photoName}_thumbnail.$extention';
  }

  // Map toJson() => {
  //       'id': id,
  //       'containerUID': containerUID,
  //       'photoPath': photoPath.split('/').last,
  //       'thumbnailPath': thumbnailPath.split('/').last,
  //     };

  // Photo fromJson(Map<String, dynamic> json, String storagePath) {
  //   String photoFilePath = '$storagePath/sunbird/' + json['photoPath'];
  //   String photoThumbnail = '$storagePath/sunbird/' + json['thumbnailPath'];
  //   return Photo()
  //     ..id = json['id']
  //     ..containerUID = json['containerUID']
  //     ..photoPath = photoFilePath
  //     ..thumbnailPath = photoThumbnail;
  // }

  // @override
  // int get hashCode => id.hashCode;
}

class SizeConverter extends TypeConverter<Size, List<double>> {
  const SizeConverter(); // Converters need to have an empty const constructor

  @override
  Size fromIsar(List<double> object) {
    return Size(object[0], object[1]);
  }

  @override
  List<double> toIsar(Size object) {
    return [
      object.width,
      object.height,
    ];
  }
}
