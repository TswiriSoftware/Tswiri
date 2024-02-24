import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:tswiri/views/ml_kit/camera_views/abstract_camera.dart';

class BarcodeSelectorCamera extends StatefulWidget {
  final CustomPaint? customPaint;
  final CameraLensDirection initialCameraLensDirection;
  final bool enableZoom;
  final Function(InputImage inputImage) onImage;
  final VoidCallback? onCameraFeedReady;
  final VoidCallback? onDetectorViewModeChanged;
  final Function(CameraLensDirection direction)? onCameraLensDirectionChanged;
  final Widget? floatingActionButton;

  const BarcodeSelectorCamera({
    super.key,
    required this.customPaint,
    required this.onImage,
    this.floatingActionButton,
    this.onCameraFeedReady,
    this.onDetectorViewModeChanged,
    this.onCameraLensDirectionChanged,
    this.initialCameraLensDirection = CameraLensDirection.back,
    this.enableZoom = true,
  });

  @override
  AbstractCamera<BarcodeSelectorCamera> createState() =>
      _BarcodeSelectorCameraState();
}

class _BarcodeSelectorCameraState
    extends AbstractCamera<BarcodeSelectorCamera> {
  @override
  CustomPaint? get customPaint => widget.customPaint;

  @override
  bool get enableZoom => widget.enableZoom;

  @override
  CameraLensDirection? get initialCameraLensDirection {
    return widget.initialCameraLensDirection;
  }

  @override
  VoidCallback? get onCameraFeedReady {
    return widget.onCameraFeedReady;
  }

  @override
  Function(CameraLensDirection direction)? get onCameraLensDirectionChanged {
    return widget.onCameraLensDirectionChanged;
  }

  @override
  Function(InputImage inputImage) get onImage => widget.onImage;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        fit: StackFit.expand,
        children: [
          liveFeedBody(),
          backButton(),
          infoButton(
            title: 'Barcode Selector',
            infoText:
                'Point the camera at a barcode and press the select button.',
          ),
          if (widget.floatingActionButton != null)
            actionButton(widget.floatingActionButton!),
          switchLiveCameraToggle(),
          exposureControl(),
        ],
      ),
    );
  }
}
