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
}
