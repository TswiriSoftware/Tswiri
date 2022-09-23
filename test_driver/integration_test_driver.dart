import 'dart:io';

import 'package:integration_test/integration_test_driver.dart';

Future<void> main() async {
  await Process.run(
    'adb',
    [
      'shell',
      'pm',
      'grant',
      'com.nanoedge.tswiri',
      'android.permission.WRITE_EXTERNAL_STORAGE'
    ],
  );

  await Process.run(
    'adb',
    [
      'shell',
      'pm',
      'grant',
      'com.nanoedge.tswiri',
      'android.permission.READ_EXTERNAL_STORAGE'
    ],
  );

  await Process.run(
    'adb',
    [
      'shell',
      'pm',
      'grant',
      'com.nanoedge.tswiri',
      'android.permission.ACCESS_MEDIA_LOCATION'
    ],
  );

  // TODO: Add more permissions as required
  await integrationDriver();
}


/// flutter drive --driver=test_driver/integration_test_driver.dart --target=integration_test/integration_test.dart