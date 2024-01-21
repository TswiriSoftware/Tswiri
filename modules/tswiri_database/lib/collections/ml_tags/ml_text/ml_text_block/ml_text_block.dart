import 'dart:math';
import 'dart:ui';
import 'package:isar/isar.dart';

part 'ml_text_block.g.dart';

///Stores details about a container (Created by user).
///
///  - ```containerUID``` Unique identifier.
///  - ```containerTypeID``` Type of container [ContainerType].
///  - ```name``` Name of the container.
///  - ```description``` Description of the container.
///  - ```barcodeUID``` Barcode linked to this container.
///
@Collection()
@Name("MLTextBlock")
class MLTextBlock {
  ///BlockID.
  Id id = Isar.autoIncrement;

  ///RecognizedLanguages.
  @Name("recognizedLanguages")
  late List<String> recognizedLanguages;

  ///CornerPoints.
  @Name("cornerPoints")
  late CornerPoints cornerPoints;

  @override
  String toString() {
    return '\nID: $id, Languages: $recognizedLanguages, CornerPoints: $cornerPoints';
  }

  Rect getBoundingBox() {
    return Rect.fromPoints(
      Offset(
        cornerPoints.topLeftPoint.x.toDouble(),
        cornerPoints.topLeftPoint.y.toDouble(),
      ),
      Offset(
        cornerPoints.bottomRightPoint.x.toDouble(),
        cornerPoints.bottomRightPoint.y.toDouble(),
      ),
    );
  }
}

@embedded
class CornerPoints {
  List<int>? topLeft;
  List<int>? topRight;
  List<int>? bottomLeft;
  List<int>? bottomRight;

  @ignore
  Point<int> get topLeftPoint => Point<int>(
        topLeft![0],
        topLeft![1],
      );

  @ignore
  Point<int> get topRightPoint => Point<int>(
        topRight![0],
        topRight![1],
      );

  @ignore
  Point<int> get bottomLeftPoint => Point<int>(
        bottomLeft![0],
        bottomLeft![1],
      );

  @ignore
  Point<int> get bottomRightPoint => Point<int>(
        bottomRight![0],
        bottomRight![1],
      );

  CornerPoints({
    this.topLeft,
    this.topRight,
    this.bottomLeft,
    this.bottomRight,
  });

  @override
  String toString() {
    return 'TopLeft: $topLeftPoint, TopRight: $topRight, BottomLeft: $bottomLeft, BottomRight: $bottomRight';
  }
}
