import 'package:isar/isar.dart';
part 'user_tag.g.dart';

@Collection()
class UserTag {
  int id = Isar.autoIncrement;

  late int userTagID;

  late int tagTextID;

  @override
  String toString() {
    return 'tagID: $userTagID, textID: $tagTextID';
  }

  Map toJson() => {
        'id': id,
        'tagID': userTagID,
      };

  UserTag fromJson(Map<String, dynamic> json) {
    return UserTag()
      ..id = json['id']
      ..userTagID = json['tagID'];
  }
}
