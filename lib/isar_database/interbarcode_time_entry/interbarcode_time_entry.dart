import 'package:isar/isar.dart';
part 'interbarcode_time_entry.g.dart';

@Collection()
class InterBarcodeTimeEntry {
  int id = Isar.autoIncrement;

  //Start barcodeUID.
  late String startBarcodeUID;
  //End barcodeUID.
  late String endBarcodeUID;

  //Time between scans.
  late double deltaT;

  //Timestamp.
  late int timestamp;

  //Creation Timestamp
  late int creationTimestamp;

  //Returns the UID of the interBarcodeVectorEntry
  String get uid {
    return '${startBarcodeUID}_$endBarcodeUID';
  }

  //Comparison
  @override
  bool operator ==(Object other) {
    return other is InterBarcodeTimeEntry && hashCode == other.hashCode;
  }

  @override
  int get hashCode => (uid).hashCode;

  @override
  String toString() {
    return '\nstartBarcodeUID: $startBarcodeUID, endBarcodeUID: $endBarcodeUID,deltaT: $deltaT, timestamp: $timestamp, creation: $creationTimestamp,';
  }
}
