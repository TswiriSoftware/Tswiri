import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/VisionDetectorViews/barcode_scanner_view.dart';
import '../../../main.dart';
import '../consolidated_database_view.dart';
import '../consolidated_database_visualization_view.dart';
import '../raw_database_view.dart';

class BarcodeScanningView extends StatefulWidget {
  const BarcodeScanningView({Key? key}) : super(key: key);

  @override
  _BarcodeScanningViewState createState() => _BarcodeScanningViewState();
}

class _BarcodeScanningViewState extends State<BarcodeScanningView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sunbird',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: GridView.count(
          padding: EdgeInsets.all(16),
          mainAxisSpacing: 8,
          crossAxisSpacing: 16,
          crossAxisCount: 2,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const CustomCard(
              'Barcode Scanner',
              BarcodeScannerView(),
              Icons.camera,
              featureCompleted: true,
            ),
            const CustomCard(
                'Raw Data Viewer', HiveDatabaseView(), Icons.view_array,
                featureCompleted: true),
            const CustomCard('Consolidated Data Viewer',
                HiveDatabaseConsolidationView(), Icons.view_array,
                featureCompleted: true),
            const CustomCard('Visual Data Viewer', DatabaseVisualization(),
                Icons.map_outlined,
                featureCompleted: true),
          ],
        ),
      ),
    );
  }
}
