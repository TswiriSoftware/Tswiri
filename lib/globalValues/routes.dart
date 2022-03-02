import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';

import '../main.dart';
import '../sunbirdViews/barcodeControlPanel/all_barcodes.dart';
import '../sunbirdViews/barcodeControlPanel/scan_barcode_view.dart';
import '../sunbirdViews/barcodeGeneration/barcode_generation_range_selector_view.dart';
import '../sunbirdViews/barcodeNavigation/barcode_selection_view.dart';
import '../sunbirdViews/barcodeNavigation/navigationToolsView/barcode_navigation_tools_view.dart';
import '../sunbirdViews/barcodeScanning/barcode_scanner_isolate_view.dart';
import '../sunbirdViews/barcodeScanning/real_barcode_position_database_view.dart';
import '../sunbirdViews/barcodeScanning/real_barcode_position_database_visualization_view.dart';
import '../sunbirdViews/barcodeScanning/scanningToolsView/barcode_scanning_tools_view.dart';
import '../sunbirdViews/cameraCalibration/calibrationToolsView/camera_calibration_tools_view.dart';
import '../sunbirdViews/cameraCalibration/calibration_data_visualizer_view.dart';
import '../sunbirdViews/cameraCalibration/camera_calibration_view.dart';

//WIP//
//TODO: list all routes @049er

var allRoutes = <String, WidgetBuilder>{
  //Main Screen
  '/': (context) => const MyApp(),

  //////////Barcode Scanning//////////

  ///Displays all barcode scanning tools.
  '/BarcodeScanningToolsView': (context) => const BarcodeScanningToolsView(),

  ///Camera widget that allows for scanning.
  '/BarcodeScannerView': (context) => const BarcodeScannerIsolateView(),

  ///Shows a list of all real barcode positions.
  '/RealBarcodePositionDatabaseView': (context) =>
      const RealBarcodePositionDatabaseView(),

  ///Graphical display of all real barcode Positions
  '/RealBarcodePositionDatabaseVisualizationView': (context) =>
      const RealBarcodePositionDatabaseVisualizationView(),

  ////////////////////////////////////

  /////////Barcode Navigation/////////

  ///Shows all barcode navigation tools.
  '/BarcodeNavigationView': (context) => const BarcodeNavigationToolsView(),

  ///Shows a list of all scanned barcodes for the user to select from.
  '/BarcodeSelectionView': (context) => const BarcodeSelectionView(),
  ////////////////////////////////////

  /////////Barcode Generation/////////

  ///Allows the user to select a range of barcodes to generate.
  '/BarcodeGenerationRangeSelectorView': (context) =>
      const BarcodeGenerationRangeSelectorView(),

  ////////////////////////////////////

  ///////Barcode Control Panel////////

  ///Shows a list of all generated barcodes, and allows the user to select one.
  '/AllBarcodesView': (context) => const AllBarcodesView(),

  ///Allows the user to scan a single barcode or multiple barcodes and then select from a barcode from that.
  '/ScanBarcodeView': (context) => const ScanBarcodeView(
        color: brightOrange,
      ),

  ////////////////////////////////////

  /////////Camera Calibration/////////

  ///Shows camera calibration tools.
  '/CameraCalibrationToolsView': (context) =>
      const CameraCalibrationToolsView(),

  ///This is where the user calibrates the camera.
  '/CameraCalibrationView': (context) => const CameraCalibrationView(),

  ///Graphical display of camera calibration data points.
  '/CalibrationDataVisualizerView': (context) =>
      const CalibrationDataVisualizerView(),

  ////////////////////////////////////
};
