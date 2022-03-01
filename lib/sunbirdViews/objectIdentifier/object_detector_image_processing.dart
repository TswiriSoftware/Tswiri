import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import '../../objects/image_object_data.dart';
import 'painter/object_detector_painter.dart';

//TODO: Implement barcode Scanner before this screen so the user can scan the barcode and then take a photo of what is inside the box.

///Displays the Photo and objects detected
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

    //Create the object that contains all data from the object Detector and Image Labeler.
    ImageObjectData processedResult = ImageObjectData(
        detectedObjects: objects,
        detectedLabels: labels,
        imageRotation: InputImageRotation.Rotation_90deg,
        size: imageSize);

    //TODO: The next screen the user will confirm the tags that are aplicable and the photo will be linked to the scanned barcode.

    return processedResult;
  }
}
