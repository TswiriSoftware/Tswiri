// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_google_ml_kit/extentions/capitalize_first_character.dart';
import 'package:flutter_google_ml_kit/global_values/global_colours.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/barcodes/barcode_generation_entry/barcode_generation_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/barcodes/barcode_property/barcode_property.dart';
import 'package:flutter_google_ml_kit/isar_database/barcodes/barcode_size_distance_entry/barcode_size_distance_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/barcodes/marker/marker.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_relationship/container_relationship.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_type/container_type.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/photo/photo.dart';
import 'package:flutter_google_ml_kit/isar_database/grid/coordinate_entry/coordinate_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/container_tag/container_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/ml_tag/ml_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/tag_bounding_box/object_bounding_box.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/tag_text/tag_text.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/user_tag/user_tag.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import 'package:image/image.dart' as img;
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

  List<Photo> allPhotos = [];

  List<String> relevantFiles = [
    'tagText.json', //1 [TagText] Shwap
    'containerTypes.json', //2 [ContainerType] Shwap
    'containerEntries.json', //3 [ContainerEntry] Shwap
    'containerRelationships.json', //4 [ContainerRelationship] Shwap
    'containerTags.json', //5 [ContainerTags] Shwap
    'markers.json', // 6
    'mlTags.json', // 7
    'objectBoundingBox.json', // 8
    'realInterBarcodeVectorEntry.json', // 9
    'barcodeSizeDistanceEntrys.json', // 10
    'barcodePropertys.json', // 11
    'barcodeGenerationEntrys.json', // 12
    'photos.json', //13
    'userTags.json', //14
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

    allPhotos.addAll(isarDatabase!.photos.where().findAllSync());

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
          if (isBusyUploading || isBusyDownloading) {
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
                _uploadFilesButton(user),
                _uploadWidget(user),
                _downloadFilesButton(user),
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

  Widget _uploadFilesButton(GoogleSignInAccount user) {
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

  Widget _uploadWidget(GoogleSignInAccount user) {
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

  Widget _downloadFilesButton(GoogleSignInAccount user) {
    return Builder(builder: (context) {
      if (isBusyDownloading || isBusyUploading) {
        return const SizedBox.shrink();
      } else {
        return ElevatedButton(
          onPressed: () async {
            downloadFiles(user);
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

  Future<void> downloadFiles(user) async {
    setState(() {
      isBusyDownloading = true;
    });
    final authHeaders = await user.authHeaders;
    final authenticateClient = GoogleAuthClient(authHeaders);
    final driveApi = drive.DriveApi(authenticateClient);

    String storagePath = await getStorageDirectory();
    if (!await Directory('$storagePath/sunbird').exists()) {
      Directory('$storagePath/sunbird').create();
    }

    for (var filename in relevantFiles) {
      drive.FileList fileList = await driveApi.files.list(
        q: "name = '$filename' and trashed = false ",
      );

      if (fileList.files!.isNotEmpty) {
        setState(() {
          state = filename.split('.').first.capitalize();
          downloadProgess = downloadProgess + stepValue;
        });

        String fileContent = await downloadFile(driveApi, fileList, filename);
        if (fileContent.isNotEmpty) {
          var json = jsonDecode(fileContent) as List<dynamic>;
          switch (filename) {
            case 'tagText.json':
              List<TagText> tags =
                  json.map((e) => TagText().fromJson(e)).toList();
              isarDatabase!.writeTxnSync((isar) {
                isar.tagTexts.where().deleteAllSync();
                isar.tagTexts.putAllSync(tags);
              });
              break;
            case 'containerTypes.json':
              List<ContainerType> containerTypeList =
                  json.map((e) => ContainerType().fromJson(e)).toList();
              isarDatabase!.writeTxnSync((isar) {
                isar.containerTypes.where().deleteAllSync();
                isar.containerTypes.putAllSync(containerTypeList);
              });
              break;
            case 'containerEntries.json':
              List<ContainerEntry> containerEntrys =
                  json.map((e) => ContainerEntry().fromJson(e)).toList();
              // log(containerEntrys.toString());
              isarDatabase!.writeTxnSync((isar) {
                isar.containerEntrys.where().deleteAllSync();
                isar.containerEntrys.putAllSync(containerEntrys);
              });
              break;
            case 'containerRelationships.json':
              List<ContainerRelationship> relationships =
                  json.map((e) => ContainerRelationship().fromJson(e)).toList();
              // log(relationships.toString());
              isarDatabase!.writeTxnSync((isar) {
                isar.containerRelationships.where().deleteAllSync();
                isar.containerRelationships.putAllSync(relationships);
              });
              break;
            case 'containerTags.json':
              List<ContainerTag> containerTags =
                  json.map((e) => ContainerTag().fromJson(e)).toList();
              //log(containerTags.toString());
              isarDatabase!.writeTxnSync((isar) {
                isar.containerTags.where().deleteAllSync();
                isar.containerTags.putAllSync(containerTags);
              });
              break;
            case 'markers.json':
              List<Marker> markers =
                  json.map((e) => Marker().fromJson(e)).toList();
              // log(markers.toString());
              isarDatabase!.writeTxnSync((isar) {
                isar.markers.where().deleteAllSync();
                isar.markers.putAllSync(markers);
              });
              break;
            case 'mlTags.json':
              List<MlTag> mlTags =
                  json.map((e) => MlTag().fromJson(e)).toList();
              // log(mlTags.toString());
              isarDatabase!.writeTxnSync((isar) {
                isar.mlTags.where().deleteAllSync();
                isar.mlTags.putAllSync(mlTags);
              });
              break;
            case 'realInterBarcodeVectorEntry.json':
              List<CoordinateEntry> realInterBarcodeVectorEntrys =
                  json.map((e) => CoordinateEntry().fromJson(e)).toList();

              log(realInterBarcodeVectorEntrys.toString());
              // log(realInterBarcodeVectorEntrys.toString());
              isarDatabase!.writeTxnSync((isar) {
                isar.coordinateEntrys.where().deleteAllSync();
                isar.coordinateEntrys.putAllSync(realInterBarcodeVectorEntrys);
              });
              break;
            case 'objectBoundingBox.json':
              List<ObjectBoundingBox> objectBoundingBoxes =
                  json.map((e) => ObjectBoundingBox().fromJson(e)).toList();
              //log(barcodeSizeDistanceEntries.toString());
              isarDatabase!.writeTxnSync((isar) {
                isar.objectBoundingBoxs.where().deleteAllSync();
                isar.objectBoundingBoxs.putAllSync(objectBoundingBoxes);
              });
              break;
            case 'barcodeSizeDistanceEntrys.json':
              List<BarcodeSizeDistanceEntry> barcodeSizeDistanceEntries = json
                  .map((e) => BarcodeSizeDistanceEntry().fromJson(e))
                  .toList();
              //log(barcodeSizeDistanceEntries.toString());
              isarDatabase!.writeTxnSync((isar) {
                isar.barcodeSizeDistanceEntrys.where().deleteAllSync();
                isar.barcodeSizeDistanceEntrys
                    .putAllSync(barcodeSizeDistanceEntries);
              });
              break;
            case 'barcodePropertys.json':
              List<BarcodeProperty> barcodeProperties =
                  json.map((e) => BarcodeProperty().fromJson(e)).toList();
              //log(barcodeProperties.toString());
              isarDatabase!.writeTxnSync((isar) {
                isar.barcodePropertys.where().deleteAllSync();
                isar.barcodePropertys.putAllSync(barcodeProperties);
              });
              break;
            case 'barcodeGenerationEntry.json':
              List<BarcodeGenerationEntry> barcodeGenerationEntries = json
                  .map((e) => BarcodeGenerationEntry().fromJson(e))
                  .toList();
              //log(barcodeGenerationEntries.toString());
              isarDatabase!.writeTxnSync((isar) {
                isar.barcodeGenerationEntrys.where().deleteAllSync();
                isar.barcodeGenerationEntrys
                    .putAllSync(barcodeGenerationEntries);
              });
              break;
            case 'photos.json':
              List<Photo> photos =
                  json.map((e) => Photo().fromJson(e, storagePath)).toList();
              isarDatabase!.writeTxnSync((isar) {
                isar.photos.where().deleteAllSync();
                isar.photos.putAllSync(photos);
              });
              break;

            case 'userTags.json':
              List<UserTag> photoTags =
                  json.map((e) => UserTag().fromJson(e)).toList();
              isarDatabase!.writeTxnSync((isar) {
                isar.userTags.where().deleteAllSync();
                isar.userTags.putAllSync(photoTags);
              });
              break;
          }
        }
      }
    }

    const mimeType = "application/vnd.google-apps.folder";
    String folderName = "photos";

    drive.FileList photoFolder = await driveApi.files.list(
      q: "mimeType = '$mimeType' and name ='$folderName'",
    );

    if (photoFolder.files != null) {
      drive.FileList photoFiles = await driveApi.files.list(
        q: "'${photoFolder.files!.first.id}' in parents and trashed = false",
      );

      if (photoFiles.files != null) {
        for (drive.File photo in photoFiles.files!) {
          drive.Media test = await driveApi.files.get(photo.id!,
              downloadOptions: drive.DownloadOptions.fullMedia) as drive.Media;

          File photoFile = File('$storagePath/sunbird/${photo.name!}');
          log('path: ${photoFile.path}');
          log('id: ${photo.id!}');
          log('name: ${photo.name}');

          File thumbnailFile = File(
              '$storagePath/sunbird/${photo.name.toString().split('.').first}_thumbnail.${photo.name.toString().split('.').last}');

          if (await photoFile.exists()) {
            log('file exisits');
          } else {
            await photoFile.create();
            List<int> dataStore = [];

            test.stream.listen(
              (data) {
                dataStore.insertAll(dataStore.length, data);
              },
              onDone: () async {
                await photoFile.writeAsBytes(dataStore);

                var image = img.decodeJpg(photoFile.readAsBytesSync());
                var thumbnail = img.copyResize(image!, width: 120);

                File(thumbnailFile.path)
                    .writeAsBytesSync(img.encodeJpg(thumbnail));
              },
            );
          }
        }
      }
    }
    setState(() {
      isBusyDownloading = false;
      downloadProgess = 0;
    });
  }

  Future<String> downloadFile(
      drive.DriveApi driveApi, drive.FileList fileList, String filename) async {
    drive.Media test = await driveApi.files.get(fileList.files!.first.id!,
        downloadOptions: drive.DownloadOptions.fullMedia) as drive.Media;

    String backupPath =
        '${(await getApplicationSupportDirectory()).path}/download/';
    String fileContent = '';

    if (!(await File('$backupPath/sunbird/download/$filename').exists())) {
      File file = await File('$backupPath/sunbird/download/$filename')
          .create(recursive: true);

      List<int> dataStore = [];
      test.stream.listen(
        (data) {
          dataStore.insertAll(dataStore.length, data);
        },
        onDone: () {
          file.writeAsBytes(dataStore);
        },
      );

      fileContent = await file.readAsString();
    } else {
      File('$backupPath/sunbird/download/$filename').deleteSync();
      File file = await File('$backupPath/sunbird/download/$filename')
          .create(recursive: true);

      List<int> dataStore = [];
      test.stream.listen(
        (data) {
          dataStore.insertAll(dataStore.length, data);
        },
        onDone: () {
          file.writeAsBytes(dataStore);
        },
      );

      fileContent = await file.readAsString();
    }
    return fileContent;
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
      for (var fileName in relevantFiles) {
        //Inform user of progress
        setState(() {
          state = fileName.split('.').first;
          uploadProgress = uploadProgress + stepValue;
        });

        //Ensure files exists
        await createJsonFile(backupPath, fileName);
        String? backupFileContent;

        //Backup current database.
        switch (fileName) {
          case 'tagText.json':
            backupFileContent = jsonEncode(isarDatabase!.tagTexts
                .where()
                .findAllSync()
                .map((e) => e.toJson())
                .toList());
            break;
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
          case 'containerRelationships.json':
            backupFileContent = jsonEncode(isarDatabase!.containerRelationships
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
          case 'markers.json':
            backupFileContent = jsonEncode(isarDatabase!.markers
                .where()
                .findAllSync()
                .map((e) => e.toJson())
                .toList());
            break;
          case 'mlTags.json':
            log('mlTags.json');
            backupFileContent = jsonEncode(isarDatabase!.mlTags
                .where()
                .findAllSync()
                .map((e) => e.toJson())
                .toList());
            break;
          case 'objectBoundingBox.json':
            backupFileContent = jsonEncode(isarDatabase!.objectBoundingBoxs
                .where()
                .findAllSync()
                .map((e) => e.toJson())
                .toList());
            break;
          case 'realInterBarcodeVectorEntry.json':
            backupFileContent = jsonEncode(isarDatabase!.coordinateEntrys
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
          case 'photos.json':
            backupFileContent = jsonEncode(isarDatabase!.photos
                .where()
                .findAllSync()
                .map((e) => e.toJson())
                .toList());
            break;
          case 'userTags.json':
            backupFileContent = jsonEncode(isarDatabase!.userTags
                .where()
                .findAllSync()
                .map((e) => e.toJson())
                .toList());
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
      if (photoFolderID != null) {
        for (Photo item in allPhotos) {
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
      log('file exists: ${fileList.files!.first.name}');

      await driveApi.files.delete(fileList.files!.first.id!);

      var response = await driveApi.files.create(
        fileToUpload,
        uploadMedia: drive.Media(file.openRead(), file.lengthSync()),
      );

      log('file updated: $name $response');
    } else {
      log('file does not exists: $name');

      var response = await driveApi.files.create(
        fileToUpload,
        uploadMedia: drive.Media(file.openRead(), file.lengthSync()),
      );

      log('file created: $response');
    }
  }

  Future createJsonFile(String backupPath, String filename) async {
    if (!await File('$backupPath/sunbird/backup/$filename').exists()) {
      await File('$backupPath/sunbird/backup/$filename')
          .create(recursive: true);
      log('created: $filename');
    } else {
      log('exists: $filename');
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
        q: "mimeType = '$mimeType' and name = '$folderName' and '${backupFile!.first.id}' in parents and trashed = false",
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
  scopes: <String>[
    // drive.DriveApi.driveAppdataScope,
    drive.DriveApi.driveScope
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
