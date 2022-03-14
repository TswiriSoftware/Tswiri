import 'package:flutter_google_ml_kit/storageSystem/photo.dart';
import 'package:flutter_google_ml_kit/storageSystem/tag.dart';
import 'package:vector_math/vector_math.dart';

import 'container_types.dart';

abstract class Container {
  Container({
    required this.containerUID,
    required this.containerType,
  });

  ///Containers UID also used as the PK. [String]
  String containerUID;

  ///The type of container. [ContainerType]
  ContainerType containerType;

  ///User defined name for this container. [String]
  String? name;

  ///User defined description for this container. [String]
  String? description;

  ///A list of tags related to this container. (Userdefined)
  List<Tag>? tags;

  ///The parent container's UID. [String]
  String? parentUID;

  ///States if the container is being used as a marker. [bool]
  bool? isMarker;

  ///Barcode linked to this container (if it has one). [String]
  String? barcodeUID;

  ///The positional data of the barcode. [Vector3]
  Vector3? vector3;

  ///List of this containers children. [Container]
  List<Container>? children;

  ///All photos related to this container.[Photo]
  List<Photo>? photos;
}
