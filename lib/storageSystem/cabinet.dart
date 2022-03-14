import 'package:flutter_google_ml_kit/storageSystem/container.dart';
import 'package:flutter_google_ml_kit/storageSystem/tag.dart';
import 'package:vector_math/vector_math.dart';
import 'package:flutter_google_ml_kit/storageSystem/photo.dart';
import 'package:flutter_google_ml_kit/storageSystem/container_types.dart';

class Cabinet implements Container {
  Cabinet({
    required this.containerUID,
    required this.parentUID,
    required this.barcodeUID,
    required this.name,
    this.description,
    this.children,
    this.tags,
    this.photos,
  });

  @override
  String? barcodeUID;

  @override
  List<Container>? children;

  @override
  ContainerType containerType = ContainerType.cabinet;

  @override
  String containerUID;

  @override
  String? description;

  @override
  bool? isMarker = true;

  @override
  String? name;

  @override
  String? parentUID;

  @override
  List<Photo>? photos;

  @override
  List<Tag>? tags;

  @override
  Vector3? vector3 = Vector3(0, 0, 0);
}
