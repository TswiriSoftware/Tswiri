import 'package:flutter_google_ml_kit/databaseAdapters/type_offset_adapter.dart';
import 'package:hive/hive.dart';
part 'consolidated_data_adapter.g.dart';

@HiveType(typeId: 1)
class ConsolidatedData extends HiveObject {
  ConsolidatedData(
      {required this.uid, required this.offset, required this.fixed});

  @HiveField(0)
  late String uid;

  @HiveField(1)
  late TypeOffset offset;

  @HiveField(2)
  late bool fixed;
}
