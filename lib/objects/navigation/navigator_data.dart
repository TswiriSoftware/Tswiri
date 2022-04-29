import 'dart:ui';

class NavigatorData {
  NavigatorData({
    required this.barcodeUID,
    required this.offsetToScreenCenter,
  });
  final String barcodeUID;
  final Offset offsetToScreenCenter;

  Map toJson() {
    return {
      'barcodeUID': barcodeUID,
      'offsetToScreenCenterX': offsetToScreenCenter.dx,
      'offsetToScreenCenterY': offsetToScreenCenter.dy,
    };
  }

  @override
  String toString() {
    return '\nbarcodeUID: $barcodeUID, offsetToCenter: $offsetToScreenCenter';
  }
}
