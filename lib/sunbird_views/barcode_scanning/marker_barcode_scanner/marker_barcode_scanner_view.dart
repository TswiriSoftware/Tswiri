import 'package:flutter_google_ml_kit/global_values/global_colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcode_scanning/single_barcode_scanner/single_barcode_scanner_camera_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcode_scanning/single_barcode_scanner/single_barcode_scanner_painter.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/dark_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/light_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/orange_outline_container.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

///Will return a String? BarcodeUID
class MarkerBarcodeScannerView extends StatefulWidget {
  const MarkerBarcodeScannerView({Key? key}) : super(key: key);

  @override
  _MarkerBarcodeScannerViewState createState() =>
      _MarkerBarcodeScannerViewState();
}

class _MarkerBarcodeScannerViewState extends State<MarkerBarcodeScannerView> {
  BarcodeScanner barcodeScanner =
      GoogleMlKit.vision.barcodeScanner([BarcodeFormat.qrCode]);

  bool isBusy = false;
  CustomPaint? customPaint;
  String? currentBarcodeUID;
  List<String> barcodeUIDs = [];
  bool showList = false;

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
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            //Done Scanning
            FloatingActionButton(
              heroTag: null,
              onPressed: () {
                Navigator.pop(context, barcodeUIDs);
              },
              child: const Icon(Icons.done_all, color: Colors.white),
            ),
            const SizedBox(
              height: 20,
            ),
            //BarcodeListDisplay
            Builder(builder: (context) {
              if (showList == true) {
                return SizedBox(
                  //height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: LightContainer(
                    margin: 2.5,
                    padding: 2.5,
                    child: DarkContainer(
                      padding: 5,
                      margin: 0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Hold barcode to delete',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const Divider(
                            color: Colors.white54,
                          ),
                          Wrap(
                            children: barcodeUIDs
                                .map((e) => InkWell(
                                    onLongPress: () {
                                      barcodeUIDs.remove(e);
                                    },
                                    child:
                                        OrangeOutlineContainer(child: Text(e))))
                                .toList(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    showList = !showList;
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.close))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    showList = !showList;
                    setState(() {});
                  },
                  child: const Icon(
                    Icons.list,
                    color: Colors.white,
                  ),
                );
              }
            }),
            const SizedBox(
              height: 20,
            ),
            //Add BarcodeUID
            FloatingActionButton(
              heroTag: null,
              onPressed: () {
                if (barcodeUIDs.contains(currentBarcodeUID)) {
                  barcodeUIDs.remove(currentBarcodeUID);
                } else {
                  if (currentBarcodeUID != null) {
                    barcodeUIDs.add(currentBarcodeUID!);
                  }
                }
              },
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleBarcodeScannerCameraView(
                color: brightOrange,
                title: 'Barcode Scanner',
                customPaint: customPaint,
                onImage: (inputImage) {
                  processImage(inputImage);
                },
              ),
            ),
          ],
        ));
  }

  Future<void> processImage(InputImage inputImage) async {
    if (isBusy) return;
    isBusy = true;

    //Closest barcode to center distance.
    double? clostesBarcodeDistance;

    final List<Barcode> barcodes =
        await barcodeScanner.processImage(inputImage);

    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
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
              currentBarcodeUID = barcode.value.displayValue;
            });
          } else if (clostesBarcodeDistance > distanceFromCenter) {
            clostesBarcodeDistance = distanceFromCenter;
            setState(() {
              currentBarcodeUID = barcode.value.displayValue;
            });
          }
        }
      }

      final painter = SingleBarcodeScannerPainter(
          barcodes: barcodes,
          absoluteImageSize: inputImage.inputImageData!.size,
          rotation: inputImage.inputImageData!.imageRotation,
          barcodeID: currentBarcodeUID);

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
