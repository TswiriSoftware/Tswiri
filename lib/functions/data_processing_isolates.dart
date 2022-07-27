import 'package:sunbird/classes/inter_barcode_vector.dart';
import 'package:sunbird/classes/on_image_barcode_data.dart';
import 'package:sunbird/classes/on_image_inter_barcode_data.dart';
import 'package:sunbird/extentions/distinct_by.dart';
import 'package:sunbird/isar/collections/cataloged_barcode/cataloged_barcode.dart';
import 'package:sunbird/isar/collections/cataloged_coordinate/cataloged_coordinate.dart';

/// Convert onImageInterbarcodeData -> onImageInterbarcodeData-> realInterBarcodeVectors
List<InterBarcodeVector> createInterBarcodeVectors(
    List message,
    List<CatalogedBarcode> barcodeProperties,
    double focalLength,
    double passedDefaultBarcodeSize) {
  //1. Convert message to InImageBarcodeData.
  List<OnImageBarcodeData> onImageBarcodeData = [];
  if (message.isNotEmpty) {
    for (List item in message) {
      onImageBarcodeData.add(OnImageBarcodeData.fromMessage(item));
    }
  }

  //2. Create OnImageInterBarcodeData.
  List<OnImageInterBarcodeData> onImageInterBarcodes = [];
  for (var x = 0; x < onImageBarcodeData.length; x++) {
    for (var i = 0; i < onImageBarcodeData.length; i++) {
      if (i != x) {
        OnImageInterBarcodeData onImageInterBarcodeData =
            OnImageInterBarcodeData.fromBarcodeDataPair(
                onImageBarcodeData[i], onImageBarcodeData[x]);

        if (!onImageInterBarcodes.contains(onImageInterBarcodeData)) {
          onImageInterBarcodes.add(onImageInterBarcodeData);
        }
      }
    }
  }

  //3. Create RealInterBarcodeVectos;
  List<InterBarcodeVector> realInterBarcodeVectors = [];
  for (OnImageInterBarcodeData onImageInterBarcodes in onImageInterBarcodes) {
    InterBarcodeVector realInterBarcodeVector =
        InterBarcodeVector.fromRawInterBarcodeData(
      interBarcodeData: onImageInterBarcodes,
      barcodeProperties: barcodeProperties,
      focalLength: focalLength,
      passedDefaultBarcodeSize: passedDefaultBarcodeSize,
    );

    realInterBarcodeVectors.add(realInterBarcodeVector);
  }

  return realInterBarcodeVectors;
}

///Averages the interBarcodeVectors with more than 8 copies.
List<InterBarcodeVector> averageInterBarcodeVectors(
    List<InterBarcodeVector> realInterBarcodeVectors) {
  List<InterBarcodeVector> averagedInterBarcodeVectors = [];

  //1. Get a list of all unique vectors.
  List<InterBarcodeVector> uniqueVectors =
      realInterBarcodeVectors.distinctBy((x) => x.uid).toList();

  //2. Loop through uniqueVectors.
  for (InterBarcodeVector uniqueVector in uniqueVectors) {
    //i. Find similar vectors. (These vectors have the same uid as the unique vector)
    List<InterBarcodeVector> similarVectors = realInterBarcodeVectors
        .where((element) => element.uid == uniqueVector.uid)
        .toList();

    //ii. Check if there are more than 8.
    if (similarVectors.length >= 3) {
      // //iii. Sort by vector length.
      // similarVectors
      //     .sort((a, b) => a.vector3.length.compareTo(b.vector3.length));

      // //iv. Remove any outliers.
      // //Indexes (Stats).
      // int medianIndex = (similarVectors.length ~/ 2);
      // int quartile1Index = ((similarVectors.length / 2) ~/ 2);
      // int quartile3Index = medianIndex + quartile1Index;

      // //Values of indexes.
      // double median = similarVectors[medianIndex].vector3.length;
      // double quartile1 =
      //     calculateQuartileValue(similarVectors, quartile1Index, median);
      // double quartile3 =
      //     calculateQuartileValue(similarVectors, quartile3Index, median);

      // //Boundry calculations.
      // double interQuartileRange = quartile3 - quartile1;
      // double q1Boundry = quartile1 - interQuartileRange * 1.5; //Lower boundry
      // double q3Boundry = quartile3 + interQuartileRange * 1.5; //Upper boundry

      // //Remove data outside the boundries.
      // similarVectors.removeWhere((element) =>
      //     element.vector3.length <= q1Boundry &&
      //     element.vector3.length >= q3Boundry);

      //v. Caluclate the average.
      for (InterBarcodeVector similarVector in similarVectors) {
        //Average the similar interBarcodeData.
        uniqueVector.vector3.x =
            (uniqueVector.vector3.x + similarVector.vector3.x) / 2;
        uniqueVector.vector3.y =
            (uniqueVector.vector3.y + similarVector.vector3.y) / 2;
        uniqueVector.vector3.z =
            (uniqueVector.vector3.z + similarVector.vector3.z) / 2;
      }
      averagedInterBarcodeVectors.add(uniqueVector);
    }
  }

  return averagedInterBarcodeVectors;
}

///Checks if the coordinate's positions are within a given error (mm)
/// - False if it has NOT moved.
/// - True if it HAS moved.
bool hasMoved(CatalogedCoordinate newCoordinate,
    CatalogedCoordinate storedCoordinate, double error) {
  if (storedCoordinate.coordinate!.x + error >= newCoordinate.coordinate!.x &&
      storedCoordinate.coordinate!.x - error <= newCoordinate.coordinate!.x &&
      storedCoordinate.coordinate!.y + error >= newCoordinate.coordinate!.y &&
      storedCoordinate.coordinate!.y - error <= newCoordinate.coordinate!.y &&
      storedCoordinate.coordinate!.z + error >= newCoordinate.coordinate!.z &&
      storedCoordinate.coordinate!.z - error <= newCoordinate.coordinate!.z) {
    //Returns false if it has not moved.
    return false;
  }
  //Returns true if it has moved.
  return true;
}
