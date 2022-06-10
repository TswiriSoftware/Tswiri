import 'dart:developer';
import 'dart:math' as m;
import 'dart:ui';
import 'package:flutter_google_ml_kit/extentions/round_double.dart';
import 'package:flutter_google_ml_kit/functions/math_functionts/round_to_double.dart';
import 'package:vector_math/vector_math.dart';

class TensorData {
  TensorData({required this.cornerPoints});
  List<m.Point<int>> cornerPoints;

  //Write Function that normalizes points :D
  List<Vector2> normalizeCornerPoints() {
    List<Vector2> vectors = cornerPoints
        .map((e) => Vector2(e.x.toDouble(), e.y.toDouble()))
        .toList();

    // log(vectors.toString());

    Vector2 longest = vectors[0];

    for (var v in vectors) {
      if (longest.length < v.length) {
        longest = v;
      }
    }

    List<Vector2> normalizedVectors = vectors
        .map((e) => Vector2(
            (e.x / longest.x).toPrecision(4), (e.y / longest.y).toPrecision(4)))
        .toList();

    // int xMax = 0;
    // int xMin = 0;
    // int yMax = 0;
    // int yMin = 0;

    // Point? point = cornerPoints[0];
    // for (var point in cornerPoints) {
    //   //Get the min/max of X.
    //   if (point.x > xMax) {
    //     xMax = point.x;
    //   } else if (point.x < xMin) {
    //     xMin = point.x;
    //   }
    //   //Get the min/max of Y.
    //   if (point.y > yMax) {
    //     yMax = point.y;
    //   } else if (point.y < yMin) {
    //     yMin = point.y;
    //   }
    // }

    // //The unit 'vector'.
    // int x = xMax - xMin;
    // int y = yMax - yMin;
    // //Convert the points to unit vector.
    // List<Point<double>> convertedPoints =
    //     cornerPoints.map((e) => Point<double>(e.x / x, e.y / y)).toList();

    return normalizedVectors;
  }

  @override
  String toString() {
    return '${cornerPoints[0]}, ${cornerPoints[1]}, ${cornerPoints[2]}, ${cornerPoints[2]}';
  }
}
