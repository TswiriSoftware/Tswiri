import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import '../../../../main.dart';
import '../barcodes_view.dart';

class BarcodeToolsView extends StatefulWidget {
  const BarcodeToolsView({Key? key}) : super(key: key);

  @override
  _BarcodeToolsViewState createState() => _BarcodeToolsViewState();
}

class _BarcodeToolsViewState extends State<BarcodeToolsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: deepSpaceSparkle[700],
        title: const Text(
          'Barcode Tools',
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
              'Barcodes',
              BarcodesView(),
              Icons.view_array,
              featureCompleted: true,
              tileColor: deepSpaceSparkle,
            ),
          ],
        ),
      ),
    );
  }
}
