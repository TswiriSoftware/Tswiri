import 'package:flutter_google_ml_kit/objects/navigation/isolate/real_inter_barcode_vector.dart';
import 'package:vector_math/vector_math.dart' as vm;

class Position {
  Position({
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
  // ignore: hash_and_equals
  bool operator ==(Object other) {
    if (other is String) {
      return barcodeUID == other;
    } else if (other is RealInterBarcodeVector) {
      return barcodeUID == other.startBarcodeUID;
    } else {
      return false;
    }
  }

  Map toJson() => {
        'barcodeUID': barcodeUID,
        'x': position?.x,
        'y': position?.y,
        'z': position?.z,
      };

  factory Position.fromJson(json) {
    return Position(
      barcodeUID: json['barcodeUID'],
      position: vm.Vector3(json['x'], json['y'], json['z']),
    );
  }

  @override
  String toString() {
    return '\nUID: $barcodeUID, X: ${position?.x}, Y: ${position?.y}, Z: ${position?.z}';
  }
}
