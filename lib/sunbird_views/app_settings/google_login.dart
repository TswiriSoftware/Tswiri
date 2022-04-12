import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_google_ml_kit/isar_database/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/container_type/container_type.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/marker/marker.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/custom_outline_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/orange_outline_container.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

GoogleSignInAccount? _currentUser;

class GoogleLoginView extends StatefulWidget {
  const GoogleLoginView({Key? key}) : super(key: key);

  @override
  State<GoogleLoginView> createState() => _GoogleLoginViewState();
}

class _GoogleLoginViewState extends State<GoogleLoginView> {
  final GoogleSignInAccount? user = _currentUser;

  bool isBusy = false;
  String state = '';

  @override
  void initState() {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        //_handleGetContact(_currentUser!);
      }
    });

    _googleSignIn.signInSilently();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Google Login',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Builder(builder: (context) {
          final GoogleSignInAccount? user = _currentUser;
          if (user != null) {
            return Column(
              children: [
                loggedInWidget(user),
                backupWidget(user),
              ],
            );
          } else {
            return _loginWidget();
          }
        }),
      ),
    );
  }

  Widget loggedInWidget(GoogleSignInAccount user) {
    return Column(
      children: [
        const Text('You are signed in.'),
        OrangeOutlineContainer(
          child: ListTile(
            leading: GoogleUserCircleAvatar(
              identity: user,
            ),
            title: Text(user.displayName ?? ''),
            subtitle: Text(user.email),
            trailing: IconButton(
              onPressed: () {
                _handleSignOut();
              },
              icon: const Icon(Icons.logout),
            ),
          ),
        ),
      ],
    );
  }

  Widget _loginWidget() {
    return Column(
      children: [
        OrangeOutlineContainer(
          child: ListTile(
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
        ),
        const Text('You are not currently signed in.'),
      ],
    );
  }

  Widget backupWidget(GoogleSignInAccount user) {
    return Column(
      children: [
        Builder(builder: (context) {
          if (isBusy == false) {
            return InkWell(
              onTap: () async {
                setState(() {
                  isBusy = true;
                });

                await uploadFiles(user);
              },
              child: CustomOutlineContainer(
                margin: 2.5,
                padding: 5,
                child: Text(
                  'Backup',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                outlineColor: Colors.deepOrange,
              ),
            );
          } else {
            return Column(
              children: [
                const CircularProgressIndicator(),
                OrangeOutlineContainer(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Busy with',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          state,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ],
                )),
              ],
            );
          }
        })
      ],
    );
  }

  Future uploadFiles(GoogleSignInAccount user) async {
    List<String> filesToUpload = [
      'containerTypes.json',
      'containerEntries.json',
      'markers.json'
    ];

    final authHeaders = await user.authHeaders;
    final authenticateClient = GoogleAuthClient(authHeaders);
    final driveApi = drive.DriveApi(authenticateClient);

    String? folderID = await _getFolderID(driveApi);

    if (folderID == null) {
      log("Sign-in first Error");
    } else {
      String backupPath = (await getApplicationSupportDirectory()).path;

      for (var fileName in filesToUpload) {
        //Inform user of progress
        setState(() {
          state = 'backing up: ' + fileName.split('.').first;
        });

        //Ensure files exists
        await createJsonFile(backupPath, fileName);
        dynamic backupFileContent;

        //TODO: finish this up will take a while :D;

        //Backup current database.
        switch (fileName) {
          case 'containerTypes.json':
            backupFileContent = jsonEncode(isarDatabase!.containerTypes
                .where()
                .findAllSync()
                .map((e) => e.toJson())
                .toList());
            break;
          case 'containerEntries.json':
            backupFileContent = jsonEncode(isarDatabase!.containerEntrys
                .where()
                .findAllSync()
                .map((e) => e.toJson())
                .toList());
            break;
          case 'markers.json':
            backupFileContent = jsonEncode(isarDatabase!.markers
                .where()
                .findAllSync()
                .map((e) => e.toJson())
                .toList());
            break;
          case '':
            break;
        }

        //Open File.
        File file = File('$backupPath/sunbird/backup/$fileName');

        //Write to file.
        await file.writeAsString(backupFileContent);

        //Upload file to google drive
        await putFile(driveApi, fileName, file, folderID);
      }
    }

    setState(() {
      isBusy = false;
    });
  }

  Future putFile(
      drive.DriveApi driveApi, String name, File file, String folderID) async {
    drive.FileList fileList = await driveApi.files.list(
      q: "mimeType != 'application/vnd.google-apps.file' and name = '$name' and trashed = false ",
    );

    drive.File fileToUpload = drive.File();
    fileToUpload.parents = [folderID];
    fileToUpload.name = name;

    if (fileList.files != null && fileList.files!.isNotEmpty) {
      log('file exists: ' + fileList.files!.first.name.toString());

      await driveApi.files.delete(fileList.files!.first.id!);

      var response = await driveApi.files.create(
        fileToUpload,
        uploadMedia: drive.Media(file.openRead(), file.lengthSync()),
      );

      log('file updated: ' + name + ' ' + response.toString());
    } else {
      log('file does not exists: ' + name);

      var response = await driveApi.files.create(
        fileToUpload,
        uploadMedia: drive.Media(file.openRead(), file.lengthSync()),
      );

      log('file created: ' + response.toString());
    }
  }

  Future createJsonFile(String backupPath, String filename) async {
    if (!await File('$backupPath/sunbird/backup/$filename').exists()) {
      await File('$backupPath/sunbird/backup/$filename').create();
      log('created: ' + filename);
    } else {
      log('exists: ' + filename);
    }
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      log(error.toString());
    }
  }

  Future<String?> _getFolderID(drive.DriveApi driveApi) async {
    const mimeType = "application/vnd.google-apps.folder";
    String folderName = "subirdBackup";

    try {
      final found = await driveApi.files.list(
        q: "mimeType = '$mimeType' and name = '$folderName'",
        $fields: "files(id, name)",
      );

      final files = found.files;

      if (files == null) {
        log("Sign-in first Error");
        return null;
      }

      // The folder already exists
      if (files.isNotEmpty) {
        return files.first.id;
      }

      // Create a folder
      drive.File folder = drive.File();
      folder.name = folderName;
      //folder.mimeType = mimeType;
      final folderCreation = await driveApi.files.create(folder);
      //log("Folder ID: ${folderCreation.id}");

      return folderCreation.id;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();
}

GoogleSignIn _googleSignIn = GoogleSignIn(
  //Optional clientId
  //clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'https://www.googleapis.com/auth/userinfo.email',
    'https://www.googleapis.com/auth/drive',
  ],
);

class GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;

  final http.Client _client = http.Client();

  GoogleAuthClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _client.send(request..headers.addAll(_headers));
  }
}

Future<String> getStorageDirectory() async {
  if (Platform.isAndroid) {
    return (await getExternalStorageDirectory())!.path;
  } else {
    return (await getApplicationDocumentsDirectory()).path;
  }
}



  // Future createBackupFiles(String backupPath) async {
  //   //Container Types
  //   await createJsonFile(backupPath, 'containerTypes');

  //   //Container Entries
  //   await createJsonFile(backupPath, 'containerEntries');

  //   //Container Photos
  //   await createJsonFile(backupPath, 'containerPhotos');

  //   //Container Photo Thumbnails
  //   await createJsonFile(backupPath, 'containerPhotoThumbnails');

  //   //Photo Tags
  //   await createJsonFile(backupPath, 'photoTags');

  //   //mlTags
  //   await createJsonFile(backupPath, 'mlTags');

  //   //Markers
  //   await createJsonFile(backupPath, 'markers');

  //   //RealInterBarcodeVectorEntry
  //   await createJsonFile(backupPath, 'realInterBarcodeVectorEntry');

  //   //mlTags
  //   await createJsonFile(backupPath, 'mlTags');
  // }
  


  // var x = await driveApi.files.list(driveId: folderID);
              // log(x.toString());

              ////////////////////////////////
              /// var myModels = jsonDecode(json) as List<dynamic>;

              // List<ContainerType> containerTypeList =
              //     myModels.map((e) => ContainerType().fromJson(e)).toList();

              ///          log(containerTypeList.toString());

              // final Stream<List<int>> mediaStream =
              //     Future.value([104, 105]).asStream().asBroadcastStream();

              // var media = drive.Media(mediaStream, 2);

              // final result = await driveApi.files
              //     .create(fileToUpload..name = 'hi.txt', uploadMedia: media);