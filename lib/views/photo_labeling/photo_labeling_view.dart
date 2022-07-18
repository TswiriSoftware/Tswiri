import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class PhotoLabelingView extends StatefulWidget {
  const PhotoLabelingView({
    Key? key,
    required this.image,
  }) : super(key: key);
  final XFile image;

  @override
  State<PhotoLabelingView> createState() => _PhotoLabelingViewState();
}

class _PhotoLabelingViewState extends State<PhotoLabelingView> {
  //Text Recognizer.
  final _textRecognizer = TextRecognizer();

  //Image Labeler.
  final ImageLabeler _imageLabeler = ImageLabeler(
    options: ImageLabelerOptions(confidenceThreshold: 0.75),
  );

  //Object Detector.
  final _objectDetector = ObjectDetector(
    options: ObjectDetectorOptions(
      mode: DetectionMode.single,
      classifyObjects: true,
      multipleObjects: false,
    ),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textRecognizer.close();
    _imageLabeler.close();
    _objectDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'Photo Labeling',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      centerTitle: true,
    );
  }

  Widget _body() {
    return Column(
      children: [],
    );
  }
}
