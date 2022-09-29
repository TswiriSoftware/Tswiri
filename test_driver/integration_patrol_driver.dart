// import 'dart:io';

// import 'package:integration_test/integration_test_driver.dart';
// import 'package:patrol/patrol_drive_helper.dart';

// // Runs on our machine. Knows nothing about the app being tested.
// Future<void> main() async {
//   await Process.run(
//     'adb',
//     [
//       'shell',
//       'pm',
//       'grant',
//       'com.nanoedge.tswiri',
//       'android.permission.WRITE_EXTERNAL_STORAGE'
//     ],
//   );

//   await Process.run(
//     'adb',
//     [
//       'shell',
//       'pm',
//       'grant',
//       'com.nanoedge.tswiri',
//       'android.permission.READ_EXTERNAL_STORAGE'
//     ],
//   );

//   await Process.run(
//     'adb',
//     [
//       'shell',
//       'pm',
//       'grant',
//       'com.nanoedge.tswiri',
//       'android.permission.ACCESS_MEDIA_LOCATION'
//     ],
//   );

//   final patrolDriveHelper = PatrolDriveHelper();
//   while (!await patrolDriveHelper.isRunning()) {
//     print('Waiting for patrol automation server...');
//     await Future<void>.delayed(const Duration(seconds: 1));
//   }
//   print('Patrol automation server is running, starting test drive');
//   try {
//     await integrationDriver();
//   } finally {
//     print('Stopping Patrol automation server');
//     await patrolDriveHelper.stop();
//   }
// }
