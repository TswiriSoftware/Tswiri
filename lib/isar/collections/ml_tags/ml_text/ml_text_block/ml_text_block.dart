import 'dart:math';
import 'dart:ui';
import 'package:sunbird/isar/isar_database.dart';
part 'ml_text_block.g.dart';

@Collection()
@Name("MLTextBlock")
class MLTextBlock {
  ///BlockID.
  int id = Isar.autoIncrement;

  ///RecognizedLanguages.
  @Name("recognizedLanguages")
  late List<String> recognizedLanguages;

  ///CornerPoints.
  @Name("cornerPoints")
  @CornerPointConverter()
  late List<Point<int>> cornerPoints;

  @override
  String toString() {
    return '\nID: $id, Languages: $recognizedLanguages, CornerPoints: $cornerPoints';
  }

  Rect getBoundingBox() {
    return Rect.fromPoints(
        Offset(cornerPoints[0].x.toDouble(), cornerPoints[0].y.toDouble()),
        Offset(cornerPoints[2].x.toDouble(), cornerPoints[2].y.toDouble()));
  }
}
