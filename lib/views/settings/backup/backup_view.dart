// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sunbird/globals/globals_export.dart';
import 'package:sunbird/isar/isar_database.dart';
import 'package:image/image.dart' as img;

class BackupView extends StatefulWidget {
  const BackupView({Key? key}) : super(key: key);

  @override
  State<BackupView> createState() => _BackupViewState();
}

class _BackupViewState extends State<BackupView> {
  //TODO: improve UI.

  bool _isBusy = false;

  File? selectedFile;
  bool canRestore = false;
  Directory? unzippedDirectory;

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
          'Backup',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true);
  }

  Widget _body() {
    return _isBusy
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              _restoreCard(),
              _backupCard(),
            ],
          );
  }

  Widget _backupCard() {
    return Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _backupButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _backupButton() {
    return ElevatedButton(
      onPressed: _backup,
      child: Text(
        "Create Backup",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  Widget _restoreCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                selectedFile != null
                    ? _selectedFileCard()
                    : Text(
                        'Select File (zip)',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  selectedFile = null;
                  canRestore = false;
                  unzippedDirectory = null;
                });

                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  allowedExtensions: ['zip'],
                  type: FileType.custom,
                );

                if (result != null) {
                  _unzip(File(result.files.single.path!));
                }
              },
              child: Text(
                'select',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const Divider(),
            canRestore
                ? ElevatedButton(
                    onPressed: () {
                      _restore(unzippedDirectory!);
                    },
                    child: Text(
                      'Restore',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Widget _selectedFileCard() {
    return Card(
      color: background[300],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          selectedFile!.path.split('/').last,
        ),
      ),
    );
  }

  ///Backs up all user data to a zip file.
  void _backup() async {
    setState(() {
      _isBusy = true;
    });

    //Support Directory.
    Directory documentsDirectory = await getTemporaryDirectory();

    //Isar Directory.
    Directory isarFolder = Directory('${isarDirectory!.path}/isar');

    //Backup Directory.
    Directory backupDirectory =
        Directory('${documentsDirectory.path}/backups/');
    if (!backupDirectory.existsSync()) {
      backupDirectory.create(recursive: true);
    }

    //Create newBackupDirectory
    String formattedDate =
        DateFormat('yyyy_MM_dd_HH_mm').format(DateTime.now());

    Directory newBackupDirectory =
        Directory('${backupDirectory.path}backup_$formattedDate');

    if (!newBackupDirectory.existsSync()) {
      newBackupDirectory.createSync(recursive: true);
    } else {
      newBackupDirectory.deleteSync(recursive: true);
      newBackupDirectory.createSync(recursive: true);
    }

    String newBackupPath = '${newBackupDirectory.path}/';

    Directory newBackupPhotos = Directory('${newBackupPath}photos');
    if (!newBackupPhotos.existsSync()) {
      newBackupPhotos.createSync(recursive: true);
    } else {
      newBackupPhotos.deleteSync(recursive: true);
      newBackupPhotos.createSync(recursive: true);
    }

    String newBackupPhotosPath = '${newBackupPhotos.path}/';

    //1. Copy over all photos to new directory.
    List<Photo> photos = isar!.photos.where().findAllSync();

    for (var photo in photos) {
      File photoFile = File(photo.getPhotoPath());

      photoFile.copySync(
          '$newBackupPhotosPath${photo.photoName}.${photo.extention}');
    }

    // 2. copy over isar folder.
    await isar!.close();

    final folder = isarFolder.listSync(recursive: true, followLinks: false);
    Directory isarBackupDirectory = Directory('${newBackupPath}isar/');
    if (!isarBackupDirectory.existsSync()) {
      await isarBackupDirectory.create(recursive: true);
    } else {
      isarBackupDirectory.deleteSync();
      isarBackupDirectory.create(recursive: true);
    }

    for (var file in folder) {
      File isarFile = File(file.path);
      isarFile
          .copySync(isarBackupDirectory.path + isarFile.path.split('/').last);

      log(isarBackupDirectory.path);
    }

    try {
      final zipFile = File(
          '${documentsDirectory.path}/sunbird_backup_${formattedDate}_v$isarVersion.zip');
      await ZipFile.createFromDirectory(
        sourceDir: newBackupDirectory,
        zipFile: zipFile,
        recurseSubDirs: true,
        includeBaseDirectory: false,
      );

      await Share.shareFiles([zipFile.path], text: 'sunbird_backup');
    } catch (e) {
      log(e.toString());
    }

    //Open Isar.
    isar = initiateIsar(inspector: false);

    setState(() {
      _isBusy = false;
    });
  }

  ///Restores user data from a zip file
  void _restore(Directory unzippedDirectory) async {
    setState(() {
      _isBusy = true;
    });
    //Isar Directory.
    Directory isarFolder = Directory('${isarDirectory!.path}/isar');

    //Close Isar.
    await isar!.close();

    File restoreDAT = File('${unzippedDirectory.path}/isar/mdbx.dat');
    File restorelLCK = File('${unzippedDirectory.path}/isar/mdbx.lck');

    if (restoreDAT.existsSync() && restorelLCK.existsSync()) {
      //Delete these files.
      File('${isarFolder.path}/mdbx.dat');
      File('${isarFolder.path}/mdbx.lck');

      //Copy restored Files over
      restoreDAT.copySync('${isarFolder.path}/mdbx.dat');
      restorelLCK.copySync('${isarFolder.path}/mdbx.lck');

      //Delete all photo files.
      photoDirectory!.deleteSync(recursive: true);
      String storagePath =
          '${(await getExternalStorageDirectory())!.path}/photos';
      photoDirectory = await Directory(storagePath).create();

      //Unzipped Photos.
      Directory unzippedPhotos = Directory('${unzippedDirectory.path}/photos');
      var files = unzippedPhotos.listSync(recursive: true, followLinks: false);

      //Restore Photos and thumbnails.
      for (var file in files) {
        File photoFile = File(file.path);
        log(photoDirectory!.path);
        photoFile.copySync(
            '${photoDirectory!.path}/${photoFile.path.split('/').last}');

        String photoName = photoFile.path.split('/').last.split('.').first;
        String extention = photoFile.path.split('/').last.split('.').last;
        String photoThumbnailPath =
            '${photoDirectory!.path}/${photoName}_thumbnail.$extention';
        img.Image referenceImage = img.decodeJpg(photoFile.readAsBytesSync())!;
        img.Image thumbnailImage = img.copyResize(referenceImage, width: 120);
        File(photoThumbnailPath)
            .writeAsBytesSync(img.encodePng(thumbnailImage));
      }
    }

    //Open Isar.
    isar = initiateIsar(inspector: false);

    setState(() {
      _isBusy = false;
    });
  }

  void _unzip(File restoreFile) async {
    //Support Directory.
    Directory temporaryDirectory = await getTemporaryDirectory();

    String restoredFilePath = restoreFile.path.split('/').last.split('.').first;

    setState(() {
      unzippedDirectory =
          Directory('${temporaryDirectory.path}/$restoredFilePath');
    });

    if (unzippedDirectory!.existsSync()) {
      unzippedDirectory!.deleteSync(recursive: true);
      unzippedDirectory!.createSync();
    } else {
      unzippedDirectory!.create();
    }

    final zipFile = restoreFile;
    final destinationDir = unzippedDirectory;
    try {
      await ZipFile.extractToDirectory(
          zipFile: zipFile, destinationDir: destinationDir!);
    } catch (e) {
      log(e.toString());
    }

    File restoreDAT = File('${unzippedDirectory!.path}/isar/mdbx.dat');
    File restorelLCK = File('${unzippedDirectory!.path}/isar/mdbx.lck');

    setState(() {
      if (restoreDAT.existsSync() && restorelLCK.existsSync()) {
        canRestore = true;
        selectedFile = restoreFile;
      }
    });
  }
}
