import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/VisionDetectorViews/camera_view.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter_google_ml_kit/objects/real_barcode_position.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcodeNavigation/painter/barcode_navigation_painter.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:vector_math/vector_math.dart';
import '../../objects/real_inter_barcode_offset.dart';

class BarcodeCameraNavigatorView extends StatefulWidget {
  final String qrcodeID;
  const BarcodeCameraNavigatorView({Key? key, required this.qrcodeID})
      : super(key: key);

  @override
  _BarcodeCameraNavigatorViewState createState() =>
      _BarcodeCameraNavigatorViewState();
}

class _BarcodeCameraNavigatorViewState
    extends State<BarcodeCameraNavigatorView> {
  BarcodeScanner barcodeScanner =
      GoogleMlKit.vision.barcodeScanner([BarcodeFormat.qrCode]);

  bool isBusy = false;
  CustomPaint? customPaint;

  //Used in finding the barcode.
  Map<String, Offset> realBarcodePosition = {};

  //Map<String, List<RealInterBarcodeOffset>> : String is the startBarcodeUID_endBarcodeUID and then a list of RealInterBarcodeOffsets.
  Map<String, List<RealInterBarcodeOffset>> realInterBarcodeOffsetMap = {};
  //List of offsets that are not within error aka. barcode have changed location.
  Set<RealInterBarcodeOffset> offsetsThatDoNotCheckOut = {};
  Set<RealInterBarcodeOffset> offsetsThatDoCheckOut = {};

  //List of Barcodes that have not moved.
  Set<RealBarcodePosition> realBarcodePositions = {};

  Set<String> checksOut = {};
  Set<String> doesNotcheckOut = {};

  Vector3 accelerometerEvent = Vector3(0, 0, 0);
  Vector3 userAccelerometerEvent = Vector3(0, 0, 0);

  @override
  void initState() {
    accelerometerEvents.listen((AccelerometerEvent event) {
      accelerometerEvent = Vector3(event.x, event.y, event.z);
    });
    userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      userAccelerometerEvent = Vector3(event.x, event.y, event.z);
    });

    super.initState();
  }

  @override
  void dispose() {
    barcodeScanner.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [],
          ),
        ),
        body: CameraView(
          color: limeGreenMuted,
          title: 'Barcode Finder',
          customPaint: customPaint,
          onImage: (inputImage) {
            processImage(inputImage);
          },
        ));
  }

  ///////STEPS///////
  ///TODO: @049er
  // 1. Calculate where the phone's screen center is relative to all barcodes on screen.
  // 1.1...
  // 1.2....
  //
  //
  //
  //
  // 2. Detect barcodes that have moved.
  // 2.1 Update the positions of barcodes that have moved.
  //
  //
  //
  //
  //
  //

  Future<void> processImage(InputImage inputImage) async {
    if (isBusy) return;
    isBusy = true;
    final barcodes = await barcodeScanner.processImage(inputImage);
    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      final painter = BarcodeDetectorPainterNavigation(
          barcodes,
          inputImage.inputImageData!.size,
          inputImage.inputImageData!.imageRotation,
          realBarcodePosition,
          widget.qrcodeID);
      customPaint = CustomPaint(painter: painter);
    } else {
      customPaint = null;
    }
    isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
  

//   Future<void> processImage(InputImage inputImage) async {
//     //This list contains all realBarcodePositions.
//     Box<RealBarcodePostionEntry> realBarcodePositionDataBox =
//         await Hive.openBox(realPositionDataBoxName);

//     List<RealBarcodePostionEntry> realBarcodePositions =
//         realBarcodePositionDataBox.values.toList();

//     //This list contains all generated barcodes and their real life sizes.
//     List<BarcodeDataEntry> barcodeDataEntries = await getAllExistingBarcodes();

//     // List of all matchedCalibration Data aka. Distance lookup table.
//     List<DistanceFromCameraLookupEntry> matchedCalibrationData =
//         await getMatchedCalibrationData();

//     if (realBarcodePositionDataBox.isNotEmpty) {
//       //This map contains all the last reported positions of barcodes.
//       realBarcodePosition =
//           getBarcodeRealPositionMap(realBarcodePositionDataBox);

//       if (isBusy) return;
//       isBusy = true;
//       final barcodes = await barcodeScanner.processImage(inputImage);

//       if (inputImage.inputImageData?.size != null &&
//           inputImage.inputImageData?.imageRotation != null) {
//         if (barcodes.length >= 2) {
//           //1. Get all the onImageBarcodeData from the current Istance.

//           //OnImageBarcodeData in this istance.
//           List<RawOnImageBarcodeData> allRawOnImageBarcodeData = [
//             RawOnImageBarcodeData(
//                 barcodes: barcodes,
//                 timestamp: DateTime.now().millisecondsSinceEpoch,
//                 accelerometerData: getAccelerometerData())
//           ];

//           // This list contains all onImageInterBarcodeData from the image instant.
//           List<RawOnImageInterBarcodeData> allOnImageInterBarcodeData =
//               buildAllOnImageInterBarcodeData(allRawOnImageBarcodeData);

//           // Builds and adds all the real realInterBarcodeOffsets in this instance.
//           List<RealInterBarcodeOffset> allRealInterBarcodeOffsets =
//               buildAllRealInterBarcodeOffsets(
//                   allOnImageInterBarcodeData: allOnImageInterBarcodeData,
//                   matchedCalibrationData: matchedCalibrationData,
//                   allBarcodes: barcodeDataEntries);

//           //Add the RealInterBarcodeOffset to the map
//           for (RealInterBarcodeOffset realInterBarcodeOffset
//               in allRealInterBarcodeOffsets) {
//             //This adds data to the map.
//             String uid = realInterBarcodeOffset.uid;
//             if (realInterBarcodeOffsetMap
//                 .containsKey(realInterBarcodeOffset.uid)) {
//               List<RealInterBarcodeOffset> temp =
//                   realInterBarcodeOffsetMap[uid]!;
//               temp.add(realInterBarcodeOffset);
//               realInterBarcodeOffsetMap.update(uid, (value) => temp);
//             } else {
//               realInterBarcodeOffsetMap.putIfAbsent(
//                   uid, () => [realInterBarcodeOffset]);
//             }

//             //When there are more than 10 similar RealInterBarcodeOffsets it will calculate an average and add it to the finalSet.
//             if (realInterBarcodeOffsetMap[uid]!.length >= 5) {
//               List<RealInterBarcodeOffset> temp =
//                   realInterBarcodeOffsetMap[uid]!;

//               List<RealInterBarcodeOffset> averagedRealInterBarcodeOffset =
//                   processRealInterBarcodeData(
//                       uniqueRealInterBarcodeOffsets: temp.toSet().toList(),
//                       listOfRealInterBarcodeOffsets: temp);

//               //Retrive stored StartBarcodePosition
//               RealBarcodePostionEntry startBarcodePosition =
//                   realBarcodePositionDataBox
//                       .get(realInterBarcodeOffset.uidStart)!;
//               //Retrive stored EndBarcodePosition
//               RealBarcodePostionEntry endBarcodePosition =
//                   realBarcodePositionDataBox
//                       .get(realInterBarcodeOffset.uidEnd)!;
//               //Calculate the stored RealInterBarcodePosition.
//               Offset storedInterbarcodeOffset =
//                   typeOffsetToOffset(endBarcodePosition.offset) -
//                       typeOffsetToOffset(startBarcodePosition.offset);

//               //This is to calculate the amount of positional error we allow for.
//               double errorValue = 20; // max error value in mm
//               double currentX =
//                   averagedRealInterBarcodeOffset[0].realInterBarcodeOffset.dx;
//               double currentXLowerBoundry = currentX - (errorValue);
//               double currentXUpperBoundry = currentX + (errorValue);

//               double currentY =
//                   averagedRealInterBarcodeOffset[0].realInterBarcodeOffset.dy;
//               double currentYLowerBoundry = currentY - (errorValue);
//               double currentYUpperBoundry = currentY + (errorValue);

//               double storedX = storedInterbarcodeOffset.dx;
//               double storedY = storedInterbarcodeOffset.dy;

//               //This checks if the current positions falls within reasonable error from the stored position.
//               //If it does then mark its checksOut value as true.
//               //If not mark its checksOut value as false.
//               if (storedX <= currentXUpperBoundry &&
//                   storedX >= currentXLowerBoundry &&
//                   storedY <= currentYUpperBoundry &&
//                   storedY >= currentYLowerBoundry) {
//                 offsetsThatDoCheckOut.add(realInterBarcodeOffset);
//                 checksOut.addAll([
//                   realInterBarcodeOffset.uidStart,
//                   realInterBarcodeOffset.uidEnd
//                 ]);
//               } else {
//                 offsetsThatDoNotCheckOut.add(realInterBarcodeOffset);
//                 doesNotcheckOut.addAll([
//                   realInterBarcodeOffset.uidStart,
//                   realInterBarcodeOffset.uidEnd
//                 ]);
//               }
//             }

//             //TODO: implement code that updates barcode position XD.
//             //Can identify which barcodes do not checkout.

//             for (String barcodeID in doesNotcheckOut) {
//               int index = offsetsThatDoCheckOut
//                   .toList()
//                   .indexWhere((element) => element.uidEnd == barcodeID);

//               if (index != -1) {
//                 RealInterBarcodeOffset interBarcodeOffset =
//                     offsetsThatDoCheckOut
//                         .firstWhere((element) => element.uidEnd == barcodeID);

//                 RealBarcodePostionEntry startBarcodePosition =
//                     realBarcodePositions.firstWhere((element) =>
//                         element.uid == interBarcodeOffset.uidStart);

//                 RealBarcodePostionEntry endBarcodePosition =
//                     RealBarcodePostionEntry(
//                         uid: uid,
//                         offset: offsetToTypeOffset(
//                             typeOffsetToOffset(startBarcodePosition.offset) +
//                                 interBarcodeOffset.realInterBarcodeOffset),
//                         distanceFromCamera:
//                             interBarcodeOffset.zOffsetEndBarcode,
//                         fixed: false,
//                         timestamp: interBarcodeOffset.timestamp);

//                 checksOut.add(barcodeID);

//                 // log('does not check out');
//                 log(endBarcodePosition.toString());
//               }
//             }
//           }
//         }

//         final painter = BarcodeDetectorPainterNavigation(
//             barcodes,
//             inputImage.inputImageData!.size,
//             inputImage.inputImageData!.imageRotation,
//             realBarcodePosition,
//             widget.qrcodeID);
//         customPaint = CustomPaint(painter: painter);
//       } else {
//         customPaint = null;
//       }
//       isBusy = false;
//       if (mounted) {
//         setState(() {});
//       }
//     }
//   }

//   ///Returns a map of all stored barocodes and their last reported posiitons.
//   Map<String, Offset> getBarcodeRealPositionMap(Box barcodeRealPosition) {
//     Map map = barcodeRealPosition.toMap();
//     Map<String, Offset> barcodeReaPositionMap = {};
//     map.forEach((key, value) {
//       RealBarcodePostionEntry data = value;
//       barcodeReaPositionMap.update(
//         key,
//         (value) => Offset(data.offset.x, data.offset.y),
//         ifAbsent: () => Offset(data.offset.x, data.offset.y),
//       );
//     });
//     return barcodeReaPositionMap;
//   }

//   ///This stores the AccelerometerEvent and UserAccelerometerEvent at an instant.
//   AccelerometerData getAccelerometerData() {
//     return AccelerometerData(
//         accelerometerEvent: accelerometerEvent,
//         userAccelerometerEvent: userAccelerometerEvent);
//   }
// }
