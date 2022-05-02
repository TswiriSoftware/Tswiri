import 'package:flutter_google_ml_kit/objects/navigation/isolate_real_inter_barcode_vector.dart';
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

  void averagePosition(vm.Vector3 vector) {
    position = (position! + vector) / 2;
  }

  //Comparison
  @override
  bool operator ==(Object other) {
    if (other is String) {
      return barcodeUID == other;
    } else if (other is IsolateRealInterBarcodeVector) {
      return barcodeUID == other.startBarcodeUID;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => (barcodeUID).hashCode;

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
    return '\nUID: $barcodeUID, X: ${position?.x}, Y: ${position?.y}, Z: ${position?.z}';
  }
}
