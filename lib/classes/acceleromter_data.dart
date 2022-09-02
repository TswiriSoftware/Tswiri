// ignore_for_file: depend_on_referenced_packages

import 'package:vector_math/vector_math_64.dart';

///This is used to store accelerometer Data and to calculate the phones angle relative to gravity.
class AccelerometerData {
  Vector3 userAccelerometerEvent;
  Vector3 accelerometerEvent;

  AccelerometerData(
      {required this.accelerometerEvent, required this.userAccelerometerEvent});

  ///Returns the angle between the Y-axis and the phone in radians.
  double calculatePhoneAngle() {
    //This is the 3D orientation of the phone
    Vector3 gravityDirection3D = accelerometerEvent - userAccelerometerEvent;

    //Convert to 2D plane X-Y
    Vector2 gravityDirection2D =
        Vector2(gravityDirection3D.x, gravityDirection3D.y);

    Vector2 zero = Vector2(0, 1);

    double angleRadians = gravityDirection2D.angleTo(zero);
    if (gravityDirection2D.x >= 0) {
      angleRadians = -angleRadians;
    }

    return angleRadians;
  }

  Map<String, dynamic> toJson() => {
        'uaeX': userAccelerometerEvent.x,
        'uaeY': userAccelerometerEvent.y,
        'uaeZ': userAccelerometerEvent.z,
        'aeX': accelerometerEvent.x,
        'aeY': accelerometerEvent.y,
        'aeZ': accelerometerEvent.z,
      };

  factory AccelerometerData.fromJson(Map<String, dynamic> json) {
    return AccelerometerData(
        accelerometerEvent: Vector3(
          json['uaeX'] as double,
          json['uaeY'] as double,
          json['uaeZ'] as double,
        ),
        userAccelerometerEvent: Vector3(
          json['aeX'] as double,
          json['aeY'] as double,
          json['aeZ'] as double,
        ));
  }
}
