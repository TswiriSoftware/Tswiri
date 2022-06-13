import 'dart:math' as m;

class TensorData {
  TensorData({required this.cp});
  List<m.Point<int>> cp;

  @override
  String toString() {
    return '${cp[0]}, ${cp[1]}, ${cp[2]}, ${cp[2]}';
  }
}
