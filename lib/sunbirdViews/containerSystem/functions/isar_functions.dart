import 'package:flutter_google_ml_kit/globalValues/isar_dir.dart';
import 'package:flutter_google_ml_kit/isar/container_relationship.dart';
import 'package:flutter_google_ml_kit/isar/container_type.dart';
import 'package:isar/isar.dart';

import '../../../isar/container_isar.dart';

Isar openIsar() {
  Isar isar = Isar.openSync(
    schemas: [
      ContainerEntrySchema,
      ContainerRelationshipSchema,
      ContainerTypeSchema
    ],
    directory: isarDirectory!.path,
    inspector: true,
  );
  return isar;
}

Isar? closeIsar(Isar? database) {
  if (database != null) {
    if (database.isOpen) {
      database.close();
      return null;
    }
  }
  return null;
}
