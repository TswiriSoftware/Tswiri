import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tswiri_database_interface/functions/backup/backup_restore_functions.dart';
import 'package:share_plus/share_plus.dart';
import 'package:file_picker/file_picker.dart';

class ImportExportView extends StatefulWidget {
  const ImportExportView({super.key});

  @override
  State<ImportExportView> createState() => _ImportExportViewState();
}

class _ImportExportViewState extends State<ImportExportView> {
  bool _isBusy = false;
  final TextEditingController _textFieldController = TextEditingController();
  File? selectedFile;

  String? currentEvent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 10,
      title: const Text(
        'Import / Export',
      ),
    );
  }

  Widget _body() {
    if (_isBusy) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Theme.of(context).colorScheme.secondary,
            ),
            Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  currentEvent ?? 'busy',
                ),
              ),
            ),
          ],
        ),
      );
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          _exportData(),
          _importFile(),
        ],
      ),
    );
  }

  Widget _exportData() {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: const Icon(Icons.backup_sharp),
        title: Text(
          'Export Data',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        trailing: OutlinedButton(
          onPressed: () async {
            await _exportFiles();
          },
          child: const Text('Export'),
        ),
      ),
    );
  }

  Future<void> _exportFiles() async {
    setIsBusy();

    String? fileName = await _getExportedFileName();

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
        await Share.shareXFiles([XFile(file.path)], text: 'sunbird_backup');
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
  }

  Widget _importFile() {
    return Card(
      elevation: 5,
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
              trailing: OutlinedButton(
                onPressed: () async {
                  await selectImportFile();
                },
                child: Text(
                  selectedFile == null ? 'Select' : 'Change',
                ),
              )),
          selectedFile != null ? const Divider() : const SizedBox.shrink(),
          selectedFile != null
              ? OutlinedButton(
                  onPressed: () async {
                    await _restoreFile();
                  },
                  child: const Text('Import'))
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Future<void> _restoreFile() async {
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
  }

  ///Sets the isBusy variable.
  void setIsBusy() {
    setState(() {
      _isBusy = !_isBusy;
    });
  }

  ///Alert dialog requesting file name.
  Future<String?> _getExportedFileName() async {
    _textFieldController.text = generateBackupFileName();
    return await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Export file name',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        content: Row(
          children: [
            Flexible(
              child: TextFormField(
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
  Future<void> selectImportFile() async {
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
