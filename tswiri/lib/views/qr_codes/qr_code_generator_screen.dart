import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:tswiri/enumerations.dart';
import 'package:tswiri/providers.dart';
import 'package:tswiri/views/abstract_page.dart';
import 'package:tswiri/widgets/qr_code_batch_setup.dart';

class QrCodeGeneratorScreen extends ConsumerStatefulWidget {
  const QrCodeGeneratorScreen({super.key});

  @override
  AbstractScreen<QrCodeGeneratorScreen> createState() => _QrCodeGeneratorScreenState();
}

class _QrCodeGeneratorScreenState extends AbstractScreen<QrCodeGeneratorScreen> {
  int numberOfBarcodes = 20;
  bool isEditing = false;

  final initialBarcodeSize = BarcodeSize.medium;
  late Size size = initialBarcodeSize.size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Generator'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          QRCodeBatchSetup(
            numberOfBarcodes: numberOfBarcodes,
            onNumberOfBarcodesChanged: (value) {
              setState(() {
                numberOfBarcodes = value;
              });
            },
            initialBarcodeSize: initialBarcodeSize,
            onBarcodeSizeChanged: (value) {
              setState(() {
                size = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
