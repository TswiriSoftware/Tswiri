import 'package:flutter/material.dart';

import 'package:tswiri/views/home_screen.dart';
import 'package:tswiri/views/container/container_screen.dart';
import 'package:tswiri/views/container/create_container_screen.dart';
import 'package:tswiri/views/qr_codes/qr_code_generator_screen.dart';
import 'package:tswiri/views/qr_codes/qr_code_batches_screen.dart';
import 'package:tswiri/views/qr_codes/qr_code_pdf_view.dart';
import 'package:tswiri/views/qr_codes/qr_code_batch_screen.dart';
import 'package:tswiri/views/qr_codes/qr_codes_screen.dart';

class Routes {
  /// [HomeScreen]
  static const String home = '/';

  /// [ContainerScreen]
  static const String container = '/container';

  /// [CreateContainerScreen]
  static const String createContainer = '/createContainer';

  /// [QrCodeGeneratorScreen]
  static const String qrCodeGenerator = '/qrCodeGenerator';

  /// [QrCodeBatchesScreen]
  static const String qrCodeBatches = '/qrCodeBatches';

  /// [QrCodeBatchScreen]
  static const String qrCodeBatch = '/qrCodeBatch';

  /// [QrCodePDFView]
  static const String qrCodePDF = '/qrCodePDF';

  /// [QrCodesScreen]
  static const qrCodesScreen = '/qrCodes';

  static void clearTo(BuildContext context, String route, [Object? arguments]) {
    // Unwind past pages and push given route with arguments
    Navigator.of(context).pushNamedAndRemoveUntil(route, (Route route) => false,
        arguments: arguments);
  }

  static void clearToHome(BuildContext context, [Object? arguments]) {
    clearTo(context, Routes.home, arguments);
  }
}
