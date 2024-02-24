import 'dart:ui';

Offset calculateBarcodeCenter(List<Offset> offsetPoints) {
  assert(offsetPoints.length == 4, 'Offset points must be 4');

  final sum = offsetPoints.fold<Offset>(Offset.zero, (previousValue, element) {
    return previousValue + element;
  });

  return sum / 4;
}
