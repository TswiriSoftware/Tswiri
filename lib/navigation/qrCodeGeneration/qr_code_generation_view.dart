import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/examples/1_6.dart';
import 'package:flutter_google_ml_kit/navigation/qrCodeGeneration/qr_code_viewer.dart';
import 'package:flutter_google_ml_kit/navigation/qrCodeNavigation/qr_code_navigation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import '../../main.dart';

class QrCodeGenerationView extends StatefulWidget {
  const QrCodeGenerationView({Key? key}) : super(key: key);

  @override
  _QrCodeGenerationViewState createState() => _QrCodeGenerationViewState();
}

class _QrCodeGenerationViewState extends State<QrCodeGenerationView> {
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
            PdfPreview(
        maxPageWidth: 700,
        build: (format) => generatePDF()),
        //actions: actions,
        //onPrinted: _showPrintedToast,
        //onShared: _showSharedToast,
            
            // CustomCard(
            //   'Pdf Viewer',
            //   Calendar(),
            //   Icons.camera,
            //   featureCompleted: true,
            // ),
            // CustomCard(
            //   'Pdf Creator',
            //   PDFCreator(),
            //   Icons.camera,
            //   featureCompleted: true,
            // ),
          ],
        ),
      ),
    );
  }
}
