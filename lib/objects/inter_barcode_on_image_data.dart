import 'package:flutter/material.dart';

/// The Offset between the startBarcode and barcode aswell as the Absolute offset between them, Distance from camera and time of creation
class InterBarcodeOnImageData {
  InterBarcodeOnImageData(
      {required this.startBarcodeID,
      required this.endBarcodeID,
      required this.aveDiagonalSideLength,
      required this.interBarcodeOffsetonImage,
      required this.timestamp});

  final String startBarcodeID;
  final String endBarcodeID;
  final double aveDiagonalSideLength;
  final Offset interBarcodeOffsetonImage; //Offset between Barcodes
  final int timestamp; //Timestamp

  @override
  String toString() {
    return '$startBarcodeID, $endBarcodeID, $aveDiagonalSideLength ,$timestamp';
  }
}
