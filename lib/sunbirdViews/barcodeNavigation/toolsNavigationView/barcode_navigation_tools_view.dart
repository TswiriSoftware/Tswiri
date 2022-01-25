import 'package:flutter/material.dart';
import '../../../main.dart';
import '../barcode_selection_view.dart';

class BarcodeNavigationView extends StatefulWidget {
  const BarcodeNavigationView({Key? key}) : super(key: key);

  @override
  _BarcodeNavigationViewState createState() => _BarcodeNavigationViewState();
}

class _BarcodeNavigationViewState extends State<BarcodeNavigationView> {
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
              'Qr Code Finder',
              BarcodeSelectionView(),
              Icons.camera,
              featureCompleted: true,
            ),
          ],
        ),
      ),
    );
  }
}
