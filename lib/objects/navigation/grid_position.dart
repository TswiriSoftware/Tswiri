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

  @override
  String toString() {
    // TODO: implement toString
    return '\nUID: $barcodeUID, X: ${position?.x}, Y: ${position?.y}, Z: ${position?.z}';
  }
}
