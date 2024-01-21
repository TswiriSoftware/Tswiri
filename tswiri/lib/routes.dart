import 'package:flutter/material.dart';

import 'package:tswiri/views/home_screen.dart';
import 'package:tswiri/views/container/cataloged_container_screen.dart';
import 'package:tswiri/views/container/create_cataloged_container_screen.dart';
import 'package:tswiri/views/qr_codes/qr_code_generator_screen.dart';
import 'package:tswiri/views/qr_codes/qr_code_batches_screen.dart';

class Routes {
  /// [HomeScreen]
  static const String home = '/';

  /// [CatalogedContainerScreen]
  static const String catalogedContainer = '/catalogedContainer';

  /// [CreateCatalogedContainerScreen]
  static const String createCatalogedContainer = '/createCatalogedContainer';

  /// [QrCodeGeneratorScreen]
  static const String qrCodeGenerator = '/qrCodeGenerator';

  /// [QrCodeBatchesScreen]
  static const String qrCodes = '/qrCodes';

  static void clearTo(BuildContext context, String route, [Object? arguments]) {
    // Unwind past pages and push given route with arguments
    Navigator.of(context).pushNamedAndRemoveUntil(route, (Route route) => false, arguments: arguments);
  }

  static void clearToHome(BuildContext context, [Object? arguments]) {
    clearTo(context, Routes.home, arguments);
  }
}
