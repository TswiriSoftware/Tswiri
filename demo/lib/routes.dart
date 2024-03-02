import 'package:flutter/material.dart';
import 'package:tswiri/views/barcodes/debug_barcode_selector_screen.dart';

import 'package:tswiri/views/home_screen.dart';
import 'package:tswiri/views/container/container_screen.dart';
import 'package:tswiri/views/container/create_container_screen.dart';
import 'package:tswiri/views/barcodes/barcode_generator_screen.dart';
import 'package:tswiri/views/barcodes/barcode_batches_screen.dart';
import 'package:tswiri/views/barcodes/barcode_import_screen.dart';
import 'package:tswiri/views/barcodes/barcode_pdf_screen.dart';
import 'package:tswiri/views/barcodes/barcode_batch_screen.dart';
import 'package:tswiri/views/barcodes/barcodes_screen.dart';
import 'package:tswiri/views/ml_kit/barcode_scanner_screen.dart';
import 'package:tswiri/views/ml_kit/barcode_selector_screen.dart';
import 'package:tswiri_database/collections/collections_export.dart';

class Routes {
  /// [HomeScreen]
  static const home = '/';

  //////////////////
  /// Containers ///

  /// [ContainerScreen]
  static const container = '/container';

  /// [CreateContainerScreen]
  static const createContainer = '/container/create';

  ////////////////
  /// Barcodes ///

  /// [BarcodesScreen]
  static const barcode = '/barcodes';

  /// [BarcodeGeneratorScreen]
  static const barcodeGenerator = '/barcodes/generator';

  /// [BarcodeImportScreen]
  static const barcodeImport = '/barcodes/import';

  /// [BarcodeBatchesScreen]
  static const barcodeBatches = '/barcodes/batches';

  /// [BarcodeBatchScreen]
  static const barcodeBatch = '/barcodes/batch';

  /// [BarcodePdfScreen]
  static const barcodePdf = '/barcodes/pdf';

  /// [DebugBarcodeSelectorScreen]
  static const debugBarcodeSelector = '/barcodes/debug_barcode_selector';

  //////////////
  /// ML Kit ///

  /// [BarcodeScannerScreen]
  static const barcodeScanner = '/ml_kit/barcode_scanner';

  /// [BarcodeSelectorScreen]
  static const barcodeSelector = '/ml_kit/barcode_selector';

  static void clearTo(BuildContext context, String route, [Object? arguments]) {
    // Unwind past pages and push given route with arguments
    Navigator.of(context).pushNamedAndRemoveUntil(route, (Route route) => false,
        arguments: arguments);
  }

  static void clearToHome(BuildContext context, [Object? arguments]) {
    clearTo(context, Routes.home, arguments);
  }

  Map<String, Widget Function(BuildContext)> allRoutes = {
    Routes.home: (context) => const HomeScreen(),

    /// Containers ///
    Routes.container: (context) {
      final container =
          ModalRoute.of(context)!.settings.arguments as CatalogedContainer;

      return ContainerScreen(
        container: container,
      );
    },
    Routes.createContainer: (context) {
      final parentContainer =
          ModalRoute.of(context)!.settings.arguments as CatalogedContainer?;

      return CreateContainerScreen(
        parentContainer: parentContainer,
      );
    },

    /// Barcodes ///
    Routes.barcode: (context) {
      final barcodeBatch =
          ModalRoute.of(context)!.settings.arguments as BarcodeBatch;

      return BarcodesScreen(
        barcodeBatch: barcodeBatch,
      );
    },
    Routes.barcodeGenerator: (context) => const BarcodeGeneratorScreen(),
    Routes.barcodeImport: (context) => const BarcodeImportScreen(),
    Routes.barcodeBatches: (context) => const BarcodeBatchesScreen(),
    Routes.debugBarcodeSelector: (context) {
      return const DebugBarcodeSelectorScreen();
    },
    Routes.barcodePdf: (context) {
      var (size, barcodeUUIDs) =
          ModalRoute.of(context)!.settings.arguments as (double, List<String>);
      return BarcodePdfScreen(
        barcodeUUIDs: barcodeUUIDs,
        size: size,
      );
    },
    Routes.barcodeBatch: (context) {
      final barcodeBatch =
          ModalRoute.of(context)!.settings.arguments as BarcodeBatch;

      return BarcodeBatchScreen(
        barcodeBatch: barcodeBatch,
      );
    },

    /// ML Kit ///
    Routes.barcodeScanner: (context) => const BarcodeScannerScreen(),
    Routes.barcodeSelector: (context) => const BarcodeSelectorScreen(),
  };
}
