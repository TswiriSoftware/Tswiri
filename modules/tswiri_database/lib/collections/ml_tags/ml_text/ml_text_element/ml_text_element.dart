import 'dart:ui';

import 'package:isar/isar.dart';
import 'package:tswiri_database/collections/ml_tags/ml_text/ml_text_block/ml_text_block.dart';
part 'ml_text_element.g.dart';

///TODO: finish commenting.

///Stores details about a container (Created by user).
///
///  - ```containerUID``` Unique identifier.
///  - ```containerTypeID``` Type of container [ContainerType].
///  - ```name``` Name of the container.
///  - ```description``` Description of the container.
///  - ```barcodeUID``` Barcode linked to this container.
///
@Collection()
@Name("MLTextElement")
class MLTextElement {
  Id id = Isar.autoIncrement;

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
  late CornerPoints cornerPoints;

  ///UserFeedback.
  @Name("userFeedback")
  late bool? userFeedback;

  @override
  String toString() {
    return 'ID: $id, LineID: $lineID, LineIndex: $lineIndex, DetectedElementTextID: $detectedElementTextID, CornerPoints: $cornerPoints';
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
