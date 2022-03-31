import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/ml_tag/ml_tag.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../objects/image_data.dart';
import 'painter/object_detector_painter.dart';

///Displays the Photo and objects detected
class ObjectDetectorProcessingView extends StatefulWidget {
  const ObjectDetectorProcessingView({Key? key, required this.imagePath
      //required this.barcodeID,
      })
      : super(key: key);
  final String imagePath;

  //final String barcodeID;
  @override
  _ObjectDetectorProcessingView createState() =>
      _ObjectDetectorProcessingView();
}

class _ObjectDetectorProcessingView
    extends State<ObjectDetectorProcessingView> {
  //Object detector config
  ObjectDetector objectDetector = GoogleMlKit.vision.objectDetector(
      ObjectDetectorOptions(classifyObjects: true, trackMutipleObjects: true));

  //Image labeler Config.
  ImageLabeler imageLabeler = GoogleMlKit.vision
      .imageLabeler(ImageLabelerOptions(confidenceThreshold: 0.6));

  //Text Detector
  TextDetector textDetector = GoogleMlKit.vision.textDetector();

  late String imagePath;
  //LocalModel model = LocalModel('object_detector.tflite');

  PhotoData? result;

  @override
  void initState() {
    //Image Path.
    imagePath = widget.imagePath;

    // File customModelFile = File('assets/custom_model.tflite');
    // log(customModelFile.exists().toString());

    //TODO: figure out custom .tflite

    //LocalModel customModel = LocalModel(modelPath)

    // customObjectDetector = GoogleMlKit.vision
    //     .objectDetector(CustomObjectDetectorOptions(LocalModel(modelPath)));

    //Object Detector Config.
    // objectDetector = GoogleMlKit.vision.objectDetector(
    //     CustomObjectDetectorOptions(model,
    //         classifyObjects: true, trackMutipleObjects: true));

    super.initState();
  }

  bool isBusy = false;
  CustomPaint? customPaint;

  @override
  void dispose() {
    objectDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                backgroundColor: Colors.orange,
                heroTag: null,
                onPressed: () {
                  Navigator.pop(context, result);
                },
                child: const Icon(Icons.check_circle_outline_rounded),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Text('Processing Image'),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.file(
              File(imagePath),
              alignment: Alignment.topCenter,
            ),
            FutureBuilder<ImageData>(
                future: processImage(imagePath),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData && snapshot.data != null) {
                    return CustomPaint(
                      painter:
                          ObjectDetectorPainter(objectData: snapshot.data!),
                    );
                  }
                  return const Center(child: Text('No Objects Detected'));
                }),
          ],
        ));
  }

  Future<ImageData> processImage(String imagePath) async {
    //Get Image File.
    File imageFile = File(imagePath);
    String fileExtention = imageFile.path.split('.').last;
    String fileName = '${DateTime.now().millisecondsSinceEpoch}';

    //Get the Storage Path if it does not exist create it.
    String storagePath = await getStorageDirectory();
    if (!await Directory('$storagePath/sunbird').exists()) {
      Directory('$storagePath/sunbird').create();
    }

    //Create the photo file path.
    String photoFilePath = '$storagePath/sunbird/$fileName.' + fileExtention;
    //log(photoFilePath);

    await imageFile.copy(photoFilePath);

    //Create InputImage.
    InputImage inputImage = InputImage.fromFile(imageFile);

    List<String> photoTags = [];

    //Image Processing:

    ///Objects
    final objects = await objectDetector.processImage(inputImage);
    for (DetectedObject object in objects) {
      //log('Object label: ' + object.getLabels().toList().toString());
      List<Label> objectLabels = object.getLabels();
      for (Label objectLabel in objectLabels) {
        photoTags.add(objectLabel.getText());
      }
    }

    ///Labels
    final labels = await imageLabeler.processImage(inputImage);
    for (ImageLabel label in labels) {
      //log('Image Label: ' + label.label);
      photoTags.add(label.label);
    }

    ///Text
    final RecognisedText recognisedText =
        await textDetector.processImage(inputImage);
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        if (line.text.length >= 3) {
          //photoTags.add(line.text.toLowerCase());
        }
      }
    }

    //Decode Image for properties
    var decodedImage = await decodeImageFromList(imageFile.readAsBytesSync());

    //Get Image Size
    Size imageSize =
        Size(decodedImage.height.toDouble(), decodedImage.width.toDouble());

    //Create the object that contains all data from the object Detector and Image Labeler.
    ImageData processedResult = ImageData(
        detectedObjects: objects,
        detectedLabels: labels,
        detectedText: recognisedText,
        imageRotation: InputImageRotation.Rotation_90deg,
        size: imageSize);

    PhotoData photoData =
        PhotoData(photoPath: photoFilePath, photoTags: photoTags);

    result = photoData;

    List<MlTag> newMlTags = [];
    for (String mlTag in photoData.photoTags) {
      if (isarDatabase!.mlTags.filter().tagMatches(mlTag).findFirstSync() ==
          null) {
        //Create new ml tag
        MlTag newMlTag = MlTag()..tag = mlTag;
        newMlTags.add(newMlTag);
      }
    }
    //Write new ml tags.
    isarDatabase!.writeTxnSync(
      (isar) => isar.mlTags.putAllSync(newMlTags),
    );

    //log(processedResult.toString());

    Map<String, List<String>> currentPhotoDataMap = {};
    currentPhotoDataMap.putIfAbsent(photoFilePath, () => photoTags);

    return processedResult;
  }
}

Future<String> getStorageDirectory() async {
  if (Platform.isAndroid) {
    return (await getExternalStorageDirectory())!.path;
  } else {
    return (await getApplicationDocumentsDirectory()).path;
  }
}

class PhotoData {
  PhotoData({
    required this.photoPath,
    required this.photoTags,
  });

  final List<String> photoTags;
  final String photoPath;
}
