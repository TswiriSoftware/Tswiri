import 'package:isar/isar.dart';
part 'barcode_batch.g.dart';

@Collection()
@Name("BarcodeBatch")
class BarcodeBatch {
  int id = Isar.autoIncrement;

  //Generation Time.
  @Name("timestamp")
  late int timestamp;

  ///Barcode Size.
  @Name("size")
  late double size;

  ///Barcode range start.
  @Name("rangeStart")
  late int rangeStart;

  ///Barcode range end.
  @Name("rangeEnd")
  late int rangeEnd;

  ///Barcode Size.
  @Name("imported")
  late bool imported;

  @override
  String toString() {
    return '\ntimestamp: $timestamp, size: $size';
  }
}
