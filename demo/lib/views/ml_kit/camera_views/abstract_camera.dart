import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

abstract class AbstractCamera<T extends StatefulWidget> extends State<T> {
  CustomPaint? get customPaint;
  CameraLensDirection? get initialCameraLensDirection;
  bool get enableZoom;

  Function(InputImage inputImage) get onImage;
  VoidCallback? get onCameraFeedReady;
  Function(CameraLensDirection direction)? get onCameraLensDirectionChanged;

  static List<CameraDescription> _cameras = [];
  CameraController? _controller;
  int _cameraIndex = -1;
  double _currentZoomLevel = 1.0;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;
  double _minAvailableExposureOffset = 0.0;
  double _maxAvailableExposureOffset = 0.0;
  double _currentExposureOffset = 0.0;
  bool _changingCameraLens = false;
  double _currentScale = 1.0;

  static const iconButtonHeight = 50.0;
  static const iconButtonWidth = 50.0;
  static const padding = 8.0;

  final _orientations = {
    DeviceOrientation.portraitUp: 0,
    DeviceOrientation.landscapeLeft: 90,
    DeviceOrientation.portraitDown: 180,
    DeviceOrientation.landscapeRight: 270,
  };

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void dispose() {
    _stopLiveFeed();
    super.dispose();
  }

  void _initialize() async {
    if (_cameras.isEmpty) {
      _cameras = await availableCameras();
    }
    for (var i = 0; i < _cameras.length; i++) {
      if (_cameras[i].lensDirection == initialCameraLensDirection) {
        _cameraIndex = i;
        break;
      }
    }
    if (_cameraIndex != -1) {
      _startLiveFeed();
    }
  }

  Future _stopLiveFeed() async {
    await _controller?.stopImageStream();
    await _controller?.dispose();
    _controller = null;
  }

  /// The live feed from the camera.
  Widget liveFeedBody() {
    if (_cameras.isEmpty) return Container();
    if (_controller == null) return Container();
    if (_controller?.value.isInitialized == false) return Container();

    return GestureDetector(
      onScaleStart: enableZoom ? _onScaleStart : null,
      onScaleUpdate:
          enableZoom ? (details) async => _onScaleUpdate(details) : null,
      child: Center(
        child: _changingCameraLens
            ? const Center(
                child: Text('Changing camera lens'),
              )
            : CameraPreview(
                _controller!,
                child: customPaint,
              ),
      ),
    );
  }

  /// A back button position at the top left of the screen.
  Widget backButton() {
    return Positioned(
      top: 40,
      left: 8,
      child: SizedBox(
        height: iconButtonHeight,
        width: iconButtonWidth,
        child: FloatingActionButton(
          heroTag: Object(),
          onPressed: () => Navigator.of(context).pop(),
          backgroundColor: Colors.black54,
          child: const Icon(
            Icons.arrow_back_ios_outlined,
            size: 20,
          ),
        ),
      ),
    );
  }

  /// An info button positioned next to the back button.
  Widget infoButton({
    String? title,
    required String infoText,
    Widget? infoIcon,
  }) {
    return Positioned(
      top: 40,
      left: 8 + iconButtonWidth + padding,
      child: SizedBox(
        height: iconButtonHeight,
        width: iconButtonWidth,
        child: FloatingActionButton(
          heroTag: Object(),
          onPressed: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Info'),
              content: Text(infoText),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.black54,
          child: infoIcon ??
              const Icon(
                Icons.info,
                size: 20,
              ),
        ),
      ),
    );
  }

  Widget actionButton(Widget widget) {
    return Positioned(
      bottom: padding,
      right: padding,
      child: widget,
    );
  }

  Widget exposureControl() {
    return Positioned(
      top: 40,
      right: 8,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 250,
        ),
        child: Column(children: [
          Container(
            width: 55,
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  '${_currentExposureOffset.toStringAsFixed(1)}x',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: RotatedBox(
              quarterTurns: 3,
              child: SizedBox(
                height: 30,
                child: Slider(
                  value: _currentExposureOffset,
                  min: _minAvailableExposureOffset,
                  max: _maxAvailableExposureOffset,
                  activeColor: Colors.white,
                  inactiveColor: Colors.white30,
                  onChanged: (value) async {
                    setState(() {
                      _currentExposureOffset = value;
                    });
                    await _controller?.setExposureOffset(value);
                  },
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }

  Widget zoomControl() {
    return Positioned(
      bottom: 16,
      left: 0,
      right: 0,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: 250,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Slider(
                  value: _currentZoomLevel,
                  min: _minAvailableZoom,
                  max: _maxAvailableZoom,
                  activeColor: Colors.white,
                  inactiveColor: Colors.white30,
                  onChanged: (value) async {
                    setState(() {
                      _currentZoomLevel = value;
                    });
                    await _controller?.setZoomLevel(value);
                  },
                ),
              ),
              Container(
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      '${_currentZoomLevel.toStringAsFixed(1)}x',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget switchLiveCameraToggle() {
    return Positioned(
      bottom: padding,
      left: padding,
      child: SizedBox(
        height: iconButtonHeight,
        width: iconButtonWidth,
        child: FloatingActionButton(
          heroTag: Object(),
          onPressed: _switchLiveCamera,
          backgroundColor: Colors.black54,
          child: Icon(
            Platform.isIOS
                ? Icons.flip_camera_ios_outlined
                : Icons.flip_camera_android_outlined,
            size: 25,
          ),
        ),
      ),
    );
  }

  void _onScaleStart(ScaleStartDetails details) {
    _currentScale = 1.0;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) async {
    final scaleChange = details.scale - _currentScale;

    final newZoomLevel = (_currentZoomLevel + (scaleChange / 100)).clamp(
      _minAvailableZoom,
      _maxAvailableZoom,
    );

    setState(() {
      _currentZoomLevel = newZoomLevel;
    });

    await _controller?.setZoomLevel(_currentZoomLevel);

    _currentScale = details.scale;
  }

  void _processCameraImage(CameraImage image) {
    final inputImage = _inputImageFromCameraImage(image);
    if (inputImage == null) return;
    onImage(inputImage);
  }

  Future _startLiveFeed() async {
    final camera = _cameras[_cameraIndex];
    _controller = CameraController(
      camera,
      // Set to ResolutionPreset.high. Do NOT set it to ResolutionPreset.max because for some phones does NOT work.
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21
          : ImageFormatGroup.bgra8888,
    );
    _controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _controller?.getMinZoomLevel().then((value) {
        _currentZoomLevel = value;
        _minAvailableZoom = value;
      });
      _controller?.getMaxZoomLevel().then((value) {
        _maxAvailableZoom = value;
      });
      _currentExposureOffset = 0.0;
      _controller?.getMinExposureOffset().then((value) {
        _minAvailableExposureOffset = value;
      });
      _controller?.getMaxExposureOffset().then((value) {
        _maxAvailableExposureOffset = value;
      });
      _controller?.startImageStream(_processCameraImage).then((value) {
        if (onCameraFeedReady != null) {
          onCameraFeedReady!();
        }
        if (onCameraLensDirectionChanged != null) {
          onCameraLensDirectionChanged!(camera.lensDirection);
        }
      });
      setState(() {});
    });
  }

  Future _switchLiveCamera() async {
    setState(() => _changingCameraLens = true);
    _cameraIndex = (_cameraIndex + 1) % _cameras.length;

    await _stopLiveFeed();
    await _startLiveFeed();
    setState(() => _changingCameraLens = false);
  }

  InputImage? _inputImageFromCameraImage(CameraImage image) {
    if (_controller == null) return null;

    // get image rotation
    // it is used in android to convert the InputImage from Dart to Java: https://github.com/flutter-ml/google_ml_kit_flutter/blob/master/packages/google_mlkit_commons/android/src/main/java/com/google_mlkit_commons/InputImageConverter.java
    // `rotation` is not used in iOS to convert the InputImage from Dart to Obj-C: https://github.com/flutter-ml/google_ml_kit_flutter/blob/master/packages/google_mlkit_commons/ios/Classes/MLKVisionImage%2BFlutterPlugin.m
    // in both platforms `rotation` and `camera.lensDirection` can be used to compensate `x` and `y` coordinates on a canvas: https://github.com/flutter-ml/google_ml_kit_flutter/blob/master/packages/example/lib/vision_detector_views/painters/coordinates_translator.dart
    final camera = _cameras[_cameraIndex];
    final sensorOrientation = camera.sensorOrientation;
    // print(
    //     'lensDirection: ${camera.lensDirection}, sensorOrientation: $sensorOrientation, ${_controller?.value.deviceOrientation} ${_controller?.value.lockedCaptureOrientation} ${_controller?.value.isCaptureOrientationLocked}');
    InputImageRotation? rotation;
    if (Platform.isIOS) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    } else if (Platform.isAndroid) {
      var rotationCompensation =
          _orientations[_controller!.value.deviceOrientation];
      if (rotationCompensation == null) return null;
      if (camera.lensDirection == CameraLensDirection.front) {
        // front-facing
        rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
      } else {
        // back-facing
        rotationCompensation =
            (sensorOrientation - rotationCompensation + 360) % 360;
      }
      rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
      // print('rotationCompensation: $rotationCompensation');
    }
    if (rotation == null) return null;
    // print('final rotation: $rotation');

    // get image format
    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    // validate format depending on platform
    // only supported formats:
    // * nv21 for Android
    // * bgra8888 for iOS
    if (format == null ||
        (Platform.isAndroid && format != InputImageFormat.nv21) ||
        (Platform.isIOS && format != InputImageFormat.bgra8888)) return null;

    // since format is constraint to nv21 or bgra8888, both only have one plane
    if (image.planes.length != 1) return null;
    final plane = image.planes.first;

    // compose InputImage using bytes
    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation, // used only in Android
        format: format, // used only in iOS
        bytesPerRow: plane.bytesPerRow, // used only in iOS
      ),
    );
  }
}
