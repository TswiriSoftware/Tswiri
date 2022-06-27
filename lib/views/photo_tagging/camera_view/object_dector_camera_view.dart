// ignore_for_file: curly_braces_in_flow_control_structures, library_private_types_in_public_api, use_build_context_synchronously

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/objects/photo_tagging/photo_data.dart';
import 'package:flutter_google_ml_kit/views/photo_tagging/object_detector_image_processing.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import '../../settings/app_settings.dart';
import '../../../main.dart';
//import '../object_detector_image_processing.dart';

///This displays the camera view and allows for taking photos.
class ObjectDetectorCameraView extends StatefulWidget {
  const ObjectDetectorCameraView(
      {Key? key,
      required this.title,
      required this.customPaint,
      required this.onImage,
      required this.color,
      required this.containerUID,
      this.initialDirection = CameraLensDirection.back})
      : super(key: key);

  final String title;
  final CustomPaint? customPaint;
  final Function(InputImage inputImage) onImage;
  final CameraLensDirection initialDirection;
  final Color color;
  final String containerUID;

  @override
  _ObjectDetectorCameraViewState createState() =>
      _ObjectDetectorCameraViewState();
}

class _ObjectDetectorCameraViewState extends State<ObjectDetectorCameraView> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool flash = false;

  @override
  void initState() {
    super.initState();

    _controller = CameraController(
      cameras.first,
      cameraResolution ?? ResolutionPreset.high,
      enableAudio: false,
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
        centerTitle: true,
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        backgroundColor: widget.color,
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            _controller.setFlashMode(FlashMode.off);
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _floatingActionButton(),
            SizedBox(
              width: 60,
              height: 60,
              child: FloatingActionButton(
                backgroundColor: widget.color,
                heroTag: null,
                onPressed: () async {
                  try {
                    // Ensure that the camera is initialized.
                    await _initializeControllerFuture;

                    // Attempt to take a picture and then get the location
                    // Get the photo's location.
                    final image = await _controller.takePicture();
                    _controller.setFlashMode(FlashMode.off);

                    PhotoData? result = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ObjectDetectorProcessingView(
                          imagePath: image.path,
                          customColor: widget.color,
                          containerUID: widget.containerUID,
                        ),
                      ),
                    );

                    Navigator.pop(context, result);
                  } catch (e) {
                    // If an error occurs, log the error to the console.
                    //print(e);
                  }
                },
                child: const Icon(
                  Icons.photo_camera,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _floatingActionButton() {
    //if (cameras.length == 1) return null;
    return FloatingActionButton(
      backgroundColor: widget.color,
      heroTag: 'flash',
      child: Icon(
        Platform.isIOS
            ? Icons.flip_camera_ios_outlined
            : Icons.flash_on_rounded,
      ),
      onPressed: () {
        if (flash == true) {
          _controller.setFlashMode(FlashMode.off);
          flash = false;
        } else {
          flash = true;
          _controller.setFlashMode(FlashMode.torch);
        }
      },
    );
  }
}
