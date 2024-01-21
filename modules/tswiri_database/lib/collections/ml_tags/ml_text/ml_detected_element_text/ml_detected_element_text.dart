import 'package:isar/isar.dart';
part 'ml_detected_element_text.g.dart';

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
@Name("MLDetectedElementText")
class MLDetectedElementText {
  ///DetectedElementTextID.
  Id id = Isar.autoIncrement;

  ///DetectedText.
  @Name("detectedText")
  @Index(unique: true)
  late String detectedText;

  ///TagTextID.
  @Name("tagTextID")
  late int? tagTextID;
}
