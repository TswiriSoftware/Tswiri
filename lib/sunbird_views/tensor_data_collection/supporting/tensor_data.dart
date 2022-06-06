import 'dart:math';

class TensorData {
  TensorData({required this.cornerPoints});
  List<Point<int>> cornerPoints;

  @override
  String toString() {
    return '${cornerPoints[0]}, ${cornerPoints[1]}, ${cornerPoints[2]}, ${cornerPoints[2]}';
  }
}
