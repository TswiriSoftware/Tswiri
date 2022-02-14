import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/VisionDetectorViews/camera_view.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'painters/label_detector_painter.dart';

class ImageLabelView extends StatefulWidget {
  const ImageLabelView({Key? key}) : super(key: key);

  @override
  _ImageLabelViewState createState() => _ImageLabelViewState();
}

class _ImageLabelViewState extends State<ImageLabelView> {
  ImageLabeler imageLabeler = GoogleMlKit.vision.imageLabeler();
  bool isBusy = false;
  CustomPaint? customPaint;

  @override
  void dispose() {
    imageLabeler.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CameraView(
      color: Colors.orange,
      title: 'Image Labeler',
      customPaint: customPaint,
      onImage: (inputImage) {
        // comment this line if you want to use custom model
        processImageWithDefaultModel(inputImage);
        // uncomment this line if you want to use custom model
        //processImageWithRemoteModel(inputImage);
      },
    );
  }

  Future<void> processImageWithDefaultModel(InputImage inputImage) async {
    imageLabeler = GoogleMlKit.vision
        .imageLabeler(ImageLabelerOptions(confidenceThreshold: 0.5));
    processImage(inputImage);
  }

  // Add the tflite model in android/src/main/assets
  Future<void> processImageWithRemoteModel(InputImage inputImage) async {
    final options = CustomRemoteLabelerOption(
        confidenceThreshold: 0.1, modelName: 'bird-classifier');
    imageLabeler = GoogleMlKit.vision.imageLabeler(options);
    processImage(inputImage);
  }

  Future<void> processImage(InputImage inputImage) async {
    if (isBusy) return;
    isBusy = true;
    await Future.delayed(const Duration(milliseconds: 50));
    final labels = await imageLabeler.processImage(inputImage);
    final painter = LabelDetectorPainter(labels);
    customPaint = CustomPaint(painter: painter);
    isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
