import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:hive/hive.dart';

import '../../databaseAdapters/allBarcodes/barcode_data_entry.dart';
import '../../functions/dataProccessing/barcode_scanner_data_processing_functions.dart';
import '../../globalValues/global_hive_databases.dart';
import 'cameraView/barcode_marker_scan_camera_view.dart';
import 'painter/fixed_barcode_detector_painter.dart';

class BarcodeMarkerScannerView extends StatefulWidget {
  const BarcodeMarkerScannerView({Key? key}) : super(key: key);

  @override
  _BarcodeMarkerScannerViewState createState() =>
      _BarcodeMarkerScannerViewState();
}

class _BarcodeMarkerScannerViewState extends State<BarcodeMarkerScannerView> {
  BarcodeScanner barcodeScanner =
      GoogleMlKit.vision.barcodeScanner([BarcodeFormat.qrCode]);

  bool isBusy = false;
  CustomPaint? customPaint;
  int? barcodeID;

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();

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
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Builder(
              builder: (context) {
                barcodeID ??= 0;
                return FloatingActionButton(
                  heroTag: null,
                  onPressed: () async {
                    //Ensure list has been fetched.
                    if (allBarcodes != null) {
                      //Get the index of the current barcode.
                      int index = allBarcodes!
                          .indexWhere((element) => element.uid == barcodeID);
                      if (index != -1) {
                        //Get the genrated barcodeData.
                        Box<BarcodeDataEntry> generatedBarcodeData =
                            await Hive.openBox(allBarcodesBoxName);

                        if (allBarcodes![index].isFixed == false) {
                          //Change the isFixed bool to true.
                          allBarcodes![index].isFixed = true;
                          BarcodeDataEntry currentBarcode =
                              generatedBarcodeData.get(barcodeID)!;
                          currentBarcode.isFixed = true;
                          generatedBarcodeData.put(barcodeID, currentBarcode);
                        } else {
                          //Change the isFixed bool to false.
                          allBarcodes![index].isFixed = false;
                          BarcodeDataEntry currentBarcode =
                              generatedBarcodeData.get(barcodeID)!;
                          currentBarcode.isFixed = false;
                          generatedBarcodeData.put(barcodeID, currentBarcode);
                        }
                      }
                    }
                  },
                  child: Text(barcodeID.toString()),
                );
              },
            ),
            const SizedBox(
              height: 25,
            ),
            FloatingActionButton(
              heroTag: null,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.check_circle_outline_rounded),
            ),
          ],
        ),
        body: BarcodeMarkerScanCameraView(
          color: brightOrange,
          title: 'Marker Scanner',
          customPaint: customPaint,
          onImage: (inputImage) {
            processImage(inputImage);
          },
        ));
  }

  List<BarcodeDataEntry>? allBarcodes;
  Future<void> processImage(InputImage inputImage) async {
    if (isBusy) return;
    isBusy = true;

    //Get the list of generated barcodes.
    allBarcodes ??= await getAllExistingBarcodes();
    double? clostesBarcodeDistance;
    final List<Barcode> barcodes =
        await barcodeScanner.processImage(inputImage);

    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null &&
        allBarcodes != null) {
      ///Code for barcode Closets to center.
      Offset imageCenter = Offset(inputImage.inputImageData!.size.height / 2,
          inputImage.inputImageData!.size.width / 2);

      //Run through all barcodes.
      for (Barcode barcode in barcodes) {
        if (barcodes.isNotEmpty &&
            barcodes.first.value.displayValue != null &&
            mounted) {
          //Calculate distance from screen center
          double distanceFromCenter =
              (imageCenter - calculateBarcodeCenterOffset(barcode)).distance;

          //If it is the closest it will update the button value.
          if (clostesBarcodeDistance == null) {
            clostesBarcodeDistance = distanceFromCenter;
            setState(() {
              barcodeID = int.parse(barcode.value.displayValue!);
            });
          } else if (clostesBarcodeDistance > distanceFromCenter) {
            clostesBarcodeDistance = distanceFromCenter;
            setState(() {
              barcodeID = int.parse(barcode.value.displayValue!);
            });
          }
        }
      }

      final painter = FixedBarcodeDetectorPainter(
          barcodes: barcodes,
          absoluteImageSize: inputImage.inputImageData!.size,
          rotation: inputImage.inputImageData!.imageRotation,
          allBarcodes: allBarcodes!,
          barcodeID: barcodeID);

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

Offset calculateBarcodeCenterOffset(Barcode barcode) {
  double top = barcode.value.boundingBox!.top;
  double bottom = barcode.value.boundingBox!.bottom;
  double left = barcode.value.boundingBox!.left;
  double right = barcode.value.boundingBox!.right;

  Rect boundingBox = Rect.fromLTRB(left, top, right, bottom);
  return boundingBox.center;
}
