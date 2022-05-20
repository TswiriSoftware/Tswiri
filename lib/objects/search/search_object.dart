import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/photo/photo.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/container_tag/container_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/ml_tag/ml_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/user_tag/user_tag.dart';

class SContainer {
  SContainer({
    required this.container,
    this.tags,
    this.sPhotos,
  });

  final ContainerEntry container;
  late Color color = getContainerColor(containerUID: container.containerUID);

  List<ContainerTag>? tags;
  List<SPhoto>? sPhotos;

  List<MlTag> get mlTags {
    List<MlTag> tags = [];
    if (sPhotos != null && sPhotos!.isNotEmpty) {
      for (var sPhoto in sPhotos!) {
        if (sPhoto.mlTags != null && sPhoto.mlTags!.isNotEmpty) {
          tags.addAll(sPhoto.mlTags!);
        }
      }
      return tags;
    }
    return tags;
  }

  List<Photo> get photos {
    List<Photo> photos = [];
    if (sPhotos != null && sPhotos!.isNotEmpty) {
      for (var sPhoto in sPhotos!) {
        photos.add(sPhoto.photo);
      }
      return photos;
    }
    return photos;
  }

  List<UserTag> get userTags {
    List<UserTag> tags = [];
    if (sPhotos != null && sPhotos!.isNotEmpty) {
      for (var sPhoto in sPhotos!) {
        if (sPhoto.userTags != null && sPhoto.userTags!.isNotEmpty) {
          tags.addAll(sPhoto.userTags!);
        }
      }
      return tags;
    }
    return tags;
  }

  void merge(SContainer sContainer) {
    //Tag merge
    if (tags == null) {
      tags = sContainer.tags;
    } else {
      if (sContainer.tags != null) {
        tags!.addAll(sContainer.tags!);
      }
    }

    if (sPhotos == null) {
      sPhotos = sContainer.sPhotos;
    } else {
      if (sContainer.sPhotos == null) {
        sPhotos!.addAll(sContainer.sPhotos!);
      } else {}
    }
  }

  @override
  bool operator ==(Object other) {
    if (other is SContainer) {
      if (other.container.containerUID == container.containerUID) {
        return true;
      }
    }
    return false;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => container.containerUID.hashCode;

  @override
  String toString() {
    return '''
uid: ${container.containerUID}
tags: $tags
mlTags: $mlTags
userTags: $userTags
''';
  }
}

class SPhoto {
  SPhoto({
    required this.photo,
    this.mlTags,
    this.userTags,
  });
  Photo photo;
  List<MlTag>? mlTags;
  List<UserTag>? userTags;

  void merge(SPhoto sPhoto) {
    //MlTags
    if (mlTags == null && sPhoto.mlTags != null) {
      mlTags = sPhoto.mlTags;
    }
    //User Tags
    if (userTags == null && sPhoto.userTags != null) {
      userTags = sPhoto.userTags;
    }
  }

  @override
  String toString() {
    return '''
photoID : ${photo.id}
mlTags  : $mlTags
userTags: $userTags
''';
  }
}
