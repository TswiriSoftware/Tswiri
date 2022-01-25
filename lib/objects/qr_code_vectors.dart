import 'package:flutter/material.dart';

class QrCodesOffset {
  QrCodesOffset(
      {required this.startQrCode,
      required this.endQrCode,
      required this.relativeOffset,
      required this.distanceFromCamera,
      required this.timestamp});

  final String startQrCode;
  final String endQrCode;
  final Offset relativeOffset; //TODO: Offset betweeb qrCodes
  late double distanceFromCamera; //Unit: millimetres
  final int timestamp; //Timestamp

  @override
  String toString() {
    return '$startQrCode, $endQrCode, $relativeOffset, $distanceFromCamera, $timestamp';
  }
}
