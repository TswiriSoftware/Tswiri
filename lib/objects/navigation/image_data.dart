import 'dart:isolate';
import 'dart:typed_data';
import 'package:flutter_google_ml_kit/objects/reworked/accelerometer_data.dart';
import 'package:vector_math/vector_math.dart';

///This is the
class ImageMessage {
  ImageMessage({
    required this.bytes,
    required this.accelerometerData,
    required this.timestamp,
  });

  ///Identifier. [String]
  final String identifier = 'ImageDataMessage';

  ///Image Bytes. [Uint8List]
  final Uint8List bytes;

  ///Accelerometer Data. [AccelerometerData]
  final AccelerometerData accelerometerData;

  ///Timestamp. [int]
  final int timestamp;

  List toMessage() {
    return [
      identifier, // Identifier [0]
      TransferableTypedData.fromList([bytes]), //Bytes [1]
      [
        //Accelerometer Data [2]
        accelerometerData.accelerometerEvent.x,
        accelerometerData.accelerometerEvent.y,
        accelerometerData.accelerometerEvent.z,
        accelerometerData.userAccelerometerEvent.x,
        accelerometerData.userAccelerometerEvent.y,
        accelerometerData.userAccelerometerEvent.z,
      ],
      timestamp, //Timestamp [3]
    ];
  }

  factory ImageMessage.fromMessage(message) {
    return ImageMessage(
        bytes:
            (message[1] as TransferableTypedData).materialize().asUint8List(),
        accelerometerData: AccelerometerData(
            accelerometerEvent: Vector3(
              message[2][0],
              message[2][1],
              message[2][2],
            ),
            userAccelerometerEvent: Vector3(
              message[2][3],
              message[2][4],
              message[2][5],
            )),
        timestamp: message[3]);
  }
}
