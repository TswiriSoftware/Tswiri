///This class contains all the app settings so Start By adding new settings here.
class Settings {
  Settings(
      {required this.cameraPreset,
      required this.hapticFeedback,
      required this.defaultBarcodeDiagonalLength});
  String cameraPreset;
  bool hapticFeedback;
  double defaultBarcodeDiagonalLength;
}
