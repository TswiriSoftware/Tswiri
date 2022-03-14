import 'package:flutter_google_ml_kit/storageSystem/container.dart';
import 'package:flutter_google_ml_kit/storageSystem/tag.dart';
import 'package:vector_math/vector_math.dart';
import 'package:flutter_google_ml_kit/storageSystem/photo.dart';
import 'package:flutter_google_ml_kit/storageSystem/container_types.dart';

class Drawer implements Container {
  Drawer({
    required this.containerUID,
  });

  @override
  String? barcodeUID;

  @override
  List<Container>? children;

  @override
  ContainerType containerType = ContainerType.drawer;

  @override
  String containerUID;

  @override
  String? description;

  @override
  bool? isMarker;

  @override
  String? name;

  @override
  String? parentUID;

  @override
  List<Photo>? photos;

  @override
  List<Tag>? tags;

  @override
  Vector3? vector3;
}
