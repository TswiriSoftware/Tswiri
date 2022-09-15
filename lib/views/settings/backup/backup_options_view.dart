import 'package:tswiri/views/settings/backup/google_drive_manager_view.dart';
import 'package:tswiri/views/settings/backup/manual_backup_view.dart';
import 'package:flutter/material.dart';
import 'package:tswiri_widgets/widgets/general/navigation_card.dart';

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
          NavigationCard(
            label: 'Manual Backup',
            icon: Icons.backup,
            viewPage: BackupView(),
          ),
          NavigationCard(
            label: 'Google Drive Backup',
            icon: Icons.drive_folder_upload,
            viewPage: GoogleDriveView(),
          ),
        ],
      ),
    );
  }
}
