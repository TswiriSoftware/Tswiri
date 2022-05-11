import 'package:isar/isar.dart';
part 'user_tag.g.dart';

@Collection()
class UserTag {
  int id = Isar.autoIncrement;

  late int tagID;

  @override
  String toString() {
    return 'tagID: $tagID';
  }

  Map toJson() => {
        'id': id,
        'tagID': tagID,
      };

  UserTag fromJson(Map<String, dynamic> json) {
    return UserTag()
      ..id = json['id']
      ..tagID = json['tagID'];
  }
}
