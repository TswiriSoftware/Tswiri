import 'package:isar/isar.dart';
part 'user_tag.g.dart';

@Collection()
class UserTag {
  int id = Isar.autoIncrement;

  late int photoID;

  late int textID;

  @override
  String toString() {
    return 'photoID: $photoID, textID: $textID';
  }

  Map toJson() => {
        'id': id,
        'tagID': photoID,
      };

  UserTag fromJson(Map<String, dynamic> json) {
    return UserTag()
      ..id = json['id']
      ..photoID = json['tagID'];
  }
}
