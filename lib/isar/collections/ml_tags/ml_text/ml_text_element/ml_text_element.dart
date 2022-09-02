import 'dart:math';
import 'dart:ui';

import 'package:isar/isar.dart';
part 'ml_text_element.g.dart';

@Collection()
@Name("MLTextElement")
class MLTextElement {
  int id = Isar.autoIncrement;

  ///PhotoID.
  @Name("photoID")
  late int photoID;

  ///lineID.
  @Name("lineID")
  late int lineID;

  ///LineIndex.
  @Name("lineIndex")
  late int lineIndex;

  ///DetectedElementTextID.
  @Name("detectedElementTextID")
  late int detectedElementTextID;

  ///CornerPoints.
  @Name("cornerPoints")
  @CornerPointConverter()
  late List<Point<int>> cornerPoints;

  ///UserFeedback.
  @Name("userFeedback")
  late bool? userFeedback;

  @override
  String toString() {
    return 'ID: $id, LineID: $lineID, LineIndex: $lineIndex, DetectedElementTextID: $detectedElementTextID, CornerPoints: $cornerPoints';
  }

  Rect getBoundingBox() {
    return Rect.fromPoints(
        Offset(cornerPoints[0].x.toDouble(), cornerPoints[0].y.toDouble()),
        Offset(cornerPoints[2].x.toDouble(), cornerPoints[2].y.toDouble()));
  }
}

class CornerPointConverter extends TypeConverter<List<Point<int>>, List<int>> {
  const CornerPointConverter(); // Converters need to have an empty const constructor

  @override
  List<Point<int>> fromIsar(List<int> object) {
    return [
      Point(
        object[0],
        object[1],
      ),
      Point(
        object[2],
        object[3],
      ),
      Point(
        object[4],
        object[5],
      ),
      Point(
        object[6],
        object[7],
      ),
    ];
  }

  @override
  List<int> toIsar(List<Point<int>> object) {
    return [
      object[0].x,
      object[0].y,
      object[1].x,
      object[1].y,
      object[2].x,
      object[2].y,
      object[3].x,
      object[3].y,
    ];
  }
}
