import 'package:hive/hive.dart';

import 'vector_3_entry_adapter.dart';

part 'barcode_entry_adapter.g.dart';

@HiveType(typeId: 13)
class BarcodeEntry extends HiveObject {
  BarcodeEntry({required this.barcodeUID, required this.position});

  ///UID containerType_timestamp (PK)
  @HiveField(0)
  late String barcodeUID;

  ///Parent container's UID
  @HiveField(1)
  late Vector3Entry position;
}
