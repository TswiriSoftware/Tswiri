import 'package:flutter/material.dart';

/// The Offset between the startBarcode and barcode aswell as the Absolute offset between them, Distance from camera and time of creation
class OnImageInterBarcodeData {
  OnImageInterBarcodeData(
      {required this.uid,
      required this.startBarcodeID,
      required this.startDiagonalLength,
      required this.endBarcodeID,
      required this.endDiagonalLength,
      required this.interBarcodeOffsetonImage,
      required this.timestamp});

  final String uid;

  ///ID of the barcode at the start position.
  final String startBarcodeID;

  ///ID of the barcode at the end position.
  final String endBarcodeID;

  ///Start barcode diagonal length.
  final double startDiagonalLength;

  ///End barcode diagonal length.
  final double endDiagonalLength;

  ///The offset between the start and end barcodes.
  final Offset interBarcodeOffsetonImage; //Offset between Barcodes

  ///Timestamp when the barcodes where scanned.
  final int timestamp; //Timestamp

  @override
  String toString() {
    return '${startBarcodeID}_$endBarcodeID, $interBarcodeOffsetonImage, $timestamp';
  }
}
