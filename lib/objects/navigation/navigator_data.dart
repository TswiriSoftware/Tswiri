import 'dart:ui';

class NavigatorData {
  NavigatorData({
    required this.barcodeUID,
    required this.offsetToScreenCenter,
  });
  final String barcodeUID;
  final Offset offsetToScreenCenter;

  @override
  String toString() {
    return '\nbarcodeUID: $barcodeUID, offsetToCenter: $offsetToScreenCenter';
  }
}
