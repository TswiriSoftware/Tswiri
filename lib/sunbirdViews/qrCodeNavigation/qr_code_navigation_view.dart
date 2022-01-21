import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/qrCodeNavigation/qr_code_navigator_view.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/qrCodeNavigation/qr_code_selection_view.dart';
import '../../main.dart';

class QrCodeNavigationView extends StatefulWidget {
  const QrCodeNavigationView({Key? key}) : super(key: key);

  @override
  _QrCodeNavigationViewState createState() => _QrCodeNavigationViewState();
}

class _QrCodeNavigationViewState extends State<QrCodeNavigationView> {
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
              QrCodeSelectionView(),
              Icons.camera,
              featureCompleted: true,
            ),
          ],
        ),
      ),
    );
  }
}
