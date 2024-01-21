import 'dart:io';
import 'dart:ui';
import 'package:image/image.dart' as img;
import 'package:isar/isar.dart';
part 'photo.g.dart';

///TODO: finish commenting.

///Stores details about a container (Created by user).
///
///  - ```containerUID``` Unique identifier.
///  - ```containerTypeID``` Type of container [ContainerType].
///  - ```name``` Name of the container.
///  - ```description``` Description of the container.
///  - ```barcodeUID``` Barcode linked to this container.
///
@Collection()
@Name("Photo")
class Photo {
  ///ID.
  Id id = Isar.autoIncrement;

  ///ContainerUID.
  @Name("containerUID")
  late String? containerUID;

  ///Photo Name.
  @Name("photoName")
  late int photoName;

  @Name("extension")
  late String extension;

  @Name("thumbnailName")
  late String thumbnailName;

  @Name("thumbnailExtension")
  late String thumbnailExtension;

  ///Photo Size.
  @Name("photoSize")
  late IsarSize photoSize;

  @override
  String toString() {
    return '\nID: $id, containerID: $containerUID ';
  }

  String getPhotoPath({required String photoDirectory}) {
    return '$photoDirectory/$photoName.$extension';
  }

  String getPhotoThumbnailPath({required String photoDirectory}) {
    return '$photoDirectory/${photoName}__thumbnail.$extension';
  }

  Size getPhotoSize({required String photoDirectory}) {
    File imageFile = File(getPhotoPath(photoDirectory: photoDirectory));
    img.Image image = img.decodeImage(imageFile.readAsBytesSync())!;
    return Size(image.width.toDouble(), image.height.toDouble());
  }
}

@embedded
class IsarSize {
  double? width;
  double? height;

  IsarSize({
    this.width,
    this.height,
  });
}
