import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_google_ml_kit/global_values/global_colours.dart';
import 'package:flutter_google_ml_kit/isar_database/barcode_generation_entry/barcode_generation_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/barcode_property/barcode_property.dart';
import 'package:flutter_google_ml_kit/isar_database/barcode_size_distance_entry/barcode_size_distance_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/container_photo/container_photo.dart';
import 'package:flutter_google_ml_kit/isar_database/container_relationship/container_relationship.dart';
import 'package:flutter_google_ml_kit/isar_database/container_tag/container_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/container_type/container_type.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/marker/marker.dart';
import 'package:flutter_google_ml_kit/isar_database/ml_tag/ml_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/photo_tag/photo_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/real_interbarcode_vector_entry/real_interbarcode_vector_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/tag/tag.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

GoogleSignInAccount? _currentUser;

class GoogleDriveBackup extends StatefulWidget {
  const GoogleDriveBackup({Key? key}) : super(key: key);

  @override
  State<GoogleDriveBackup> createState() => _GoogleDriveBackupState();
}

class _GoogleDriveBackupState extends State<GoogleDriveBackup>
    with TickerProviderStateMixin {
  final GoogleSignInAccount? user = _currentUser;

  bool isBusyUploading = false;
  bool isBusyDownloading = false;
  String state = '';
  double uploadProgress = 0;
  double downloadProgess = 0;
  double stepValue = 1;

  List<ContainerPhoto> allPhotos = [];

  List<String> filesToUpload = [
    'containerTypes.json',
    'containerEntries.json',
    'markers.json',
    'mlTags.json',
    'photoTags.json',
    'realInterBarcodeVectorEntry.json',
    'tags.json',
    'containerRelationships.json',
    'containerPhotos.json',
    'barcodeSizeDistanceEntrys.json',
    'barcodePropertys.json',
    'barcodeGenerationEntrys.json',
    'containerTags.json'
  ];

  @override
  void initState() {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {}
    });

    _googleSignIn.signInSilently();

    allPhotos.addAll(isarDatabase!.containerPhotos.where().findAllSync());

    stepValue = 1 / (14 + allPhotos.length);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Google Drive Backup',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        elevation: 0,
        leading: Builder(builder: (context) {
          if (isBusyUploading) {
            return Container();
          } else {
            return IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
              ),
            );
          }
        }),
      ),
      body: SingleChildScrollView(
        child: Builder(builder: (context) {
          final GoogleSignInAccount? user = _currentUser;
          if (user != null) {
            return Column(
              children: [
                _userLoggedIn(user),
                uploadFilesButton(user),
                uploadWidget(user),
                downloadFilesButton(user),
                _downloadWidget(),
              ],
            );
          } else {
            return _loginWidget();
          }
        }),
      ),
    );
  }

  Widget _loginWidget() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      color: Colors.white12,
      elevation: 5,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: sunbirdOrange, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
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
            const Divider(),
            const Text('You are not currently signed in.'),
          ],
        ),
      ),
    );
  }

  Widget _userLoggedIn(GoogleSignInAccount user) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      color: Colors.white12,
      elevation: 5,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: sunbirdOrange, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          ListTile(
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
        ],
      ),
    );
  }

  Widget uploadFilesButton(GoogleSignInAccount user) {
    return Builder(builder: (context) {
      if (isBusyDownloading || isBusyUploading) {
        return const SizedBox.shrink();
      } else {
        return ElevatedButton(
            onPressed: () async {
              setState(() {
                isBusyUploading = true;
              });

              await uploadFiles(user);
            },
            child:
                Text('Backup', style: Theme.of(context).textTheme.bodyLarge));
      }
    });
  }

  Widget uploadWidget(GoogleSignInAccount user) {
    return Column(
      children: [
        Builder(builder: (context) {
          if (!isBusyUploading) {
            return const SizedBox.shrink();
          } else {
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              color: Colors.white12,
              elevation: 5,
              shadowColor: Colors.black26,
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: sunbirdOrange, width: 1.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Backing up',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              state,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(
                        value: uploadProgress,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        })
      ],
    );
  }

  Widget _downloadWidget() {
    return Builder(builder: (context) {
      if (isBusyDownloading) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          color: Colors.white12,
          elevation: 5,
          shadowColor: Colors.black26,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: sunbirdOrange, width: 1.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Downloading',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          state,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LinearProgressIndicator(
                    value: downloadProgess,
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        return Row();
      }
    });
  }

  Widget downloadFilesButton(GoogleSignInAccount user) {
    return Builder(builder: (context) {
      if (isBusyDownloading || isBusyUploading) {
        return const SizedBox.shrink();
      } else {
        return ElevatedButton(
          onPressed: () async {
            downloadGoogleDriveFiles(user);
            setState(() {
              isBusyDownloading = true;
            });
          },
          child: Text(
            'Donwload Backup',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        );
      }
    });
  }

  Future<void> downloadGoogleDriveFiles(user) async {
    final authHeaders = await user.authHeaders;
    final authenticateClient = GoogleAuthClient(authHeaders);
    final driveApi = drive.DriveApi(authenticateClient);

    for (var filename in filesToUpload) {
      drive.FileList fileList = await driveApi.files.list(
        q: "name = '$filename' and trashed = false ",
      );
      if (fileList.files!.isNotEmpty) {
        setState(() {
          state = filename.split('.').first;
          downloadProgess = downloadProgess + stepValue;
        });

        String backupPath =
            (await getApplicationSupportDirectory()).path + '/download/';

        if (!await File('$backupPath/sunbird/download/$filename').exists()) {
          await File('$backupPath/sunbird/download/$filename')
              .create(recursive: true);
          log('created: ' + filename);
        } else {
          log('exists: ' + filename);
        }
      }
    }

    // String folderName = "photos";

    // final found = await driveApi.files.list(
    //   q: "'$folderName' in parents",
    // );

    // final files = found.files;

    // log(files.toString());

    setState(() {
      isBusyDownloading = false;
      downloadProgess = 0;
    });
  }

  Future uploadFiles(GoogleSignInAccount user) async {
    uploadProgress = 0;

    final authHeaders = await user.authHeaders;
    final authenticateClient = GoogleAuthClient(authHeaders);
    final driveApi = drive.DriveApi(authenticateClient);

    String? folderID = await _getBackupFolderID(driveApi);

    if (folderID == null) {
      log("Sign-in first Error");
    } else {
      String backupPath = (await getApplicationSupportDirectory()).path;

      //Backup Database.
      for (var fileName in filesToUpload) {
        //Inform user of progress
        setState(() {
          state = fileName.split('.').first;
          uploadProgress = uploadProgress + stepValue;
        });

        //Ensure files exists
        await createJsonFile(backupPath, fileName);
        String? backupFileContent;

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
          case 'mlTags.json':
            backupFileContent = jsonEncode(isarDatabase!.mlTags
                .where()
                .findAllSync()
                .map((e) => e.toJson())
                .toList());
            break;
          case 'photoTags.json':
            backupFileContent = jsonEncode(isarDatabase!.photoTags
                .where()
                .findAllSync()
                .map((e) => e.toJson())
                .toList());
            break;
          case 'realInterBarcodeVectorEntry.json':
            backupFileContent = jsonEncode(isarDatabase!
                .realInterBarcodeVectorEntrys
                .where()
                .findAllSync()
                .map((e) => e.toJson())
                .toList());
            break;
          case 'tags.json':
            backupFileContent = jsonEncode(isarDatabase!.tags
                .where()
                .findAllSync()
                .map((e) => e.toJson())
                .toList());
            break;
          case 'containerRelationships.json':
            backupFileContent = jsonEncode(isarDatabase!.containerRelationships
                .where()
                .findAllSync()
                .map((e) => e.toJson())
                .toList());
            break;

          case 'containerPhotos.json':
            backupFileContent = jsonEncode(isarDatabase!.containerPhotos
                .where()
                .findAllSync()
                .map((e) => e.toJson())
                .toList());
            break;
          case 'barcodeSizeDistanceEntrys.json':
            backupFileContent = jsonEncode(isarDatabase!
                .barcodeSizeDistanceEntrys
                .where()
                .findAllSync()
                .map((e) => e.toJson())
                .toList());
            break;
          case 'barcodePropertys.json':
            backupFileContent = jsonEncode(isarDatabase!.barcodePropertys
                .where()
                .findAllSync()
                .map((e) => e.toJson())
                .toList());
            break;
          case 'barcodeGenerationEntry.json':
            backupFileContent = jsonEncode(isarDatabase!.barcodeGenerationEntrys
                .where()
                .findAllSync()
                .map((e) => e.toJson())
                .toList());
            break;
          case 'containerTags.json':
            backupFileContent = jsonEncode(isarDatabase!.containerTags
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

        if (backupFileContent != null) {
          //Write to file.
          await file.writeAsString(backupFileContent);

          //Upload file to google drive
          await putFile(driveApi, fileName, file, folderID);
        }
      }

      //Backup Photos.
      String? photoFolderID = await _getPhotoFolderID(driveApi);
      log(allPhotos.length.toString());
      if (photoFolderID != null) {
        for (ContainerPhoto item in allPhotos) {
          putFile(driveApi, item.photoPath.split('/').last,
              File(item.photoPath), photoFolderID);
          setState(() {
            state = 'photos';
            uploadProgress = uploadProgress + stepValue;
          });
        }
      }
    }

    setState(() {
      isBusyUploading = false;
      uploadProgress = 0;
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
      await File('$backupPath/sunbird/backup/$filename')
          .create(recursive: true);
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

  Future<String?> _getBackupFolderID(drive.DriveApi driveApi) async {
    const mimeType = "application/vnd.google-apps.folder";
    String folderName = "sunbird_backup";

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
      folder.mimeType = mimeType;

      final folderCreation = await driveApi.files.create(folder);

      return folderCreation.id;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<String?> _getPhotoFolderID(drive.DriveApi driveApi) async {
    const mimeType = "application/vnd.google-apps.folder";
    String folderName = "photos";

    final found = await driveApi.files.list(
      q: "mimeType = '$mimeType' and name = 'sunbird_backup'",
      $fields: "files(id, name)",
    );

    final backupFile = found.files;

    try {
      final found = await driveApi.files.list(
        q: "mimeType = '$mimeType' and name = '$folderName' and '${backupFile!.first.id}' in parents",
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
      folder.parents = [backupFile.first.id!];
      folder.name = folderName;
      folder.mimeType = mimeType;
      final folderCreation = await driveApi.files.create(folder);

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




  ///DECOING JASON ?

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