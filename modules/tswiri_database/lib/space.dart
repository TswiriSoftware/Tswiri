import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:tswiri_database/collections/collections_export.dart';

final schemas = [
  BarcodeBatchSchema,
  CatalogedBarcodeSchema,
  CameraCalibrationEntrySchema,
  CatalogedContainerSchema,
  ContainerRelationshipSchema,
  ContainerTagSchema,
  ContainerTypeSchema,
  CatalogedGridSchema,
  MLDetectedLabelTextSchema,
  MLPhotoLabelSchema,
  PhotoLabelSchema,
  MLObjectSchema,
  MLObjectLabelSchema,
  ObjectLabelSchema,
  MLDetectedElementTextSchema,
  MLTextBlockSchema,
  MLTextElementSchema,
  MLTextLineSchema,
  PhotoSchema,
  MarkerSchema,
  CatalogedCoordinateSchema,
  TagTextSchema,
];

class Space with ChangeNotifier {
  Space();

  String? _databasePath;
  String? get databasePath => _databasePath;
  String? get photoPath => '$_databasePath/photos';

  Isar? _db;
  Isar? get db => _db;

  bool get isLoaded => _db != null;

  /// Switch to this space.
  Future<void> loadSpace({
    required String databasePath,
    bool inspector = false,
  }) async {
    log('Loading space: $databasePath', name: 'Space');

    // Check if databasePath exists.
    if (!await Directory(databasePath).exists()) {
      _databasePath = (await Directory(databasePath).create()).path;
    } else {
      _databasePath = databasePath;
    }

    // Check if photo path exists.
    if (!await Directory(photoPath!).exists()) {
      await Directory(photoPath!).create();
    }

    _db = await Isar.open(
      schemas,
      directory: databasePath,
      inspector: inspector,
    );

    notifyListeners();
  }
}
