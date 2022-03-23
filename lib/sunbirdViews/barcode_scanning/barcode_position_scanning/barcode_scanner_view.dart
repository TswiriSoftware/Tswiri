// import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
// import 'package:flutter_google_ml_kit/objects/accelerometer_data.dart';
// import 'package:flutter_google_ml_kit/objects/raw_on_image_barcode_data.dart';
// import 'package:flutter_google_ml_kit/sunbirdViews/barcode_scanning/camera_views/barcode_scan_camera_view.dart';
// import 'package:flutter_google_ml_kit/sunbirdViews/barcode_scanning/painters/barcode_painter.dart';
// import 'package:vector_math/vector_math.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_google_ml_kit/sunbirdViews/barcode_scanning/barcode_position_scanning/barcode_scanner_data_processing_view.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
// import 'package:sensors_plus/sensors_plus.dart';
// import 'dart:isolate';

// class BarcodeScannerView extends StatefulWidget {
//   const BarcodeScannerView({Key? key, required this.shelfUID})
//       : super(key: key);

//   final int shelfUID;

//   @override
//   _BarcodeScannerViewState createState() => _BarcodeScannerViewState();
// }

// class _BarcodeScannerViewState extends State<BarcodeScannerView> {
//   BarcodeScanner barcodeScanner =
//       GoogleMlKit.vision.barcodeScanner([BarcodeFormat.qrCode]);

//   List<RawOnImageBarcodeData> allRawOnImageBarcodeData = [];
//   bool isBusy = false;
//   CustomPaint? customPaint;

//   Vector3 accelerometerEvent = Vector3(0, 0, 0);
//   Vector3 userAccelerometerEvent = Vector3(0, 0, 0);

//   //Isolate
//   late Isolate imageProcessorIsolate;
//   late ReceivePort mainReceivePort;
//   late SendPort isolateReceivePort;
//   bool hasSentImageConfig = false;

//   @override
//   void initState() {
//     WidgetsFlutterBinding.ensureInitialized();

//     //Listen to accelerometer events.
//     accelerometerEvents.listen((AccelerometerEvent event) {
//       accelerometerEvent = Vector3(event.x, event.y, event.z);
//     });
//     userAccelerometerEvents.listen((UserAccelerometerEvent event) {
//       userAccelerometerEvent = Vector3(event.x, event.y, event.z);
//     });

//     super.initState();
//   }

//   @override
//   void dispose() {
//     barcodeScanner.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         floatingActionButton: FloatingActionButton(
//           heroTag: null,
//           onPressed: () {
//             Navigator.pop(context);
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => BarcodeScannerDataProcessingView(
//                           allRawOnImageBarcodeData: allRawOnImageBarcodeData,
//                           shelfUID: widget.shelfUID,
//                         )));
//           },
//           child: const Icon(Icons.check_circle_outline_rounded),
//         ),
//         body: BarcodeScannerCameraView(
//           color: brightOrange,
//           title: 'Box Scanner',
//           customPaint: customPaint,
//           onImage: (inputImage) {
//             processImage(inputImage);
//           },
//         ));
//   }

//   // @override
//   Future<void> processImage(InputImage inputImage) async {
//     // Run all of this lovely code in an isolate. :D
//     if (isBusy) return;
//     isBusy = true;

//     final List<Barcode> barcodes =
//         await barcodeScanner.processImage(inputImage);

//     if (inputImage.inputImageData?.size != null &&
//         inputImage.inputImageData?.imageRotation != null) {
//       //Dont bother if we haven't detected more than one barcode on a image.
//       if (barcodes.length >= 2) {
//         ///Captures a list of barcodes and accelerometerData for a a single image frame.
//         allRawOnImageBarcodeData.add(RawOnImageBarcodeData(
//             barcodes: barcodes,
//             timestamp: DateTime.now().millisecondsSinceEpoch,
//             accelerometerData: getAccelerometerData()));
//       }
//       //Paint square on screen around barcode.
//       final painter = BarcodePainter(barcodes, inputImage.inputImageData!.size,
//           inputImage.inputImageData!.imageRotation);

//       customPaint = CustomPaint(painter: painter);
//     } else {
//       customPaint = null;
//     }
//     isBusy = false;
//     if (mounted) {
//       setState(() {});
//     }
//   }

//   ///This stores the AccelerometerEvent and UserAccelerometerEvent at an instant.
//   AccelerometerData getAccelerometerData() {
//     return AccelerometerData(
//         accelerometerEvent: accelerometerEvent,
//         userAccelerometerEvent: userAccelerometerEvent);
//   }
// }
