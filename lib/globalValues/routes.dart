import 'package:flutter/material.dart';

import '../main.dart';
import '../sunbirdViews/barcodeControlPanel/all_barcodes.dart';
import '../sunbirdViews/barcodeGeneration/barcode_generation_range_selector_view.dart';
import '../sunbirdViews/barcodeNavigation/navigationToolsView/barcode_navigation_tools_view.dart';
import '../sunbirdViews/barcodeScanning/barcode_scanner_data_processing.dart';
import '../sunbirdViews/barcodeScanning/barcode_scanner_view.dart';
import '../sunbirdViews/barcodeScanning/real_barcode_position_database_view.dart';
import '../sunbirdViews/barcodeScanning/real_barcode_position_database_visualization_view.dart';
import '../sunbirdViews/barcodeScanning/scanningToolsView/barcode_scanning_tools_view.dart';
import '../sunbirdViews/cameraCalibration/calibrationToolsView/camera_calibration_tools_view.dart';

var allRoutes = <String, WidgetBuilder>{
  //Main Screen
  '/': (context) => const MyApp(),

  //Barcode Scanning//
  //1. Displays all barcode scanning tools.
  '/BarcodeScanningToolsView': (context) => const BarcodeScanningToolsView(),
  //2. Camera widget that allows for scanning.
  '/BarcodeScannerView': (context) => const BarcodeScannerView(),

  '/RealBarcodePositionDatabaseView': (context) =>
      const RealBarcodePositionDatabaseView(),
  '/RealBarcodePositionDatabaseVisualizationView': (context) =>
      const RealBarcodePositionDatabaseVisualizationView(),

  //Barcode Navigation
  '/BarcodeNavigationView': (context) => const BarcodeNavigationView(),

  //Barcode Generation
  '/BarcodeGenerationRangeSelectorView': (context) =>
      const BarcodeGenerationRangeSelectorView(),

  //Barcode Control Panel
  '/AllBarcodesView': (context) => const AllBarcodesView(),

  //Camera Calibration
  '/CameraCalibrationToolsView': (context) =>
      const CameraCalibrationToolsView(),
};