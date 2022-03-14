import 'package:flutter_google_ml_kit/storageSystem/container.dart';
import 'package:flutter_google_ml_kit/storageSystem/tag.dart';
import 'package:vector_math/vector_math.dart';
import 'package:flutter_google_ml_kit/storageSystem/photo.dart';
import 'package:flutter_google_ml_kit/storageSystem/container_types.dart';

class Area implements Container {
  Area({
    required this.containerUID,
    required this.name,
    this.description,
    this.tags,
    this.children,
    this.photos,
  });

  @override
  String containerUID;

  @override
  String? name;

  @override
  String? description;

  @override
  List<Container>? children;

  @override
  ContainerType containerType = ContainerType.area;

  @override
  List<Photo>? photos;

  ///Null
  @override
  bool? isMarker;

  ///Null
  @override
  String? parentUID;

  ///Null
  @override
  String? barcodeUID;

  ///Null
  @override
  List<Tag>? tags;

  ///Null
  @override
  Vector3? vector3;
}
