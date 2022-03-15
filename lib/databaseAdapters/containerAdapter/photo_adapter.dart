import 'package:hive/hive.dart';
part 'photo_adapter.g.dart';

@HiveType(typeId: 12)

///Stores the Type offset in the hive database
class PhotoEntry extends HiveObject {
  PhotoEntry({
    required this.photoUID,
    required this.containerUID,
  });

  ///Photo's storage path.
  @HiveField(0)
  late String photoUID;

  ///Linked container UID
  @HiveField(1)
  late String containerUID;
}
