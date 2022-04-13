import 'dart:developer';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/ml_tag/ml_tag.dart';
import 'package:flutter_google_ml_kit/sunbird_views/app_settings/app_settings.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_manager/objects/photo_data.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../objects/image_data.dart';
import 'painter/object_detector_painter.dart';
import 'package:string_similarity/string_similarity.dart';

///Displays the Photo and objects detected
class ObjectDetectorProcessingView extends StatefulWidget {
  const ObjectDetectorProcessingView({
    Key? key,
    required this.imagePath,
    this.customColor,
    //required this.barcodeID,
  }) : super(key: key);
  final String imagePath;
  final Color? customColor;

  //final String barcodeID;
  @override
  _ObjectDetectorProcessingView createState() =>
      _ObjectDetectorProcessingView();
}

class _ObjectDetectorProcessingView
    extends State<ObjectDetectorProcessingView> {
  //Local Models
  LocalModel googleVisionProductsModel = LocalModel(
      'lite-model_on_device_vision_classifier_popular_us_products_V1_1.tflite');
  LocalModel inceptionV4Model =
      LocalModel('inception_v4_quant_1_metadata_1.tflite');

  //Text Detector.
  TextDetector textDetector = GoogleMlKit.vision.textDetector();

  late String imagePath;

  List<String> photoTags = [];
  PhotoData? photoData;

  bool isDone = false;

  String? photoPath;
  String? photoThumbnailPath;

  @override
  void initState() {
    //Image Path.
    imagePath = widget.imagePath;

    super.initState();
  }

  bool isBusy = false;
  CustomPaint? customPaint;

  @override
  void dispose() {
    textDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Builder(builder: (context) {
          if (isDone) {
            return FloatingActionButton(
              backgroundColor: widget.customColor ?? Colors.orange,
              heroTag: null,
              onPressed: () {
                Navigator.pop(context, photoData);
              },
              child: const Icon(Icons.check_circle_outline_rounded),
            );
          } else {
            return Row();
          }
        }),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: widget.customColor,
          centerTitle: true,
          title: Text(
            'Image Processing',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.file(
              File(imagePath),
              alignment: Alignment.topCenter,
            ),
            FutureBuilder<ImageData>(
                future: processImage(imagePath),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData && snapshot.data != null) {
                    return CustomPaint(
                      painter:
                          ObjectDetectorPainter(objectData: snapshot.data!),
                    );
                  }
                  return const Center(child: Text('No Objects Detected'));
                }),
          ],
        ));
  }

  Future<ImageData> processImage(String imagePath) async {
    //Get Image File.
    File imageFile = File(imagePath);
    String fileExtention = imageFile.path.split('.').last;
    String fileName = '${DateTime.now().millisecondsSinceEpoch}';

    //Get the Storage Path if it does not exist create it.
    String storagePath = await getStorageDirectory();
    if (!await Directory('$storagePath/sunbird').exists()) {
      Directory('$storagePath/sunbird').create();
    }

    //Create the photo file path.
    String photoFilePath = '$storagePath/sunbird/$fileName.' + fileExtention;

    String thumbnailPhotoPath =
        '$storagePath/sunbird/${fileName}_thumbnail.' + fileExtention;

    //Create Thumbnail
    var image = img.decodeJpg(imageFile.readAsBytesSync());
    var thumbnail = img.copyResize(image!, width: 120);

    File(thumbnailPhotoPath).writeAsBytesSync(img.encodePng(thumbnail));
    await imageFile.copy(photoFilePath);

    //Create InputImage.
    InputImage inputImage = InputImage.fromFile(imageFile);

    //List of labels.
    List<DetectedObject> detectedObjects = [];
    List<ImageLabel> imageLabels = [];

    //Label image if it is enabled.
    if (googleImageLabeling) {
      imageLabels.addAll(await getImageLabels(
          inputImage, googleImageLabelingConfidenceThreshold / 100));
    }

    // //Google vision products if enabled
    // if (googleVisionProducts) {
    //   detectedObjects.addAll(await getObjectsOnImage(googleVisionProductsModel,
    //       googleVisionProductsConfidenceThreshold / 100, inputImage));
    // }

    //InceptionV4 products if enabled
    if (inceptionV4) {
      detectedObjects.addAll(await getObjectsOnImage(inceptionV4Model,
          inceptionV4PreferenceConfidenceThreshold / 100, inputImage));
    }

    //Image Processing:

    //Objects
    for (DetectedObject object in detectedObjects) {
      List<Label> objectLabels = object.getLabels();
      for (Label objectLabel in objectLabels) {
        photoTags.add(objectLabel.getText());
      }
    }

    //Image Labels
    for (ImageLabel label in imageLabels) {
      log('Image Label: ' + label.label);
      photoTags.add(label.label);
    }

    //Text
    final RecognisedText recognisedText =
        await textDetector.processImage(inputImage);
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        if (line.text.length >= 3) {
          //photoTags.add(line.text.toLowerCase());
        }
      }
    }

    photoData = PhotoData(
      thumbnailPhotoPath: thumbnailPhotoPath,
      photoPath: photoFilePath,
      photoObjects: detectedObjects,
      photoLabels: imageLabels,
      recognisedTexts: recognisedText,
    );

    //Decode Image for properties
    var decodedImage = await decodeImageFromList(imageFile.readAsBytesSync());

    //Get Image Size
    Size imageSize =
        Size(decodedImage.height.toDouble(), decodedImage.width.toDouble());

    //Create the object that contains all data from the object Detector and Image Labeler.
    ImageData processedResult = ImageData(
        detectedObjects: detectedObjects,
        detectedLabels: imageLabels,
        detectedText: recognisedText,
        imageRotation: InputImageRotation.Rotation_90deg,
        size: imageSize);

    //If new mlTags are found they will be added to the database.
    createNewMlTags(detectedObjects, imageLabels, recognisedText);

    return processedResult;
  }

  void createNewMlTags(List<DetectedObject> detectedObjects,
      List<ImageLabel> imageLabels, RecognisedText recognisedTexts) {
    List<MlTag> newMlTags = [];

    for (DetectedObject detectedObject in detectedObjects) {
      for (Label label in detectedObject.getLabels()) {
        MlTag mlTag = MlTag()
          ..tag = label.getText().toLowerCase()
          ..tagType = mlTagType.objectLabel;

        if (isarDatabase!.mlTags
                .where()
                .filter()
                .tagMatches(mlTag.tag)
                .and()
                .tagTypeEqualTo(mlTagType.objectLabel)
                .findFirstSync() ==
            null) {
          newMlTags.add(mlTag);
        }
      }
    }

    for (ImageLabel imageLabel in imageLabels) {
      MlTag mlTag = MlTag()
        ..tag = imageLabel.label.toLowerCase()
        ..tagType = mlTagType.imageLabel;

      if (isarDatabase!.mlTags
              .where()
              .filter()
              .tagMatches(mlTag.tag)
              .and()
              .tagTypeEqualTo(mlTagType.imageLabel)
              .findFirstSync() ==
          null) {
        newMlTags.add(mlTag);
      }
    }

    List<String> existingTags = isarDatabase!.mlTags
        .where()
        .findAllSync()
        .where((element) => element.tagType == mlTagType.text)
        .map((e) => e.tag)
        .toList();

    log(existingTags.toString());

    for (TextBlock recognisedText in recognisedTexts.blocks) {
      MlTag mlTag = MlTag()
        ..tag = recognisedText.text.toLowerCase().trim()
        ..tagType = mlTagType.text;

      String similarTag = '';
      double similarity = 0;

      for (String existingTag in existingTags) {
        double currentSimilarity = mlTag.tag.similarityTo(existingTag);
        if (currentSimilarity > similarity) {
          similarTag = existingTag;
          similarity = currentSimilarity;
        }
      }

      if (similarity < 0.95) {
        if (isarDatabase!.mlTags
                .where()
                .filter()
                .tagMatches(mlTag.tag)
                .and()
                .tagTypeEqualTo(mlTagType.text)
                .findFirstSync() ==
            null) {
          newMlTags.add(mlTag);
        }
      }
    }

    //Write new ml tags.
    isarDatabase!.writeTxnSync(
      (isar) => isar.mlTags.putAllSync(newMlTags),
    );

    for (var item in newMlTags) {
      log(item.tag);
    }

    if (isDone == false) {
      isDone = true;
      setState(() {});
    }
  }

  Future<List<DetectedObject>> getObjectsOnImage(LocalModel localModel,
      double confidenceThreshold, InputImage inputImage) async {
    //Create objectDetector.
    ObjectDetector objectDetector = GoogleMlKit.vision.objectDetector(
      CustomObjectDetectorOptions(
        localModel,
        classifyObjects: true,
        confidenceThreshold: confidenceThreshold,
        trackMutipleObjects: true,
      ),
    );

    //Get list of objects.
    List<DetectedObject> detectedObjects =
        await objectDetector.processImage(inputImage);

    //Close object detector.
    objectDetector.close();

    return detectedObjects;
  }

  Future<List<ImageLabel>> getImageLabels(
      InputImage inputImage, double confidence) async {
    //Image labeler Config.
    ImageLabeler imageLabeler = GoogleMlKit.vision
        .imageLabeler(ImageLabelerOptions(confidenceThreshold: confidence));

    //Get list of objects.
    List<ImageLabel> detectedLabels =
        await imageLabeler.processImage(inputImage);

    //Close object detector.
    imageLabeler.close();

    return detectedLabels;
  }
}

Future<String> getStorageDirectory() async {
  if (Platform.isAndroid) {
    return (await getExternalStorageDirectory())!.path;
  } else {
    return (await getApplicationDocumentsDirectory()).path;
  }
}
