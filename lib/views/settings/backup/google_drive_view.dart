import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:sunbird/isar/isar_database.dart';
import 'package:sunbird/views/settings/backup/classes/google_drive_backup.dart';
import 'package:googleapis/drive/v3.dart' as drive;

class GoogleDriveView extends StatefulWidget {
  const GoogleDriveView({Key? key}) : super(key: key);

  @override
  State<GoogleDriveView> createState() => _GoogleDriveViewState();
}

GoogleSignInAccount? _currentUser;

class _GoogleDriveViewState extends State<GoogleDriveView> {
  ValueNotifier<double> progressNotifier = ValueNotifier(0);
  GoogleDriveBackup? _backup;
  Future<drive.File?>? latestFile;

  bool _isBusy = false;
  String process = '';

  @override
  void initState() {
    googleSignIn.signInSilently();
    initiateDriveApi();
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
        'Google Drive',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      leading: IconButton(
        onPressed: () {
          if (!_isBusy) {
            Navigator.pop(context);
          }
        },
        icon: const Icon(
          Icons.arrow_back,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.info,
          ),
        ),
      ],
      centerTitle: true,
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _currentUser != null && !_isBusy ? _singedIn() : _signIn(),
          _isBusy
              ? Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(process),
                          const SizedBox(
                            height: 25,
                          ),
                          const CircularProgressIndicator(),
                        ],
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _singedIn() {
    return Card(
      child: Column(
        children: [
          _userTile(),
          const Divider(),
          _latestFile(),
          const Divider(),
          _restore(),
        ],
      ),
    );
  }

  Widget _userTile() {
    return ListTile(
      leading: GoogleUserCircleAvatar(
        identity: _currentUser!,
      ),
      title: Text(_currentUser!.displayName ?? ''),
      subtitle: Text(_currentUser!.email),
      trailing: IconButton(
        onPressed: () {
          _handleSignOut();
        },
        icon: const Icon(Icons.logout),
      ),
    );
  }

  Widget _latestFile() {
    return Builder(builder: (context) {
      if (_backup != null) {
        return FutureBuilder<drive.File?>(
          future: latestFile,
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              DateTime? backupTime = snapshot.data!.createdTime?.toLocal();
              return ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.backup_sharp),
                ),
                title: Text(
                  'Last Backup',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                subtitle: Text(backupTime != null
                    ? DateFormat('yyyy-MM-dd  kk:mm')
                        .format(backupTime)
                        .toString()
                    : 'cannot retrive time'),
                trailing: IconButton(
                  onPressed: () async {
                    setState(() {
                      _isBusy = true;
                    });

                    setProcess('Creating new backup');

                    String filePath = await _backup!.createBackupFile();
                    log(filePath.toString());

                    setProcess('Uploading');

                    bool uploaded = await _backup!.uploadFile(File(filePath));

                    setProcess('done');

                    await Future.delayed(const Duration(milliseconds: 200));

                    latestFile = _backup!.getLatestBackup();

                    setState(() {
                      _isBusy = false;
                    });
                  },
                  icon: const Icon(Icons.upload),
                ),
              );
            } else {
              return ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _isBusy = true;
                  });

                  setProcess('Creating new backup');

                  String filePath = await _backup!.createBackupFile();
                  log(filePath.toString());

                  setProcess('Uploading');

                  bool uploaded = await _backup!.uploadFile(File(filePath));

                  setProcess('done');

                  await Future.delayed(const Duration(milliseconds: 200));

                  latestFile = _backup!.getLatestBackup();

                  setState(() {
                    _isBusy = false;
                  });
                },
                child: const Text('Create backup'),
              );
            }
          },
        );
      } else {
        return const CircularProgressIndicator();
      }
    });
  }

  Widget _restore() {
    return Builder(builder: (context) {
      if (_backup != null) {
        return FutureBuilder<drive.File?>(
          future: latestFile,
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.cloud_download),
                ),
                title: Text(
                  'Restore',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                subtitle: Text(
                  snapshot.data?.name.toString() ?? 'cannot retrive name',
                ),
                trailing: IconButton(
                  onPressed: () async {
                    //TODO: download and restore last backup.
                    //TODO:

                    bool? approved = await showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Restore'),
                        content: const Text(
                            'Are you sure you want to restore from google drive?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text('OK'),
                          ),
                        ],
                        actionsAlignment: MainAxisAlignment.spaceBetween,
                      ),
                    );

                    if (approved != null && approved == true) {
                      setState(() {
                        _isBusy = true;
                      });

                      setProcess('Downloading');
                      File? downloadedFile =
                          await _backup!.downloadFile(snapshot.data!);

                      if (downloadedFile != null) {
                        setProcess('Restoring');
                        await _backup!.restoreBackupFile(downloadedFile.path);
                      }

                      await isar!.close();
                      isar = initiateIsar();

                      setState(() {
                        _isBusy = false;
                      });
                    }
                  },
                  icon: const Icon(Icons.restore),
                ),
              );
            } else {
              return Text('no backups found');
            }
          },
        );
      } else {
        return const CircularProgressIndicator();
      }
    });
  }

  Widget _signIn() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(
                'Please login',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              trailing: IconButton(
                onPressed: () {
                  _handleSignIn();
                },
                icon: const Icon(Icons.login),
              ),
            ),
            const Text('You are not currently signed in.'),
          ],
        ),
      ),
    );
  }

  void _handleSignIn() async {
    try {
      await googleSignIn.signIn();
      if (await googleSignIn.isSignedIn() && googleSignIn.currentUser != null) {
        setState(() {
          _currentUser = googleSignIn.currentUser;
        });

        await initiateDriveApi();
      }
    } catch (exception, stackTrace) {
      log('$exception');
    }
  }

  Future<void> _handleSignOut() async {
    if (await googleSignIn.isSignedIn()) {
      googleSignIn.disconnect();
      setState(() {
        _currentUser = null;
      });
    }
  }

  Future<void> initiateDriveApi() async {
    if (_currentUser != null) {
      final authHeaders = await _currentUser!.authHeaders;
      final authenticateClient = GoogleAuthClient(authHeaders);
      final driveApi = drive.DriveApi(authenticateClient);

      setState(() {
        _backup = GoogleDriveBackup(
          progressNotifier: progressNotifier,
          driveApi: driveApi,
        );
      });
      latestFile = _backup!.getLatestBackup();
      setState(() {});
    }
  }

  void setProcess(String value) {
    setState(() {
      process = value;
    });
  }
}
