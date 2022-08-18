// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sunbird/globals/globals_export.dart';
import 'package:sunbird/isar/isar_database.dart';
import 'package:sunbird/views/settings/manual_backup/create_backup_isolate.dart';
import 'package:sunbird/views/settings/manual_backup/restore_backup_isolate.dart';

class ManualBackupView extends StatefulWidget {
  const ManualBackupView({Key? key}) : super(key: key);

  @override
  State<ManualBackupView> createState() => _ManualBackupViewState();
}

class _ManualBackupViewState extends State<ManualBackupView> {
  bool _isBusy = false;

  File? selectedFile;
  bool canRestore = false;

  //UI- Port.
  final ReceivePort _uiPort1 = ReceivePort('create backup');
  final ReceivePort _uiPort2 = ReceivePort('restore backup');

  //Isolates.
  FlutterIsolate? _backupIsolate;
  FlutterIsolate? _restoreIsolate;

  @override
  void initState() {
    _uiPort1.listen((message) {
      if (message[0] == 'done') {
        killBackupIsolate();
      } else if (message[0] == 'path') {
        shareBackup(message[1]);
      }
    });

    _uiPort2.listen((message) {
      //TODO: loading bar.
      if (message[0] == 'done') {
        killRestoreisolate();
      } else if (message[0] == 'error') {
        switch (message[1]) {
          case 'file_error':
            log('file_error');
            killRestoreisolate();
            break;
          case 'version_error':
            log('version_error');
            killRestoreisolate();
            break;
          default:
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
        title: Text(
          'Backup',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true);
  }

  Widget _body() {
    return _isBusy
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              _backupCard(),
              _restoreCard(),
            ],
          );
  }

  Widget _backupCard() {
    return Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _backupButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _backupButton() {
    return ElevatedButton(
      onPressed: () async {
        try {
          createBackup();
        } catch (exception, stackTrace) {
          await Sentry.captureException(
            exception,
            stackTrace: stackTrace,
          );
        }
      },
      child: Text(
        "Create Backup",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  Widget _restoreCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                selectedFile != null
                    ? Card(
                        color: background[300],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            selectedFile!.path.split('/').last,
                          ),
                        ),
                      )
                    : Text(
                        'Select File (zip)',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                selectBackupFile();
              },
              child: Text(
                'select',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const Divider(),
            selectedFile != null
                ? ElevatedButton(
                    onPressed: () {
                      if (selectedFile != null) {
                        _restore(selectedFile!);
                      }
                    },
                    child: Text(
                      'Restore',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  ///Create the backup.
  void createBackup() async {
    await isar!.close();

    setState(() {
      _isBusy = true;
    });

    //Temporary Directory.
    Directory temporaryDirectory = await getTemporaryDirectory();

    _backupIsolate = await FlutterIsolate.spawn(
      createBackupIsolate,
      [
        _uiPort1.sendPort,
        isarDirectory!.path,
        temporaryDirectory.path,
        isarVersion.toString(),
        photoDirectory!.path,
      ],
    );
  }

  ///Kill the backup isolate.
  void killBackupIsolate() {
    if (_backupIsolate != null) {
      _backupIsolate!.kill();
      setState(() {
        _backupIsolate = null;
      });
      log('killed backupIsolate');
      setState(() {
        _isBusy = false;
      });
    }
    if (!isar!.isOpen) {
      isar = initiateIsar(inspector: false);
    }
  }

  ///Share the backupFile.
  void shareBackup(String backupPath) async {
    await Share.shareFiles([backupPath], text: 'sunbird_backup');
  }

  ///Select the backup file.
  void selectBackupFile() async {
    setState(() {
      selectedFile = null;
      canRestore = false;
      // unzippedDirectory = null;
    });

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['zip'],
      type: FileType.custom,
    );

    if (result != null) {
      selectedFile = File(result.files.single.path!);
    }

    setState(() {});
  }

  ///Restores user data from a zip file (Directory unzippedDirectory)
  void _restore(File selectedFile) async {
    setState(() {
      _isBusy = true;
    });

    await isar!.close();

    //Temporary Directory.
    Directory temporaryDirectory = await getTemporaryDirectory();

    _restoreIsolate = await FlutterIsolate.spawn(
      restoreBackupIsolate,
      [
        _uiPort2.sendPort,
        isarDirectory!.path,
        temporaryDirectory.path,
        isarVersion.toString(),
        photoDirectory!.path,
        selectedFile.path,
        (await getExternalStorageDirectory())!.path,
      ],
    );
  }

  ///Kill the restoreIsolate.
  void killRestoreisolate() {
    if (_restoreIsolate != null) {
      _restoreIsolate!.kill();
      setState(() {
        _restoreIsolate = null;
      });
      log('killed restoreIsolate');
      setState(() {
        _isBusy = false;
      });
    }
    if (!isar!.isOpen) {
      isar = initiateIsar(inspector: false);
    }
  }
}
