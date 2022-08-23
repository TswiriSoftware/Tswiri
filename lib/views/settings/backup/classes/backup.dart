import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sunbird/globals/globals_export.dart';
import 'package:sunbird/isar/isar_database.dart';
import 'package:sunbird/views/settings/backup/isolates/create_backup_isolate.dart';
import 'package:sunbird/views/settings/backup/isolates/restore_backup_isolate.dart';

///This is used to create and restore backup files using isolates.
class Backup {
  Backup({
    required this.progressNotifier,
  });

  ///Progress value notifier. (This will update giving the progress of the process in %)
  ValueNotifier<double> progressNotifier;

  ///Creates the backup and returns the path of the backup.
  Future<String> createBackupFile() async {
    FlutterIsolate? _isolate;
    ReceivePort _uiPort = ReceivePort();

    try {
      await isar!.close();
      //Temporary Directory.
      Directory temporaryDirectory = await getTemporaryDirectory();
      _isolate = await FlutterIsolate.spawn(
        createBackupIsolate,
        [
          _uiPort.sendPort,
          isarDirectory!.path,
          temporaryDirectory.path,
          isarVersion.toString(),
          photoDirectory!.path,
        ],
      );
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }

    var completer = Completer<String>();

    _uiPort.listen((message) {
      switch (message[0]) {
        case 'done':
          killIsolate(_isolate);
          break;
        case 'path':
          completer.complete(message[1].toString());
          break;
        case 'progress':
          progressNotifier.value = message[1] as double;
          break;
        default:
      }
    });

    return completer.future;
  }

  ///Restores a backupfile.
  Future<bool> restoreBackupFile(String filePath) async {
    FlutterIsolate? _isolate;
    ReceivePort _uiPort = ReceivePort();

    // /data/user/0/com.scholtz.sunbird/cache/sunbird_backup_2022_08_22_10_40_v1.zip

    if (isar!.isOpen) {
      await isar!.close();
    }

    //Temporary Directory.
    Directory temporaryDirectory = await getTemporaryDirectory();

    _isolate = await FlutterIsolate.spawn(
      restoreBackupIsolate,
      [
        _uiPort.sendPort,
        isarDirectory!.path,
        temporaryDirectory.path,
        isarVersion.toString(),
        photoDirectory!.path,
        filePath,
        (await getExternalStorageDirectory())!.path,
      ],
    );

    var completer = Completer<bool>();

    _uiPort.listen((message) {
      if (message[0] == 'done') {
        completer.complete(true);
        killIsolate(_isolate);
      } else if (message[0] == 'error') {
        switch (message[1]) {
          case 'file_error':
            log('file_error');
            killIsolate(_isolate);
            completer.complete(false);
            break;
          case 'version_error':
            log('version_error');
            killIsolate(_isolate);
            completer.complete(false);
            break;
          default:
        }
      } else if (message[0] == 'progress') {
        progressNotifier.value = message[1] as double;
      }
    });

    return completer.future;
  }

  ///Kills an isolate and re-opens isar.
  void killIsolate(FlutterIsolate? isolate) {
    if (isolate != null) {
      isolate.kill();
    }
    if (!isar!.isOpen) {
      isar = initiateIsar(inspector: false);
      log('opening isar');
    }
  }
}
