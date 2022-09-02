// ignore_for_file: depend_on_referenced_packages
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:image/image.dart' as img;

///Checks if the input image has is black.
///returns a bool
bool checkIfCameraFeedIsBlack(InputImage inputImage) {
  //Convert the image to a bitmap 100x100
  img.Image bitmap =
      img.Image.fromBytes(100, 100, inputImage.bytes!, format: img.Format.rgba);

  //Counters to keep track of the pixel colour values.
  int redBucket = 0;
  int greenBucket = 0;
  int blueBucket = 0;
  //Count the number of pixels checked.
  int pixelCount = 0;

  //Run through the image.
  for (int y = 0; y < bitmap.height; y++) {
    for (int x = 0; x < bitmap.width; x++) {
      int c = bitmap.getPixel(x, y);
      pixelCount++;
      redBucket += img.getRed(c);
      greenBucket += img.getGreen(c);
      blueBucket += img.getBlue(c);
    }
  }

  //Calculate the average colour value of the image.
  //Note:
  //The more colour the image has the higher the average colour value will be.
  //The more black an image is the lower this average colour will be.
  //It is set to 15 units at the moment which is pretty much black.
  double averageColorValue = ((redBucket / pixelCount) +
          (greenBucket / pixelCount) +
          (blueBucket / pixelCount)) /
      3;

  if (averageColorValue <= 15) {
    return true;
  } else {
    return false;
  }
}
