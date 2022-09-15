// ignore_for_file: unused_local_variable

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:googleapis/drive/v3.dart' as drive;

import 'package:tswiri_database/export.dart';
import 'package:tswiri_database/functions/backup/backup_restore_functions.dart';
import 'package:tswiri_database/mobile_database.dart';
import 'package:tswiri_database/models/backup/google_drive_manager.dart';

class GoogleDriveView extends StatefulWidget {
  const GoogleDriveView({Key? key}) : super(key: key);

  @override
  State<GoogleDriveView> createState() => _GoogleDriveViewState();
}

GoogleSignInAccount? currentUser;

class _GoogleDriveViewState extends State<GoogleDriveView> {
  ValueNotifier<double> progressNotifier = ValueNotifier(0);
  GoogleDriveManager? _backup;
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
          currentUser != null ? _singedIn() : _signIn(),
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
          _driveActions(),
        ],
      ),
    );
  }

  Widget _userTile() {
    return ListTile(
      leading: GoogleUserCircleAvatar(
        identity: currentUser!,
      ),
      title: Text(currentUser!.displayName ?? ''),
      subtitle: Text(currentUser!.email),
      trailing: IconButton(
        onPressed: () {
          _handleSignOut();
        },
        icon: const Icon(Icons.logout),
      ),
    );
  }

  Widget _driveActions() {
    return Builder(builder: (context) {
      if (_backup != null) {
        return FutureBuilder<drive.File?>(
          future: latestFile,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data != null) {
                return Column(
                  children: [
                    _lastBackup(snapshot.data!),
                    const Divider(),
                    _restoreBackup(snapshot.data!),
                    const Divider(),
                    const Divider(),
                    _restoreSpaces(),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _createBackup(),
                    _restoreSpaces(),
                  ],
                );
              }
            } else {
              return const CircularProgressIndicator();
            }
          },
        );
      } else {
        return const CircularProgressIndicator();
      }
    });
  }

  Widget _lastBackup(drive.File snapshot) {
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(Icons.backup_sharp),
      ),
      title: Text(
        'Last Backup',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      subtitle:
          Text(DateFormat('yyyy-MM-dd – kk:mm').format(snapshot.createdTime!)),
      trailing: IconButton(
        onPressed: () async {
          setState(() {
            _isBusy = true;
          });

          setProcess('Creating new backup');
          log('Creating new backup');
          File? file = await createBackupFile(
            progressCallback: (event) {
              //TODO: implement this.
            },
            fileName: generateBackupFileName(),
          );

          log(file?.path.toString() ?? 'aa');

          if (file != null) {
            setProcess('Uploading');
            _backup!.uploadFile(file);
            await Future.delayed(const Duration(milliseconds: 2500));
            setProcess('done');
            latestFile = _backup!.getLatestBackup();
          } else {
            //TODO: error
          }

          setState(() {
            _isBusy = false;
          });
        },
        icon: const Icon(Icons.upload),
      ),
    );
  }

  Widget _createBackup() {
    return ElevatedButton(
      onPressed: () async {
        setState(() {
          _isBusy = true;
        });

        setProcess('Creating new backup');

        File? file = await createBackupFile(
          progressCallback: (event) {
            ///TODO: implement this.
          },
          fileName: generateBackupFileName(),
        );

        if (file != null) {
          setProcess('Uploading');
          log('Uploading');
          bool uploaded = await _backup!.uploadFile(file);
          setProcess('done');
          log('done');
          await Future.delayed(const Duration(milliseconds: 200));
          latestFile = _backup!.getLatestBackup();
        } else {
          //TODO: error
        }

        setState(() {
          _isBusy = false;
        });
      },
      child: const Text('Create backup'),
    );
  }

  Widget _restoreBackup(drive.File snapshot) {
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(Icons.cloud_download),
      ),
      title: Text(
        'Restore',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      subtitle: Text(
        snapshot.name?.toString() ?? 'cannot retrive name',
      ),
      trailing: IconButton(
        onPressed: () async {
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
            File? downloadedFile = await _backup!.downloadFile(snapshot);

            if (downloadedFile != null) {
              setProcess('Restoring');
              await restoreBackupFile(
                  progressCallback: (event) {
                    //TODO: implement this.
                  },
                  backupFile: File(downloadedFile.path));
            }

            await isar!.close();
            isar = initiateMobileIsar();

            setState(() {
              _isBusy = false;
            });
          }
        },
        icon: const Icon(Icons.restore),
      ),
    );
  }

  Widget _restoreSpaces() {
    return ListTile(
      leading: const Icon(Icons.space_dashboard_sharp),
      title: Text(
        'Restore Spaces (Names)',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: ElevatedButton(
          onPressed: () async {
            List<String>? spaces = await _backup!.getSpaces();

            if (spaces != null) {
              //check what spaces exist.
              List<String> existingSpaces = await getSpacesOnDevice();

              log(existingSpaces.toString(), name: 'Existing Spaces');
              log(spaces.toString(), name: 'Google Spaces');

              int numberOfRestoredSpaces = 0;
              for (String space in spaces) {
                if (!existingSpaces.contains(space)) {
                  await createNewSpace(space.split('_').first);
                  numberOfRestoredSpaces++;
                }
              }

              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Space names restored: $numberOfRestoredSpaces',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }
          },
          child: Text(
            'Restore',
            style: Theme.of(context).textTheme.bodyMedium,
          )),
    );
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
      try {
        await googleSignIn.signIn();
      } catch (e) {
        log(e.toString());
      }

      if (await googleSignIn.isSignedIn() && googleSignIn.currentUser != null) {
        setState(() {
          currentUser = googleSignIn.currentUser;
        });

        await initiateDriveApi();
      }
    } catch (exception) {
      log('$exception');
    }
  }

  Future<void> _handleSignOut() async {
    if (await googleSignIn.isSignedIn()) {
      googleSignIn.disconnect();
      setState(() {
        currentUser = null;
      });
    }
  }

  Future<void> initiateDriveApi() async {
    if (currentUser != null) {
      final authHeaders = await currentUser!.authHeaders;
      final authenticateClient = GoogleAuthClient(authHeaders);
      final driveApi = drive.DriveApi(authenticateClient);

      setState(() {
        _backup = GoogleDriveManager(
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
