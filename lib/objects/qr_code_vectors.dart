import 'package:flutter/material.dart';

/// The Offset between the startBarcode and barcode aswell as the Absolute offset between them, Distance from camera and time of creation
class BarcodesOffset {
  BarcodesOffset(
      {required this.startQrCode,
      required this.endQrCode,
      required this.relativeOffset,
      required this.distanceFromCamera,
      required this.timestamp});

  final String startQrCode;
  final String endQrCode;
  final Offset relativeOffset; //Offset between Barcodes
  late double distanceFromCamera; //Unit: millimetres
  final int timestamp; //Timestamp

  @override
  String toString() {
    return '$startQrCode, $endQrCode, $relativeOffset, $distanceFromCamera, $timestamp';
  }
}
