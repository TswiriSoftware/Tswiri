import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import '../../main.dart';
import 'painter/object_detector_painter.dart';

///Displays the cameraView of the object Dectector.
class ObjectDetectorProcessingView extends StatefulWidget {
  const ObjectDetectorProcessingView({Key? key, required this.imagePath})
      : super(key: key);
  final String imagePath;
  @override
  _ObjectDetectorProcessingView createState() =>
      _ObjectDetectorProcessingView();
}

class _ObjectDetectorProcessingView
    extends State<ObjectDetectorProcessingView> {
  ImageLabeler imageLabeler = GoogleMlKit.vision.imageLabeler();
  late ObjectDetector objectDetector;
  late String imagePath;
  @override
  void initState() {
    //Image Path.
    imagePath = widget.imagePath;

    //TODO: figure this out
    //Object Detector Config.
    // objectDetector = GoogleMlKit.vision.objectDetector(ObjectDetectorOptions(
    //     classifyObjects: true, trackMutipleObjects: true));

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
                onPressed: () {},
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
    //Get Image File
    File imageFile = File(imagePath);

    //Create InputImage
    InputImage inputImage = InputImage.fromFile(imageFile);

    //Image Processing:
    //Objects
    final objects = await objectDetector.processImage(inputImage);

    for (DetectedObject object in objects) {
      log('Object label: ' + object.getLabels().toList().toString());
    }

    //Labels
    final labels = await imageLabeler.processImage(inputImage);
    for (ImageLabel label in labels) {
      log('Image Label: ' + label.label);
    }

    //Decode Image for properties
    var decodedImage = await decodeImageFromList(imageFile.readAsBytesSync());

    //Get Image Size
    Size imageSize =
        Size(decodedImage.height.toDouble(), decodedImage.width.toDouble());

    //Create the object that contains all data.
    ImageObjectData processedResult = ImageObjectData(
        detectedObjects: objects,
        detectedLabels: labels,
        imageRotation: InputImageRotation.Rotation_90deg,
        size: imageSize);

    return processedResult;
  }
}

///This object will be passed to the painter
///It contains Lists of objects detected etc...
///It also contains the Image configuration.
class ImageObjectData {
  ImageObjectData({
    required this.detectedObjects,
    required this.detectedLabels,
    required this.imageRotation,
    required this.size,
  });

  ///List of detected Objects.
  final List<DetectedObject> detectedObjects;

  ///List of detected labels.
  final List<ImageLabel> detectedLabels;

  ///Image rotation.
  final InputImageRotation imageRotation;
  //Image Size.
  final Size size;

  @override
  String toString() {
    return 'List of detected Objects: $detectedObjects,\n ImageRotation: $imageRotation,\n ImageSize: $size ';
  }
}
