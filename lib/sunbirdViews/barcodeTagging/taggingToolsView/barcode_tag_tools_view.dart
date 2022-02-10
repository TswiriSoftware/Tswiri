import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcodeScanning/barcode_scanner_view.dart';
import '../../../../main.dart';
import '../barcode_tagging_selector_view.dart';

class BarcodeTagToolsView extends StatefulWidget {
  const BarcodeTagToolsView({Key? key}) : super(key: key);

  @override
  _BarcodeTagToolsViewState createState() => _BarcodeTagToolsViewState();
}

class _BarcodeTagToolsViewState extends State<BarcodeTagToolsView> {
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
              'Barcode Tagging',
              BarcodeSelectionTagView(),
              Icons.view_array,
              featureCompleted: true,
              tileColor: deepSpaceSparkle,
            ),
            const CustomCard(
              'All Tags',
              BarcodeSelectionTagView(),
              Icons.map_outlined,
              featureCompleted: true,
              tileColor: deepSpaceSparkle,
            ),
          ],
        ),
      ),
    );
  }
}
