import 'dart:ui';

//TODO: add desctiption & definition
class RealBarcodePosition {
  String uid;
  Offset? interBarcodeOffset;
  int? timestamp;
  RealBarcodePosition(this.uid, this.interBarcodeOffset, this.timestamp);

  @override
  bool operator ==(Object other) {
    return other is RealBarcodePosition && hashCode == other.hashCode;
  }

  @override
  int get hashCode => (uid).hashCode;

  @override
  String toString() {
    // TODO: implement toString
    return '$uid, ${interBarcodeOffset}, $timestamp';
  }
}
