import 'package:isar/isar.dart';
part 'ml_detected_element_text.g.dart';

@Collection()
@Name("MLDetectedElementText")
class MLDetectedElementText {
  ///DetectedElementTextID.
  int id = Isar.autoIncrement;

  ///DetectedText.
  @Name("detectedText")
  @Index(unique: true)
  late String detectedText;

  ///TagTextID.
  @Name("tagTextID")
  late int? tagTextID;
}
