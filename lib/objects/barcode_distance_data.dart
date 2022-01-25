class BarcodeDistanceData {
  BarcodeDistanceData(
    this.timestamp,
    this.imageSize,
    this.distance,
  );

  final int timestamp;
  final double imageSize;
  final double distance;

  @override
  String toString() {
    return '$timestamp, $imageSize, $distance';
  }
}
