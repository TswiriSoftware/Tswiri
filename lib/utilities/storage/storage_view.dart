import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tswiri_database/functions/general/clear_temp_directory.dart';
import 'package:tswiri_database/functions/general/get_directory_size.dart';
import 'google_drive_backup_view.dart';
import 'import_export_view.dart';

class StorageView extends StatefulWidget {
  const StorageView({Key? key}) : super(key: key);

  @override
  State<StorageView> createState() => StorageViewState();
}

class StorageViewState extends State<StorageView> {
  late Future<List<int>> directorySizes = getDirectoriesSize();

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
      title: const Text('Storage'),
      centerTitle: true,
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          _googleDriveBackup(),
          _importExport(),
          _appStorage(),
        ],
      ),
    );
  }

  FutureBuilder<List<int>> _appStorage() {
    return FutureBuilder<List<int>>(
      future: directorySizes,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          List<int> directoryData = snapshot.data!;
          return Card(
            elevation: 5,
            child: Column(
              children: [
                const ListTile(
                  title: Text('App Storage'),
                  leading: Icon(Icons.storage_rounded),
                ),
                ListTile(
                  title: const Text('App Data'),
                  subtitle: directoryData[0] <= 1000000
                      ? Text('${directoryData[0]}B')
                      : directoryData[0] >= 1000000
                          ? Text(
                              '${(directoryData[0] / 1000000).toStringAsFixed(2)}MB')
                          : Text(
                              '${(directoryData[0] / 1000000000).toStringAsFixed(2)}GB'),
                  leading: const Icon(Icons.data_array_rounded),
                ),
                ListTile(
                  title: const Text('Cache'),
                  subtitle: directoryData[1] <= 1000000
                      ? Text('${directoryData[1]}B')
                      : directoryData[1] >= 1000000
                          ? Text(
                              '${(directoryData[1] / 1000000).toStringAsFixed(2)}MB')
                          : Text(
                              '${(directoryData[1] / 1000000000).toStringAsFixed(2)}GB'),
                  leading: const Icon(
                    Icons.cached_rounded,
                  ),
                  trailing: IconButton(
                    onPressed: () async {
                      await clearTemporaryDirectory();
                      setState(() {
                        directorySizes = getDirectoriesSize();
                      });
                    },
                    icon: const Icon(Icons.clear_rounded),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  OpenContainer _googleDriveBackup() {
    return OpenContainer(
      openColor: Colors.transparent,
      closedColor: Colors.transparent,
      transitionType: ContainerTransitionType.fade,
      closedBuilder: (context, action) {
        return Card(
          elevation: 5,
          child: ListTile(
            title: const Text('Google Drive Backup'),
            leading: const Icon(Icons.backup_rounded),
            onTap: action,
          ),
        );
      },
      onClosed: (_) {
        setState(() {
          directorySizes = getDirectoriesSize();
        });
      },
      openBuilder: (context, _) => const GoogleDriveBackupView(),
    );
  }

  OpenContainer _importExport() {
    return OpenContainer(
      openColor: Colors.transparent,
      closedColor: Colors.transparent,
      transitionType: ContainerTransitionType.fade,
      closedBuilder: (context, action) {
        return Card(
          elevation: 5,
          child: ListTile(
            title: const Text('Import/Export'),
            leading: const Icon(Icons.import_export_rounded),
            onTap: action,
          ),
        );
      },
      onClosed: (_) {
        setState(() {
          directorySizes = getDirectoriesSize();
        });
      },
      openBuilder: (context, _) => const ImportExportView(),
    );
  }

  Future<List<int>> getDirectoriesSize() async {
    return [
      getDirectorySize((await getApplicationSupportDirectory())),
      getDirectorySize((await getTemporaryDirectory())),
    ];
  }
}
