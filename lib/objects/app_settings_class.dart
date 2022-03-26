///This class contains all the app settings so Start By adding new settings here.
class Settings {
  Settings(
      {required this.cameraPreset,
      required this.hapticFeedback,
      required this.defaultBarcodeSize});
  String cameraPreset;
  bool hapticFeedback;
  double defaultBarcodeSize;
}
