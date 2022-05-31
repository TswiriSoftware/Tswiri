import 'package:flutter_google_ml_kit/isar_database/grid/coordinate_entry/coordinate_entry.dart';

List<double> calculateUnitVectors(
    {required List<CoordinateEntry> coordinateEntries,
    required double width,
    required double height}) {
  double sX = 0;
  double bX = 0;
  double sY = 0;
  double bY = 0;

  for (var i = 0; i < coordinateEntries.length; i++) {
    CoordinateEntry coordiante = coordinateEntries.elementAt(i);

    if (coordiante.x != null && coordiante.y != null && coordiante.z != null) {
      double xDistance = coordiante.vector()!.x;
      double yDistance = coordiante.vector()!.y;
      if (xDistance < sX) {
        sX = xDistance;
      }
      if (xDistance > bX) {
        bX = xDistance;
      }
      if (yDistance < sY) {
        sY = yDistance;
      }
      if (yDistance > bY) {
        bY = yDistance;
      }
    }
  }

  double totalXdistance = (sX - bX).abs() + 500;
  double totalYdistance = (sY - bY).abs() + 500;

  double unitX = width / 2 / totalXdistance;
  double unitY = height / 2 / totalYdistance;

  return [unitX, unitY];
}
