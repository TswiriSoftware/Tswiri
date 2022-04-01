///This class contains all the app settings so Start By adding new settings here.
class Settings {
  Settings({
    required this.cameraPreset,
    required this.hapticFeedback,
    required this.defaultBarcodeSize,
    required this.googleImageLabeling,
    required this.googleImageLabelingConfidenceThreshold,
    required this.googleVisionProducts,
    required this.googleVisionProductsConfidenceThreshold,
    required this.inceptionV4,
    required this.inceptionV4PreferenceConfidenceThreshold,
  });

  ///Camera quiality preset.
  String cameraPreset;

  ///Hapticfeedback enabled/disabled.
  bool hapticFeedback;

  ///defualt barcode size.
  double defaultBarcodeSize;

  ///googleImageLabeling and confidence
  bool googleImageLabeling;
  double googleImageLabelingConfidenceThreshold;

  ///googleVisionProducts and confidence
  bool googleVisionProducts;
  double googleVisionProductsConfidenceThreshold;

  ///inceptionV4 and confidence
  bool inceptionV4;
  double inceptionV4PreferenceConfidenceThreshold;
}
