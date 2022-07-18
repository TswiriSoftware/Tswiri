import 'dart:ui';

Offset calculateBarcodeCenter(List<Offset> offsetPoints) {
  return (offsetPoints[0] +
          offsetPoints[1] +
          offsetPoints[2] +
          offsetPoints[3]) /
      4;
}
