// import 'package:flutter_google_ml_kit/isar_database/container_entry/container_entry.dart';
// import 'package:flutter_google_ml_kit/isar_database/container_photo/container_photo.dart';
// import 'package:flutter_google_ml_kit/isar_database/container_tag/container_tag.dart';
// import 'package:flutter_google_ml_kit/isar_database/photo_tag/photo_tag.dart';

// class SearchObject {
//   SearchObject(
//       {required this.containerEntry,
//       required this.tags,
//       required this.photoTags,
//       required this.containerPhotos,
//       required this.score});

//   final ContainerEntry containerEntry;
//   final List<ContainerTag> tags;
//   final List<PhotoTag> photoTags;
//   final List<ContainerPhoto> containerPhotos;
//   int score;

//   @override
//   String toString() {
//     return '\nuid: ${containerEntry.containerUID}, tags: $tags, score: $score';
//   }

//   @override
//   // ignore: hash_and_equals
//   bool operator ==(Object other) {
//     if (other is SearchObject && other.runtimeType == runtimeType) {
//       if (other.containerEntry.containerUID == containerEntry.containerUID) {
//         return true;
//       }
//     }
//     return false;
//   }
// }
