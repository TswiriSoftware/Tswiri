// ignore_for_file: unused_import

import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tswiri_database/functions/backup/backup_restore_functions.dart';
import 'package:tswiri_widgets/colors/colors.dart';

class BackupView extends StatefulWidget {
  const BackupView({Key? key}) : super(key: key);

  @override
  State<BackupView> createState() => _BackupViewState();
}

class _BackupViewState extends State<BackupView> {
  //Shows if the app is busy with a process.
  bool _isBusy = false;
  final TextEditingController _textFieldController = TextEditingController();
  File? selectedFile;

  String? currentEvent;

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
      actions: [
        IconButton(
          onPressed: () {
            //TODO: Inform user that restoring large files can take a long time.
          },
          icon: const Icon(Icons.info),
        )
      ],
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
            Card(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                currentEvent ?? 'busy',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            )),
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
                progressCallback: (event) {
                  setState(() {
                    currentEvent = event;
                  });
                },
                fileName: fileName,
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
                        progressCallback: (event) {
                          setState(() {
                            currentEvent = event;
                          });
                        },
                      );

                      setState(() {
                        currentEvent = null;
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
                      borderSide: BorderSide(color: tswiriOrange)),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: tswiriOrange)),
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
      _isBusy = true;
      currentEvent = 'loading';
    });

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['zip'],
      type: FileType.custom,
    );

    if (result != null) {
      selectedFile = File(result.files.single.path!);
    }

    setState(() {
      _isBusy = false;
      currentEvent = null;
    });
  }
}
