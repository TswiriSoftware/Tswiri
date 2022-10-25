import 'package:flutter/material.dart';
// import 'package:tswiri_database/models/backup/google_drive_manager.dart';
import 'package:googleapis/drive/v3.dart' as drive;

class GoogleDriveBackupView extends StatefulWidget {
  const GoogleDriveBackupView({super.key});

  @override
  State<GoogleDriveBackupView> createState() => _GoogleDriveBackupViewState();
}

class _GoogleDriveBackupViewState extends State<GoogleDriveBackupView> {
  ValueNotifier<double> progressNotifier = ValueNotifier(0);
  // GoogleDriveManager? _backup;
  Future<drive.File?>? latestFile;
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
        'Google Drive Backup',
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: const [
          Center(
            child: Text('Coming Soon'),
          ),
        ],
      ),
    );
  }
}
