import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter_archive/flutter_archive.dart';
import 'package:intl/intl.dart';
import 'package:sunbird/isar/isar_database.dart';

Future<void> createBackup(List init) async {
  //1. InitalMessage.
  SendPort sendPort = init[0]; //[0] SendPort.
  String isarDirectory = init[1]; //[1] Isar Directory.
  String temporaryDirectory = init[2]; //[2] Backup folder.
  String isarVersion = init[3]; //[3] isarVersion.
  String photoDirectory = init[4]; //[4] photoDirectory.
  String fileName = init[5]; //[5] fileName.

  log(isarDirectory, name: 'Isar Directory');
  log(photoDirectory, name: 'Photo Directory');

  //2. Initiate isar.
  Isar isar = initiateIsar(directory: isarDirectory, inspector: false);

  //3. Isar Data Folder.
  Directory isarDataFolder = Directory('$isarDirectory/isar');

  //4. Backup Directory.
  Directory backupDirectory = Directory('$temporaryDirectory/backups/');
  if (!backupDirectory.existsSync()) {
    backupDirectory.create(recursive: true);
  }

  //5. Get the current Date and Time.
  String formattedDate = DateFormat('yyyy_MM_dd_HH_mm').format(DateTime.now());

  //6. Create backup directory.
  Directory newBackupDirectory =
      Directory('${backupDirectory.path}backup_$formattedDate');

  log(newBackupDirectory.path, name: 'Backup Directory');
  if (!newBackupDirectory.existsSync()) {
    newBackupDirectory.createSync(recursive: true);
  } else {
    newBackupDirectory.deleteSync(recursive: true);
    newBackupDirectory.createSync(recursive: true);
  }

  //7. Create the photo backup Directory.
  String newBackupPath = '${newBackupDirectory.path}/';

  Directory newBackupPhotos = Directory('${newBackupPath}photos');
  if (!newBackupPhotos.existsSync()) {
    newBackupPhotos.createSync(recursive: true);
  } else {
    newBackupPhotos.deleteSync(recursive: true);
    newBackupPhotos.createSync(recursive: true);
  }

  log(newBackupPhotos.path, name: 'Photo Backup Directory');

  String newBackupPhotosPath = '${newBackupPhotos.path}/';

  //8. Copy over all photos to new directory.
  List<Photo> photos = isar.photos.where().findAllSync();

  sendPort.send([
    'progress',
    0.0,
  ]);

  int files = photos.length + 2;
  int x = 0;

  for (var photo in photos) {
    sendPort.send([
      'progress',
      ((x / files) * 100),
    ]);

    File photoFile = File(photo.getPhotoPath(directory: photoDirectory));

    photoFile
        .copySync('$newBackupPhotosPath${photo.photoName}.${photo.extention}');

    x++;
  }

  final folder = isarDataFolder.listSync(recursive: true, followLinks: false);
  Directory isarBackupDirectory = Directory('${newBackupPath}isar/');
  if (!isarBackupDirectory.existsSync()) {
    isarBackupDirectory.createSync(recursive: true);
  } else {
    isarBackupDirectory.deleteSync();
    isarBackupDirectory.create(recursive: true);
  }

  for (var file in folder) {
    File isarFile = File(file.path);
    isarFile.copySync(isarBackupDirectory.path + isarFile.path.split('/').last);
    x++;
    sendPort.send([
      'progress',
      ((x / files) * 100),
    ]);
  }

  try {
    final zipFile = File('$temporaryDirectory/${fileName}_$isarVersion.zip');
    await ZipFile.createFromDirectory(
      sourceDir: newBackupDirectory,
      zipFile: zipFile,
      recurseSubDirs: true,
      includeBaseDirectory: false,
    );

    sendPort.send([
      'path',
      zipFile.path,
    ]);
  } catch (e) {
    log(e.toString());
  }

  sendPort.send([
    'done',
  ]);
}
