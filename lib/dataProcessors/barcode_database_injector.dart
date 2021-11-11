import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class BarcodeDatabaseInjector {

  BarcodeDatabaseInjector(this.barcodes, this.absoluteImageSize, this.rotation);

  final List<Barcode> barcodes;
  final Size absoluteImageSize;
  final InputImageRotation rotation;

}

  void injectBarcode (List<Barcode> barcodes,Size absoluteImageSize,InputImageRotation rotation, var box) {
    print('Hello');
    //TODO@049er: implement functionality 
  }