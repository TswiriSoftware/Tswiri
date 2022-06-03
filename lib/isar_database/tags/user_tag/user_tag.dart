import 'package:isar/isar.dart';
part 'user_tag.g.dart';

@Collection()
class UserTag {
  int id = Isar.autoIncrement;

  late int photoID;

  late int textID;

  @override
  bool operator ==(Object other) {
    return other is UserTag &&
        id == other.id &&
        photoID == other.photoID &&
        textID == other.textID;
  }

  @override
  String toString() {
    return 'photoID: $photoID, textID: $textID';
  }

  Map toJson() => {'id': id, 'tagID': photoID, 'textID': textID};

  UserTag fromJson(Map<String, dynamic> json) {
    return UserTag()
      ..id = json['id']
      ..photoID = json['tagID']
      ..textID = json['textID'];
  }

  @override
  int get hashCode => id.hashCode;
}
