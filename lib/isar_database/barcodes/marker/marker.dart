import 'package:isar/isar.dart';
part 'marker.g.dart';

@Collection()
class Marker {
  int id = Isar.autoIncrement;

  late String barcodeUID;

  late String? parentContainerUID;

  @override
  bool operator ==(Object other) {
    return other is Marker &&
        id == other.id &&
        barcodeUID == other.barcodeUID &&
        parentContainerUID == other.parentContainerUID;
  }

  @override
  String toString() {
    return '\nbarcodeUID: $barcodeUID, containerUID: $parentContainerUID';
  }

  Map toJson() => {
        'id': id,
        'barcodeUID': barcodeUID,
        'parentContainerUID': parentContainerUID,
      };

  Marker fromJson(Map<String, dynamic> json) {
    return Marker()
      ..id = json['id'] as int
      ..barcodeUID = json['barcodeUID']
      ..parentContainerUID = json['parentContainerUID'];
  }
}
