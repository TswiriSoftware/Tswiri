import 'package:camera/camera.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Camera Settings
List<CameraDescription> cameras = [];
ResolutionPreset cameraResolution = ResolutionPreset.high;

///Default Barcode Size.
double defaultBarcodeSize = 80;
String defaultBarcodeSizePref = 'defaultBarcodeSize';

///Vibration.
bool vibrate = true;
String vibratePref = 'vibrate';

//Image Labeling
bool imageLabeling = true;
String imageLabelingPref = 'imageLabeling';
double imageLabelingConfidence = 0.5;
String imageLabelingConfidencePref = 'imageLabelingConfidence';

//Object Detection.
bool objectDetection = true;
String objectDetectionPref = 'objectDetection';
double objectDetectionConfidence = 0.5;
String objectDetectionConfidencePref = 'objectDetectionConfidence';

//Text Detection.
bool textDetection = true;
String textDetectionPref = 'textDetection';

///Barcode Filters.
List<String> barcodeFilters = ['Assigned', 'Unassigned'];

//Camera focal length
double focalLength = 1;
String focalLengthPref = 'focalLength';

//Color Mode
bool colorModeEnabled = false;
String colorModeEnabledPref = 'colorModeEnabled';

//Isar version
int isarVersion = 1;

void loadAppSettings() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  //Default barcode size.
  defaultBarcodeSize =
      prefs.getDouble(defaultBarcodeSizePref) ?? defaultBarcodeSize;

  //Vibration.
  vibrate = prefs.getBool(vibratePref) ?? true;

  //Image Labeling.
  imageLabeling = prefs.getBool(imageLabelingPref) ?? true;
  imageLabelingConfidence = prefs.getDouble(imageLabelingConfidencePref) ?? 0.5;

  //Object Detection.
  objectDetection = prefs.getBool(objectDetectionPref) ?? true;
  objectDetectionConfidence =
      prefs.getDouble(objectDetectionConfidencePref) ?? 0.5;

  //Text Detection.
  textDetection = prefs.getBool(textDetectionPref) ?? true;

  //Focal Length
  focalLength = prefs.getDouble(focalLengthPref) ?? 1.0;

  //Color Mode
  colorModeEnabled = prefs.getBool(colorModeEnabledPref) ?? false;
}
