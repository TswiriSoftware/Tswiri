import 'dart:developer';
import 'dart:io';
import 'package:flutter_google_ml_kit/databaseAdapters/barcodePhotos/barcode_photo_entry.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:path_provider/path_provider.dart';

import '../../globalValues/global_hive_databases.dart';
import '../../objects/image_object_data.dart';
import '../barcodeControlPanel/barcode_control_panel.dart';
import 'painter/object_detector_painter.dart';

//TODO: Implement barcode Scanner before this screen so the user can scan the barcode and then take a photo of what is inside the box.

///Displays the Photo and objects detected
class ObjectDetectorProcessingView extends StatefulWidget {
  const ObjectDetectorProcessingView(
      {Key? key, required this.imagePath, required this.barcodeID})
      : super(key: key);
  final String imagePath;
  final int barcodeID;
  @override
  _ObjectDetectorProcessingView createState() =>
      _ObjectDetectorProcessingView();
}

class _ObjectDetectorProcessingView
    extends State<ObjectDetectorProcessingView> {
  ImageLabeler imageLabeler = GoogleMlKit.vision.imageLabeler();
  late ObjectDetector objectDetector;
  late String imagePath;
  //LocalModel model = LocalModel('object_detector.tflite');

  @override
  void initState() {
    //Image Path.
    imagePath = widget.imagePath;

    //TODO: figure this out
    //Object Detector Config.
    // objectDetector = GoogleMlKit.vision.objectDetector(
    //     CustomObjectDetectorOptions(model,
    //         classifyObjects: true, trackMutipleObjects: true));

    //Object Detector Config.
    objectDetector = GoogleMlKit.vision.objectDetector(ObjectDetectorOptions(
        classifyObjects: true, trackMutipleObjects: true));

    //Image labeler Config.
    imageLabeler = GoogleMlKit.vision
        .imageLabeler(ImageLabelerOptions(confidenceThreshold: 0.5));

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
                  Navigator.pop(context);
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
            FutureBuilder<ImageObjectData>(
                future: processImage(imagePath),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data!.detectedObjects.isNotEmpty &&
                      snapshot.data != null) {
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

  Future<ImageObjectData> processImage(String imagePath) async {
    //Get Image File.
    File imageFile = File(imagePath);

    //Get the Storage Path if it does not exist create it.
    String storagePath = await getStorageDirectory();
    if (!await Directory('$storagePath/sunbird').exists()) {
      Directory('$storagePath/sunbird').create();
    }

    //Create the photo file path.
    String photoFilePath = '$storagePath/sunbird/${widget.barcodeID}.jpg';

    //Copy the image to it. (For now only allowing 1 image per Barcode)
    if (await File(photoFilePath).exists()) {
      File(photoFilePath).delete();
      await imageFile.copy(photoFilePath);
    } else {
      await imageFile.copy(photoFilePath);
    }

    //Create InputImage.
    InputImage inputImage = InputImage.fromFile(imageFile);

    List<String> photoTags = [];

    //Image Processing:
    ///Objects
    final objects = await objectDetector.processImage(inputImage);

    for (DetectedObject object in objects) {
      log('Object label: ' + object.getLabels().toList().toString());
      List<Label> objectLabels = object.getLabels();
      for (Label objectLabel in objectLabels) {
        photoTags.add(objectLabel.getText());
      }
    }

    ///Labels
    final labels = await imageLabeler.processImage(inputImage);
    for (ImageLabel label in labels) {
      log('Image Label: ' + label.label);
      photoTags.add(label.label);
    }

    //Decode Image for properties
    var decodedImage = await decodeImageFromList(imageFile.readAsBytesSync());

    //Get Image Size
    Size imageSize =
        Size(decodedImage.height.toDouble(), decodedImage.width.toDouble());

    //Create the object that contains all data from the object Detector and Image Labeler.
    ImageObjectData processedResult = ImageObjectData(
        detectedObjects: objects,
        detectedLabels: labels,
        imageRotation: InputImageRotation.Rotation_90deg,
        size: imageSize);

    BarcodePhotoEntry barcodePhotoEntry = BarcodePhotoEntry(
        barcodeID: widget.barcodeID,
        photoPath: photoFilePath,
        photoTags: photoTags);

    Box<BarcodePhotoEntry> barcodePhotoEntries =
        await Hive.openBox(barcodePhotosBoxName);

    barcodePhotoEntries.put(widget.barcodeID, barcodePhotoEntry);

    log(barcodePhotoEntries.values.toString());

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
