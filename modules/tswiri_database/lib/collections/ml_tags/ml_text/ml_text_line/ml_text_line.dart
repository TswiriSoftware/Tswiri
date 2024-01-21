import 'package:isar/isar.dart';
import 'package:tswiri_database/collections/ml_tags/ml_text/ml_text_block/ml_text_block.dart';
part 'ml_text_line.g.dart';

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
@Name("MLTextLine")
class MLTextLine {
  ///LineID.
  Id id = Isar.autoIncrement;

  ///BlockID.
  @Name("blockID")
  late int blockID;

  ///blockIndex.
  @Name("blockIndex")
  late int blockIndex;

  ///RecognizedLanguages.
  @Name("recognizedLanguages")
  late List<String> recognizedLanguages;

  ///CornerPoints.
  @Name("cornerPoints")
  late CornerPoints cornerPoints;

  @override
  String toString() {
    return 'ID: $id, BlockID: $blockID, BlockIndex: $blockIndex, Languages: $recognizedLanguages, CornerPoints: $cornerPoints';
  }
}
