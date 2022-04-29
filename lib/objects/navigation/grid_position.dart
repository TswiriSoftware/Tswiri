import 'package:vector_math/vector_math.dart' as vm;

class GridPosition {
  GridPosition({
    required this.barcodeUID,
    required this.position,
  });

  ///barcodeUID.
  final String barcodeUID;

  ///The absolute position.
  late vm.Vector3? position;

  Map toJson() {
    return {
      'barcodeUID': barcodeUID,
      'positionX': position!.x,
      'positionY': position!.y,
      'positionZ': position!.z,
    };
  }

  factory GridPosition.fromJson(dynamic json) {
    return GridPosition(
      barcodeUID: json['barcodeUID'],
      position: vm.Vector3(
        json['positionX'] as double,
        json['positionY'] as double,
        json['positionZ'] as double,
      ),
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return '\nUID: $barcodeUID, X: ${position?.x}, Y: ${position?.y}, Z: ${position?.z}';
  }
}
