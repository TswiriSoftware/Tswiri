import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../../isar/container_isar.dart';

Future<Isar> openIsar() async {
  final dir = await getApplicationSupportDirectory(); // path_provider package
  Isar isar = await Isar.open(
    schemas: [ContainerIsarSchema],
    directory: dir.path,
    inspector: true,
  );
  return isar;
}

Isar? closeIsar(Isar? isar) {
  if (isar != null) {
    if (isar.isOpen) {
      isar.close();
      return null;
    }
  }
}
