import 'dart:math';
import 'package:sunbird_2/isar/isar_database.dart';
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
}
