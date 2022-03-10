import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/shelfAdapter/shelf_entry.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/cameraCalibration/camera_calibration_view.dart';
import 'package:hive/hive.dart';
import '../../globalValues/global_colours.dart';

import '../../globalValues/global_hive_databases.dart';
import '../barcodeControlPanel/barcode_list_view.dart';
import '../barcodeGeneration/barcode_generation_range_selector_view.dart';
import '../barcodeScanning/barcode_scanner_fixed_view .dart';
import '../barcodeScanning/barcode_scanner_view.dart';
import '../tutorial/tutorial_view.dart';
import 'shelf_name_and_description_view.dart';
import '../../widgets/new_shelf_card_widget.dart';

class NewShelfView extends StatefulWidget {
  const NewShelfView({Key? key}) : super(key: key);

  @override
  State<NewShelfView> createState() => _NewShelfViewState();
}

class _NewShelfViewState extends State<NewShelfView> {
  //Shelf naming.
  bool shelfSetup = false;

  //Barcode generator
  bool barcodesGenerated = false;

  //How to place barcodes.
  bool howToPlaceBarcodes = false;

  //Camera Calibration.
  bool hasCalibratedCamera = false;

  //Scanning Fixed barcodes.
  bool hasScannedFixedBarcodes = false;

  //Scanning barcodes.
  bool hasScannedBarcodes = false;

  //Scanning barcodes.
  bool hasTaggedBoxes = false;

  ShelfEntry? shelfEntry;

  String shelfName = 'Name';
  String shelfDescription = 'Description';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: brightOrange,
        title: const Text(
          'New Shelf',
          style: TextStyle(fontSize: 25),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            shelfNameAndDescriptionWidget(),
            barcodeGeneratorWidget(),
            howToPlaceBarcodesWidget(),
            cameraCalibrationWidget(),
            scanningFixedBarcodesWidget(),
            scanningBarcodesWidget(),
            tagBoxesAndPhotographContentWidget(),
            completeShelf()
          ],
        ),
      ),
    );
  }

  Widget shelfNameAndDescriptionWidget() {
    return StepCardWidget(
      stepNumber: '1',
      label: 'Name: $shelfName\nDescription: $shelfDescription',
      hasCompleted: shelfSetup,
      onDonePressed: () async {
        List<String> result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShelfNameAndDescriptionView(
                shelfName: shelfName, shelfDescription: shelfDescription),
          ),
        );
        setState(() {
          shelfName = result.first;
          shelfDescription = result.last;
          if (shelfName.isNotEmpty) {
            shelfSetup = true;
          } else {
            shelfSetup = false;
          }
        });
      },
      showSkipButton: false,
    );
  }

  Widget barcodeGeneratorWidget() {
    return StepCardWidget(
      stepNumber: '2',
      label: 'Generate and print barcodes.',
      hasCompleted: barcodesGenerated,
      onDonePressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const BarcodeGenerationRangeSelectorView(),
          ),
        );
        setState(() {
          barcodesGenerated = true;
        });
      },
      showSkipButton: true,
      onSkipPressed: () {
        setState(() {
          barcodesGenerated = true;
        });
      },
    );
  }

  Widget howToPlaceBarcodesWidget() {
    return StepCardWidget(
      stepNumber: '3',
      label: 'Learn how to place barcodes.',
      hasCompleted: howToPlaceBarcodes,
      onDonePressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TutorialView(),
          ),
        );
        setState(() {
          howToPlaceBarcodes = true;
        });
      },
      showSkipButton: true,
      onSkipPressed: () {
        setState(() {
          howToPlaceBarcodes = true;
        });
      },
    );
  }

  Widget cameraCalibrationWidget() {
    return StepCardWidget(
      stepNumber: '4',
      label: 'Calibrate your camera.',
      hasCompleted: hasCalibratedCamera,
      onDonePressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CameraCalibrationView(),
          ),
        );
        setState(() {
          //TODO: implement futureBuilder to check if camera has been calibrated.
          //TODO: Implement Check.
          hasCalibratedCamera = true;
        });
      },
      showSkipButton: true,
      onSkipPressed: () {
        setState(() {
          hasCalibratedCamera = true;
        });
      },
    );
  }

  Widget scanningFixedBarcodesWidget() {
    return StepCardWidget(
      stepNumber: '5',
      label: 'Scan/Select Markers (These are fixed barcodes).',
      hasCompleted: hasScannedFixedBarcodes,
      onDonePressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const BarcodeScannerFixedBarcodesView(),
          ),
        );
        setState(() {
          //Implement Check to ensure at least 1 barcode is fixed in this shelf.
          hasScannedFixedBarcodes = true;
        });
      },
      showSkipButton: false,
    );
  }

  Widget scanningBarcodesWidget() {
    return StepCardWidget(
      stepNumber: '6',
      label: 'Scan barcodes (These will become boxes)',
      hasCompleted: hasScannedBarcodes,
      onDonePressed: () async {
        Box<ShelfEntry> shelfEntriesBox = await Hive.openBox(shelvesBoxName);
        int newShelfUID = 1;
        if (shelfEntriesBox.isNotEmpty) {
          newShelfUID = shelfEntriesBox.values.last.uid + 1;
        }

        setState(() {
          shelfEntry = ShelfEntry(
              uid: newShelfUID, name: shelfName, description: shelfDescription);
        });
        log(shelfEntry.toString());
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BarcodeScannerView(
              shelfUID: newShelfUID,
            ),
          ),
        );
        setState(() {
          hasScannedBarcodes = true;
        });
      },
      showSkipButton: false,
    );
  }

  Widget tagBoxesAndPhotographContentWidget() {
    return StepCardWidget(
      stepNumber: '7',
      label: 'Tag boxes and photograph content',
      hasCompleted: hasTaggedBoxes,
      onDonePressed: () async {
        if (shelfEntry != null) {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BarcodeListView(
                shelfEntry: shelfEntry,
              ),
            ),
          );
          setState(() {
            hasTaggedBoxes = true;
          });
        }
      },
      showSkipButton: true,
      onSkipPressed: () {
        setState(() {
          hasTaggedBoxes = true;
        });
      },
    );
  }

  Widget completeShelf() {
    return Builder(builder: (context) {
      if (shelfSetup &&
          barcodesGenerated &&
          hasCalibratedCamera &&
          hasScannedFixedBarcodes &&
          hasScannedBarcodes &&
          hasTaggedBoxes) {
        return ElevatedButton(
            style: TextButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () async {
              //TODO: Implement write to database + checks.

              Box<ShelfEntry> shelvesBox = await Hive.openBox(shelvesBoxName);

              int uid = 0;

              if (shelvesBox.isNotEmpty) {
                uid = shelvesBox.getAt(shelvesBox.length - 1)!.uid + 1;
              } else {
                uid = 1;
              }

              shelvesBox.put(
                  uid,
                  ShelfEntry(
                      uid: uid,
                      name: shelfName,
                      description: shelfDescription));

              log(shelvesBox.length.toString());

              Navigator.pop(context);
            },
            child: const Text('Continue'));
      } else {
        return ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Delete'));
      }
    });
  }
}
