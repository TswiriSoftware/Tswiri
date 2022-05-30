import 'package:flutter_google_ml_kit/sunbird_views/barcodes/barcode_scanning/barcode_position_scanner/interbarcode_vector.dart';

///Remove outliers and calculate the average.
///
///   i. Generate list of unique RealInterBarcodeData.
///
///   ii. find similar RealInterbarcodeData.
///
///   iii. Sort similarInterBarcodeOffsets by the length of the vector.
///
///   iv. Remove any outliers.
///
///   v. Caluclate the average.
///
///   vi. Add to finalRealInterBarcodeData.
///
List<InterBarcodeVector> averageInterbarcodeData(
    List<InterBarcodeVector> interBarcodeVectors) {
  List<InterBarcodeVector> uniqueRealInterBarcodeData =
      interBarcodeVectors.toSet().toList();
  List<InterBarcodeVector> finalRealInterBarcodeData = [];
  for (InterBarcodeVector uniqueRealInterBarcodeData
      in uniqueRealInterBarcodeData) {
    //ii. find similar realInterBarcodeData.

    List<InterBarcodeVector> similarRealInterBarcodeData = interBarcodeVectors
        .where((element) => (element.startBarcodeUID ==
                uniqueRealInterBarcodeData.startBarcodeUID &&
            element.endBarcodeUID == uniqueRealInterBarcodeData.endBarcodeUID))
        .toList();

    //iii. Sort similarInterBarcodeOffsets by the length of the vector.
    similarRealInterBarcodeData
        .sort((a, b) => a.vector3.length.compareTo(b.vector3.length));

    //iv. Remove any outliers.
    //Indexes (Stats).
    int medianIndex = (similarRealInterBarcodeData.length ~/ 2);
    int quartile1Index = ((similarRealInterBarcodeData.length / 2) ~/ 2);
    int quartile3Index = medianIndex + quartile1Index;

    //Values of indexes.
    double median = similarRealInterBarcodeData[medianIndex].vector3.length;
    double quartile1 = calculateQuartileValue(
        similarRealInterBarcodeData, quartile1Index, median);
    double quartile3 = calculateQuartileValue(
        similarRealInterBarcodeData, quartile3Index, median);

    //Boundry calculations.
    double interQuartileRange = quartile3 - quartile1;
    double q1Boundry = quartile1 - interQuartileRange * 1.5; //Lower boundry
    double q3Boundry = quartile3 + interQuartileRange * 1.5; //Upper boundry

    //Remove data outside the boundries.
    similarRealInterBarcodeData.removeWhere((element) =>
        element.vector3.length <= q1Boundry &&
        element.vector3.length >= q3Boundry);

    //v. Caluclate the average.
    for (InterBarcodeVector similarInterBarcodeOffset
        in similarRealInterBarcodeData) {
      //Average the similar interBarcodeData.
      uniqueRealInterBarcodeData.vector3.x =
          (uniqueRealInterBarcodeData.vector3.x +
                  similarInterBarcodeOffset.vector3.x) /
              2;
      uniqueRealInterBarcodeData.vector3.y =
          (uniqueRealInterBarcodeData.vector3.y +
                  similarInterBarcodeOffset.vector3.y) /
              2;
      uniqueRealInterBarcodeData.vector3.z =
          (uniqueRealInterBarcodeData.vector3.z +
                  similarInterBarcodeOffset.vector3.z) /
              2;
    }
    //vi. Add to finalRealInterBarcodeData.
    finalRealInterBarcodeData.add(uniqueRealInterBarcodeData);
  }
  return finalRealInterBarcodeData;
}

//Calculates the quartile value.
double calculateQuartileValue(
    List<InterBarcodeVector> similarInterBarcodeOffsets,
    int quartile1Index,
    double median) {
  return (similarInterBarcodeOffsets[quartile1Index].vector3.length + median) /
      2;
}
