import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/navigation/qrCodeGeneration/QrCodeGenerator.dart';
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
          crossAxisCount: 1,
          // ignore: prefer_const_literals_to_create_immutables

          children: [
            CustomCardQrCode([1, 2, 3, 4, 5, 6]),
            CustomCardQrCode([7, 8, 9, 10, 11, 12]),
            CustomCardQrCode([13, 14, 15, 16, 17, 18]),
            CustomCardQrCode([19, 20, 21, 22, 23, 24]),
          ],
        ),
      ),
    );
  }
}

class CustomCardQrCode extends StatelessWidget {
  final List<int> range;

  // ignore: use_key_in_widget_constructors
  const CustomCardQrCode(this.range);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 300,
      child: Card(
          elevation: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                tileColor: Theme.of(context).primaryColor,
                title: Text(
                  '${range.first} - ${range.last}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 295,
                child: PdfPreview(
                    maxPageWidth: 200, build: (format) => generatePDF(range)),
              )
            ],
          )),
    );
  }
}
