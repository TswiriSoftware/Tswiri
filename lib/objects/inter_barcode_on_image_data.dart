import 'package:flutter/material.dart';

/// The Offset between the startBarcode and barcode aswell as the Absolute offset between them, Distance from camera and time of creation
class InterBarcodeOnImageData {
  InterBarcodeOnImageData(
      {required this.startBarcodeID,
      required this.endBarcodeID,
      required this.aveDiagonalLength,
      required this.interBarcodeOffsetonImage,
      required this.timestamp});

  ///ID of the barcode at the start position.
  final String startBarcodeID;

  ///ID of the barcode at the end position.
  final String endBarcodeID;

  ///Average diagonal length of both the barcodes.
  final double aveDiagonalLength;

  ///The offset between the start and end barcodes.
  final Offset interBarcodeOffsetonImage; //Offset between Barcodes

  ///Timestamp when the barcodes where scanned.
  final int timestamp; //Timestamp

  @override
  String toString() {
    return '$startBarcodeID, $endBarcodeID, $aveDiagonalLength ,$timestamp';
  }
}
