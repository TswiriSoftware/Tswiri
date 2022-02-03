import 'dart:ui';

class RealWorkingData {
  String uid;
  Offset? interBarcodeOffset;
  int timestamp;
  RealWorkingData(this.uid, this.interBarcodeOffset, this.timestamp);

  @override
  bool operator ==(Object other) {
    return other is RealWorkingData && hashCode == other.hashCode;
  }

  @override
  int get hashCode => (uid).hashCode;

  @override
  String toString() {
    // TODO: implement toString
    return '$uid, ${interBarcodeOffset ?? ''}, $timestamp';
  }
}
