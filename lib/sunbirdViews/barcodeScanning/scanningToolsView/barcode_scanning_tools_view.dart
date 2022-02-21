import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcodeScanning/barcode_scanner_view.dart';
import 'package:hive/hive.dart';
import '../../../main.dart';
import '../real_barcode_position_database_view.dart';
import '../real_barcode_position_database_visualization_view.dart';

class BarcodeScanningView extends StatefulWidget {
  const BarcodeScanningView({Key? key}) : super(key: key);

  @override
  _BarcodeScanningViewState createState() => _BarcodeScanningViewState();
}

class _BarcodeScanningViewState extends State<BarcodeScanningView> {
  @override
  void initState() {
    Hive.close();
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
        title: const Text(
          'Barcode Scanning Tools',
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
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const CustomCard(
              'Barcode Scanner',
              BarcodeScannerView(),
              Icons.camera,
              featureCompleted: true,
              tileColor: Colors.deepOrange,
            ),
            const CustomCard(
              'Consolidated Data Viewer',
              RealBarcodePositionDatabaseView(),
              Icons.view_array,
              featureCompleted: true,
              tileColor: Colors.deepOrange,
            ),
            const CustomCard(
              'Visual Data Viewer',
              RealBarcodePositionDatabaseVisualizationView(),
              Icons.map_outlined,
              featureCompleted: true,
              tileColor: Colors.deepOrange,
            ),
          ],
        ),
      ),
    );
  }
}
