// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import '../../../main.dart';
import '../object_detector_image_processing.dart';

///This displays the camera view and allows for taking photos.
///TODO: allow the user to take Multiple Photos for labeling.
class ObjectDetectorCameraView extends StatefulWidget {
  const ObjectDetectorCameraView(
      {Key? key,
      required this.title,
      required this.customPaint,
      required this.onImage,
      required this.color,
      this.initialDirection = CameraLensDirection.back})
      : super(key: key);

  final String title;
  final CustomPaint? customPaint;
  final Function(InputImage inputImage) onImage;
  final CameraLensDirection initialDirection;
  final Color color;

  @override
  _ObjectDetectorCameraViewState createState() =>
      _ObjectDetectorCameraViewState();
}

class _ObjectDetectorCameraViewState extends State<ObjectDetectorCameraView> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    _controller = CameraController(
      cameras.first,
      ResolutionPreset.high,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: widget.color,
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return Stack(
              fit: StackFit.expand,
              children: [CameraPreview(_controller)],
            );
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: SizedBox(
        width: 60,
        height: 60,
        child: FloatingActionButton(
          backgroundColor: Colors.orange,
          heroTag: null,
          onPressed: () async {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Attempt to take a picture and then get the location
            // where the image file is saved.
            final image = await _controller.takePicture();

            //Pass the image to the processing screen :D
            Navigator.pop(context);
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ObjectDetectorProcessingView(
                  imagePath: image.path,
                ),
              ),
            );
          },
          child: const Icon(
            Icons.photo_camera,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
