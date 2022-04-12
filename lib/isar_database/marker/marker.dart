import 'package:isar/isar.dart';
part 'marker.g.dart';

@Collection()
class Marker {
  int id = Isar.autoIncrement;

  late String barcodeUID;

  late String? parentContainerUID;

  @override
  String toString() {
    return 'barcodeUID: $barcodeUID, containerUID: $parentContainerUID';
  }

  Map toJson() => {
        'id': id,
        'barcodeUID': barcodeUID,
        'parentContainerUID': parentContainerUID,
      };

  Marker fromJson(Map<String, dynamic> json) {
    return Marker()
      ..id = json['id']
      ..barcodeUID = json['barcodeUID']
      ..parentContainerUID = json['parentContainerUID'];
  }
}
