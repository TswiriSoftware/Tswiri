import 'package:vector_math/vector_math.dart';

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
}
