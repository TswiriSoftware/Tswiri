///Accelerometer Data
class RawUserAccelerometerZAxisData {
  RawUserAccelerometerZAxisData({
    required this.timestamp,
    required this.rawAcceleration,
  });

  ///Timestamp of when the data was collected
  int timestamp;

  ///Instant Acceleration
  double rawAcceleration;

  @override
  String toString() {
    return '$timestamp, $rawAcceleration';
  }
}

//Stores the timestamp and totalDistance from camera
class ProcessedUserAccelerometerZAxisData {
  ProcessedUserAccelerometerZAxisData({
    required this.timestamp,
    required this.barcodeDistanceFromCamera,
  });

  ///Timestamp of when the data was collected
  int timestamp;

  ///Distance from Barcode
  double barcodeDistanceFromCamera;

  @override
  String toString() {
    return '$timestamp, $barcodeDistanceFromCamera';
  }
}
