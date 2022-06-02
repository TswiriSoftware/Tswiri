import 'dart:math';
import 'dart:ui';
import 'package:flutter_google_ml_kit/functions/barcode_calculations/calculate_barcode_center_from_bounding_box.dart';
import 'package:flutter_google_ml_kit/functions/barcode_calculations/calculate_barcode_center_from_corner_points.dart';
import 'package:flutter_google_ml_kit/functions/barcode_calculations/calculate_offset_between_points.dart';
import 'package:flutter_google_ml_kit/functions/barcode_calculations/calculate_barcode_diagonal_length.dart';
import 'package:flutter_google_ml_kit/functions/barcode_calculations/calculate_phone_angle.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:vector_math/vector_math.dart';

//Calculation Tester.
void main() {
  //Test 1. (Calculate Offset Between Two Points)
  late Offset offsetBetweenPoints;

  setUp(() {
    offsetBetweenPoints =
        calculateOffsetBetweenTwoPoints(const Offset(5, 5), const Offset(5, 5));
  });

  Offset result = const Offset(0, 0);

  test('Offset Between Points', () {
    expect(result, offsetBetweenPoints);
  });

  //Test 2. (Calculate Average Barcode Diagonal Length)
  late double barcodeDiagonalLength;
  Barcode barcode = Barcode(
      type: BarcodeType.text,
      format: BarcodeFormat.qrCode,
      displayValue: '1_101',
      rawValue: '1_101',
      rawBytes: null,
      boundingBox: const Rect.fromLTWH(10, 10, 10, 10),
      cornerPoints: [
        const Point(0, 0),
        const Point(10, 0),
        const Point(0, 12),
        const Point(11, 10),
      ],
      value: null);

  setUp(() {
    barcodeDiagonalLength = calculateBarcodeDiagonalLength(barcode);
  });

  test('Average Diagonal Length Calculator', () {
    expect(11.024937810560445, barcodeDiagonalLength);
  });

  //Test 3. (Calculate Barcode Center From BoundingBox)
  late Offset barcodeCenterPoint;

  setUp(() {
    barcodeCenterPoint = calculateBarcodeCenterFromBoundingBox(barcode);
  });

  test('Barcode Center Point', () {
    expect(const Offset(15.0, 15.0), barcodeCenterPoint);
  });

  //Test 4. (Calculate phone angle relative to gravity)
  late double angleRadians;
  Vector3 gravityDirection = Vector3(1, 0, 0);

  setUp(() {
    angleRadians = calculatePhoneAngle(gravityDirection);
  });

  test('Phone Angle', () {
    expect(angleRadians, -1.5707963267948966);
  });

  //Test 4. (Calculate Center from CornerPoints)
  late Offset center;
  List<Offset> offsetPoints = [
    const Offset(0, 0),
    const Offset(10, 0),
    const Offset(0, 9),
    const Offset(12, 15),
  ];

  setUp(() {
    center = calculateCenterFromCornerPoints(offsetPoints);
  });

  test('Center from CornerPoints', () {
    expect(center, const Offset(5.5, 6.0));
  });
}
