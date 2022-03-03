import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/gettingStarted/barcode_generator_info_view.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/gettingStarted/barcode_list_info_view.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/gettingStarted/barcode_navigation_info_view.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/gettingStarted/barcode_scanning_info_view.dart';
import '../../../widgets/custom_card_widget.dart';
import '../barcodeNavigation/barcode_selection_view.dart';
import 'camera_calibration_info_view.dart';

///Shows camera calibration tools.
class GettingStartedView extends StatefulWidget {
  const GettingStartedView({Key? key}) : super(key: key);

  @override
  _GettingStartedViewState createState() => _GettingStartedViewState();
}

class _GettingStartedViewState extends State<GettingStartedView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: skyBlue80,
        title: const Text(
          'Getting Started',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: GridView.count(
          padding: const EdgeInsets.all(16),
          mainAxisSpacing: 8,
          crossAxisSpacing: 16,
          crossAxisCount: 2,
          children: const [
            CustomCard(
              'Camera Calibration',
              CameraCalibrationInfoView(),
              Icons.camera_alt_rounded,
              featureCompleted: true,
              tileColor: skyBlue80,
            ),
            CustomCard(
              'Barcode Generator',
              BarcodeGeneratorInfoView(),
              Icons.list_alt_rounded,
              featureCompleted: true,
              tileColor: skyBlue80,
            ),
            CustomCard(
              'Barcode Scanning',
              BarcodeScanningInfoView(),
              Icons.qr_code_2_rounded,
              featureCompleted: true,
              tileColor: skyBlue80,
            ),
            CustomCard(
              'Barcode Navigation',
              BarcodeNavigationInfoView(),
              Icons.navigation_rounded,
              featureCompleted: true,
              tileColor: skyBlue80,
            ),
            CustomCard(
              'Barcode List Info',
              BarcodeListInfoView(),
              Icons.list_alt_rounded,
              featureCompleted: true,
              tileColor: skyBlue80,
            ),
          ],
        ),
      ),
    );
  }
}
