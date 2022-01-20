import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/navigation/qrCodeNavigation/qr_code_navigation.dart';
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
            CustomCard(
              'Qr Code Finder',
              QrCodeNavigation(),
              Icons.camera,
              featureCompleted: true,
            ),
          ],
        ),
      ),
    );
  }
}
