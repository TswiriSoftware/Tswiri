import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/cameraCalibration/camera_calibration_view.dart';
import 'package:flutter_google_ml_kit/zDemoView/tutorial/tutorial_view.dart';
import '../../globalValues/global_colours.dart';

import '../generator/barcode_generation_range_selector_view.dart';
import 'new_shelf_name_and_description_view.dart';

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
            ElevatedButton(
                onPressed: () {
                  //TODO: Implement write to database + checks. and switch between continue and delete.
                  Navigator.pop(context);
                },
                child: Text('Continue'))
          ],
        ),
      ),
    );
  }

  Widget shelfNameAndDescriptionWidget() {
    return NewShelfContainer(
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
    return NewShelfContainer(
      stepNumber: '2',
      label: 'Generate and print barcodes.',
      hasCompleted: barcodesGenerated,
      onDonePressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RangeSelectorView(),
          ),
        );
        setState(() {
          barcodesGenerated = true;
        });
      },
      showSkipButton: false,
    );
  }

  Widget howToPlaceBarcodesWidget() {
    return NewShelfContainer(
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
      showSkipButton: false,
    );
  }

  Widget cameraCalibrationWidget() {
    return NewShelfContainer(
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
    return NewShelfContainer(
      stepNumber: '5',
      label: 'Scan fixed barcodes.',
      hasCompleted: hasScannedFixedBarcodes,
      onDonePressed: () async {
        //TODO: implement navigator and return

        // await Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const CameraCalibrationView(),
        //   ),
        // );
        setState(() {
          hasScannedFixedBarcodes = true;
        });
      },
      showSkipButton: false,
    );
  }

  Widget scanningBarcodesWidget() {
    return NewShelfContainer(
      stepNumber: '6',
      label: 'Scan barcodes',
      hasCompleted: hasScannedBarcodes,
      onDonePressed: () async {
        //TODO: implement navigator and return

        // await Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const CameraCalibrationView(),
        //   ),
        // );
        setState(() {
          hasScannedBarcodes = true;
        });
      },
      showSkipButton: false,
    );
  }
}

class NewShelfContainer extends StatelessWidget {
  NewShelfContainer(
      {Key? key,
      required this.stepNumber,
      required this.label,
      required this.hasCompleted,
      required this.onDonePressed,
      required this.showSkipButton,
      this.onSkipPressed})
      : super(key: key);

  String stepNumber;
  String label;
  bool hasCompleted;
  bool showSkipButton;

  final void Function() onDonePressed;
  final void Function()? onSkipPressed;
  Color buttonColor = Colors.deepOrange;

  @override
  Widget build(BuildContext context) {
    if (hasCompleted) {
      buttonColor = Colors.green;
    }
    return Container(
      //Outer Container Decoration
      margin: const EdgeInsets.only(bottom: 5, top: 5, left: 5, right: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white60, width: 1),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin:
                    const EdgeInsets.only(top: 8, right: 5, bottom: 5, left: 5),
                height: 60,
                width: (MediaQuery.of(context).size.width * 0.13),
                decoration:
                    BoxDecoration(color: buttonColor, shape: BoxShape.circle),
                child: Center(
                  child: Text(stepNumber),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                margin: const EdgeInsets.only(top: 8, right: 5, bottom: 5),
                decoration: const BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                height: 55,
                width: (MediaQuery.of(context).size.width * 0.77),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    label,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 15),
                    maxLines: 2,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Builder(builder: (context) {
                  if (showSkipButton) {
                    return SizedBox(
                      height: 30,
                      child: ElevatedButton(
                          style: TextButton.styleFrom(
                            backgroundColor: buttonColor,
                          ),
                          onPressed: onSkipPressed,
                          child: const Text('skip')),
                    );
                  } else {
                    return const SizedBox();
                  }
                }),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    style: TextButton.styleFrom(backgroundColor: buttonColor),
                    onPressed: onDonePressed,
                    child: const Text('go'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}




// ShelfCreateCard(
//     stepNumber: '2',
//     label: 'Generate and Print Barcodes.',
//     hasComplete: shelfSetup),
// ShelfCreateCard(
//     stepNumber: '3',
//     label: 'Learn how to place barcodes.',
//     hasComplete: shelfSetup),
// ShelfCreateCard(
//     stepNumber: '4',
//     label: 'Calibrate Camera',
//     hasComplete: shelfSetup),
// ShelfCreateCard(
//     stepNumber: '5',
//     label: 'Scan/Select fixed barcodes.',
//     hasComplete: shelfSetup),
// ShelfCreateCard(
//     stepNumber: '6',
//     label: 'Scan all barcodes.',
//     hasComplete: shelfSetup),
// ShelfCreateCard(
//     stepNumber: '7',
//     label: 'Tag boxes and Photograph content.',
//     hasComplete: shelfSetup),
