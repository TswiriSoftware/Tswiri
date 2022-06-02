// ignore: depend_on_referenced_packages
import 'package:vector_math/vector_math.dart' as vm;

///Calculate the phone angle on the X-Y plane.
double calculatePhoneAngle(vm.Vector3 gravityDirection3D) {
  //Convert to 2D plane X-Y
  vm.Vector2 gravityDirection2D =
      vm.Vector2(gravityDirection3D.x, gravityDirection3D.y);
  vm.Vector2 zero = vm.Vector2(0, 1);
  double angleRadians = gravityDirection2D.angleTo(zero);
  if (gravityDirection2D.x >= 0) {
    angleRadians = -angleRadians;
  }
  return angleRadians;
}
