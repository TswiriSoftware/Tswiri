// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sunbird/globals/globals_export.dart';
import 'package:sunbird/isar/isar_database.dart';
import 'package:sunbird/views/settings/backup/classes/backup.dart';

class ManualBackupView extends StatefulWidget {
  const ManualBackupView({Key? key}) : super(key: key);

  @override
  State<ManualBackupView> createState() => _ManualBackupViewState();
}

class _ManualBackupViewState extends State<ManualBackupView> {
  bool _isBusy = false;

  File? selectedFile;
  bool canRestore = false;

  ValueNotifier<double> progressNotifier = ValueNotifier(0);
  late final Backup _backup = Backup(progressNotifier: progressNotifier);

  @override
  void initState() {
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
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                ValueListenableBuilder(
                  valueListenable: progressNotifier,
                  builder: ((context, double value, child) {
                    log(value.toString());
                    return Text(
                      '${value.toStringAsFixed(2)}%',
                    );
                  }),
                ),
              ],
            ),
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
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        setState(() {
                          _isBusy = true;
                        });
                        String filePath = await _backup.createBackupFile();
                        await shareBackup(filePath);
                        setState(() {
                          _isBusy = false;
                        });
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
                  ),
                ],
              ),
            ],
          ),
        ),
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
                    onPressed: () async {
                      if (selectedFile != null) {
                        setState(() {
                          _isBusy = true;
                        });
                        await _backup.restoreBackupFile(selectedFile!.path);

                        await isar!.close();
                        isar = initiateIsar();

                        setState(() {
                          _isBusy = false;
                        });
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

  ///Share the backupFile.
  Future<void> shareBackup(String backupPath) async {
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
}
