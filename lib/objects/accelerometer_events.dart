import 'package:vector_math/vector_math.dart';
import 'dart:math';

class AccelerometerEvents {
  Vector3 userAccelerometerEvent;
  Vector3 accelerometerEvent;
  AccelerometerEvents(
      {required this.accelerometerEvent, required this.userAccelerometerEvent});

  ///Returns the angle between the Y-axis and the phone in radians.
  double calculatePhoneAngle() {
    //This is the 3D orientation of the phone
    Vector3 gravityDirection3D = accelerometerEvent - userAccelerometerEvent;

    Vector2 gravityDirection2D =
        Vector2(gravityDirection3D.x, gravityDirection3D.y);
    Vector2 realUp = Vector2(0, 1);
    double angleRadians = gravityDirection2D.angleTo(realUp);
    if (gravityDirection2D.x >= 0) {
      angleRadians = -angleRadians;
    }

    print(gravityDirection2D);
    print(angleRadians);
    return angleRadians;
  }
}
