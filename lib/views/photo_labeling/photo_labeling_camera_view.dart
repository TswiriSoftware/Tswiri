import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sunbird_v2/globals/globals_export.dart';
import 'package:sunbird_v2/views/photo_labeling/photo_labeling_view.dart';

class PhotoLabelingCameraView extends StatefulWidget {
  const PhotoLabelingCameraView({Key? key}) : super(key: key);

  @override
  State<PhotoLabelingCameraView> createState() =>
      _PhotoLabelingCameraViewState();
}

class _PhotoLabelingCameraViewState extends State<PhotoLabelingCameraView> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool flash = false;

  @override
  void initState() {
    _controller = CameraController(
      cameras.first,
      cameraResolution,
      enableAudio: false,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();

    super.initState();
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
      appBar: _appBar(),
      body: _body(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _floatingActionButtons(),
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
    return FutureBuilder<void>(
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
    );
  }

  Widget _floatingActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _flash(),
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.6,
        ),
        _takePhoto(),
      ],
    );
  }

  Widget _takePhoto() {
    return FloatingActionButton(
      heroTag: 'photo',
      onPressed: () async {
        try {
          // Ensure that the camera is initialized.
          await _initializeControllerFuture;

          // Attempt to take a picture and then get the location
          // Get the photo's location.
          final image = await _controller.takePicture();
          _controller.setFlashMode(FlashMode.off);

          if (mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => PhotoLabelingView(image: image),
              ),
            );
          }
        } catch (e) {
          log(e.toString());
        }
      },
      child: const Icon(
        Icons.camera_sharp,
      ),
    );
  }

  Widget _flash() {
    return FloatingActionButton(
      backgroundColor: sunbirdOrange,
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
