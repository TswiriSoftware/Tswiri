import 'package:flutter/material.dart';
import 'package:sunbird/views/settings/backup/google_drive_view.dart';
import 'package:sunbird/views/settings/backup/manual_backup_view.dart';
import 'package:sunbird/views/utilities/navigator_card.dart';

class BackupOptionsView extends StatefulWidget {
  const BackupOptionsView({Key? key}) : super(key: key);

  @override
  State<BackupOptionsView> createState() => _BackupOptionsViewState();
}

class _BackupOptionsViewState extends State<BackupOptionsView> {
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
        'Backup Options',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      centerTitle: true,
    );
  }

  Widget _body() {
    return Center(
      child: GridView.count(
        padding:
            const EdgeInsets.only(top: 8.0, bottom: 100, left: 8, right: 8),
        crossAxisCount: 2,
        children: const [
          NavigatorCard(
            label: 'Manual Backup',
            icon: Icons.backup,
            viewPage: ManualBackupView(),
          ),
          NavigatorCard(
            label: 'Google Drive Backup',
            icon: Icons.drive_folder_upload,
            viewPage: GoogleDriveView(),
          ),
        ],
      ),
    );
  }
}
