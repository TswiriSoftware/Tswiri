import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class QrCode {
  QrCode(@required this.displayValue, @required this.barcodeCenterVector,
      @required this.timestamp);

  final String displayValue;
  final Point barcodeCenterVector; //TODO: Pixels ??
  late double distanceFromCamera; //Unit: millimetres
  final int timestamp; //Timestamp

  @override
  String toString() {
    return '$displayValue, $barcodeCenterVector, $distanceFromCamera, $timestamp';
  }
}

class QrCodeVectors {
  QrCodeVectors(
      @required this.startQrCode,
      @required this.endQrCode,
      @required this.vector,
      @required this.distanceFromCamera,
      @required this.timestamp);

  final String startQrCode;
  final String endQrCode;
  final Point vector; //TODO: vector betweeb qrCodes
  late double distanceFromCamera; //Unit: millimetres
  final int timestamp; //Timestamp

  @override
  String toString() {
    return '$startQrCode, $endQrCode, $vector, $distanceFromCamera, $timestamp';
  }
}

class BarcodeDistanceData {
  BarcodeDistanceData(
    @required this.timestamp,
    @required this.imageSize,
    @required this.distance,
  );

  final int timestamp;
  final double imageSize;
  final double distance;

  @override
  String toString() {
    return '$timestamp, $imageSize, $distance';
  }
}

class dataPoints {
  dataPoints(@required this.offset);
  final Offset offset;
}
