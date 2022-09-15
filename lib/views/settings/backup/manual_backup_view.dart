// ignore_for_file: unused_import

import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sunbird/globals/globals_export.dart';
import 'package:sunbird/isar/isar_database.dart';
import 'package:sunbird/functions/backup_restore_functions.dart';
import 'package:tswiri_base/colors/colors.dart';
import 'package:tswiri_base/widgets/custom_text_field.dart';

class BackupView extends StatefulWidget {
  const BackupView({Key? key}) : super(key: key);

  @override
  State<BackupView> createState() => _BackupViewState();
}

class _BackupViewState extends State<BackupView> {
  //Shows if the app is busy with a process.
  bool _isBusy = false;
  final TextEditingController _textFieldController = TextEditingController();
  double progress = 0.0;
  File? selectedFile;

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
      centerTitle: true,
    );
  }

  Widget _body() {
    if (_isBusy) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            Text("${progress.toStringAsFixed(2)}%")
          ],
        ),
      );
    } else {
      return SingleChildScrollView(
        child: Column(
          children: [
            _newBackup(),
            _restoreBackup(),
          ],
        ),
      );
    }
  }

  Widget _newBackup() {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.backup_sharp),
        title: Text(
          'Create backup',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        trailing: ElevatedButton(
          onPressed: () async {
            setIsBusy();

            String? fileName = await _getBackupFileName();

            if (fileName != null) {
              File? file = await createBackupFile(
                fileName: fileName,
                progress: (value) {
                  setState(() {
                    progress = value;
                  });
                },
              );

              if (file != null) {
                await Share.shareFiles([file.path], text: 'sunbird_backup');
              } else if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Backup Failed',
                    ),
                  ),
                );
              }
            }

            progress = 0.0;
            setIsBusy();
          },
          child: Text('Create Backup',
              style: Theme.of(context).textTheme.bodyMedium),
        ),
      ),
    );
  }

  Widget _restoreBackup() {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(
              Icons.restore,
            ),
            title: selectedFile == null
                ? Text(
                    'Select a file',
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                : Text(selectedFile!.path.split('/').last),
            trailing: ElevatedButton(
              onPressed: () async {
                await selectBackupFile();
              },
              child: Text(
                selectedFile == null ? 'Select' : 'Change',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          const Divider(),
          selectedFile != null
              ? ElevatedButton(
                  onPressed: () async {
                    setIsBusy();
                    if (selectedFile != null) {
                      bool? restored = await restoreBackupFile(
                          backupFile: selectedFile!,
                          progress: (value) {
                            setState(() {
                              progress = value;
                            });
                          });

                      if (mounted) {
                        switch (restored) {
                          case null:
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'unkown error',
                                ),
                              ),
                            );
                            break;
                          case true:
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Success',
                                ),
                              ),
                            );
                            break;
                          case false:
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'File error',
                                ),
                              ),
                            );
                            break;
                          default:
                        }
                      }
                    }
                    setIsBusy();
                  },
                  child: Text(
                    'Restore',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  ///Sets the isBusy variable.
  void setIsBusy() {
    setState(() {
      _isBusy = !_isBusy;
    });
  }

  ///Alert dialog requesting file name.
  Future<String?> _getBackupFileName() async {
    _textFieldController.text = generateBackupFileName();
    return await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Enter backup name',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        content: Row(
          children: [
            Flexible(
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: background[500],
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  labelText: 'name',
                  labelStyle:
                      const TextStyle(fontSize: 15, color: Colors.white),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: sunbirdOrange)),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: sunbirdOrange)),
                ),
                controller: _textFieldController,
              ),
            ),
            const Text('.zip'),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, null),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(
                  context,
                  _textFieldController.text.isNotEmpty
                      ? _textFieldController.text
                      : null);
            },
            child: const Text('OK'),
          ),
        ],
        actionsAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }

  ///Select the backup file.
  Future<void> selectBackupFile() async {
    setState(() {
      selectedFile = null;
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
