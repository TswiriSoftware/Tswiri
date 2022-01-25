import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/VisionDetectorViews/barcode_scanner_view.dart';
import 'package:flutter_google_ml_kit/sunbirdDatabaseViews/QrCodeRelated/hive_database_consolidation.dart';
import 'package:flutter_google_ml_kit/sunbirdDatabaseViews/QrCodeRelated/hive_database_visualization.dart';
import 'package:flutter_google_ml_kit/sunbirdDatabaseViews/QrCodeRelated/hive_raw_database_view.dart';
import '../../main.dart';

class QrCodeScanningView extends StatefulWidget {
  const QrCodeScanningView({Key? key}) : super(key: key);

  @override
  _QrCodeScanningViewState createState() => _QrCodeScanningViewState();
}

class _QrCodeScanningViewState extends State<QrCodeScanningView> {
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