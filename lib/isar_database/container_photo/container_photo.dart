import 'package:isar/isar.dart';
part 'container_photo.g.dart';

@Collection()
class ContainerPhoto {
  int id = Isar.autoIncrement;

  late String containerUID;

  late String photoUID;

  @override
  String toString() {
    return 'UID: $containerUID: Tag: $photoUID';
  }
}
