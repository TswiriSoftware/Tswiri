import 'dart:math' as m;

class TensorData {
  TensorData({required this.cp, required this.angle});
  List<m.Point<int>> cp;
  List<double> angle;

  @override
  String toString() {
    return '${cp[0]}, ${cp[1]}, ${cp[2]}, ${cp[2]}, ${angle[0]}, ${angle[1]}, ${angle[2]}';
  }
}
