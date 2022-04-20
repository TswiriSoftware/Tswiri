import 'dart:io';
import 'package:flutter_google_ml_kit/isar_database/photo_tag/photo_tag.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/ml_tag/ml_tag.dart';
import 'package:flutter_google_ml_kit/sunbird_views/app_settings/app_settings.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../isar_database/container_photo/container_photo.dart';
import '../../objects/image_data.dart';
import 'painter/object_detector_painter.dart';

///Displays the Photo and objects detected
class ObjectDetectorProcessingView extends StatefulWidget {
  const ObjectDetectorProcessingView(
      {Key? key,
      required this.imagePath,
      this.customColor,
      required this.containerUID})
      : super(key: key);
  final String imagePath;
  final Color? customColor;
  final String containerUID;

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

  //late String imagePath;

  List<PhotoTag> photoTags = [];
  List<MlTag> newMlTags = [];

  bool isDone = false;

  String? photoPath;
  String? photoThumbnailPath;

  late Future<ImageData> _future;

  @override
  void initState() {
    //Image Path.
    _future = processImage(widget.imagePath);
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
                Navigator.pop(context);
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
              File(widget.imagePath),
              alignment: Alignment.topCenter,
            ),
            FutureBuilder<ImageData>(
                future: _future,
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

    //Label image if it is enabled with GoogleMLKitImageLabeling.
    if (googleImageLabeling) {
      imageLabels.addAll(await getImageLabels(
          inputImage, googleImageLabelingConfidenceThreshold / 100));
    }

    //InceptionV4 products if enabled.
    if (inceptionV4) {
      detectedObjects.addAll(await getObjectsOnImage(inceptionV4Model,
          inceptionV4PreferenceConfidenceThreshold / 100, inputImage));
    }

    //Processing
    photoTags = [];

    //Objects
    for (DetectedObject object in detectedObjects) {
      List<Label> objectLabels = object.getLabels();

      List<double> boundingBox = [
        object.getBoundinBox().left,
        object.getBoundinBox().top,
        object.getBoundinBox().right,
        object.getBoundinBox().bottom
      ];

      for (Label objectLabel in objectLabels) {
        //Tag Text.
        String tag = objectLabel.getText().toLowerCase();

        //Check if it exists
        MlTag? existingMlTag = isarDatabase!.mlTags
            .where()
            .filter()
            .tagMatches(tag)
            .and()
            .tagTypeEqualTo(mlTagType.objectLabel)
            .findFirstSync();

        if (existingMlTag != null) {
          PhotoTag photoTag = PhotoTag()
            ..photoPath = photoFilePath
            ..confidence = objectLabel.getConfidence()
            ..boundingBox = boundingBox
            ..tagUID = existingMlTag.id;

          photoTags.add(photoTag);
        } else {
          //Create new mlTag.
          MlTag mlTag = MlTag()
            ..tag = tag
            ..tagType = mlTagType.objectLabel;

          isarDatabase!.writeTxnSync((isar) => isar.mlTags.putSync(mlTag));

          PhotoTag photoTag = PhotoTag()
            ..photoPath = photoFilePath
            ..confidence = objectLabel.getConfidence()
            ..boundingBox = boundingBox
            ..tagUID = isarDatabase!.mlTags
                .filter()
                .tagMatches(mlTag.tag)
                .findFirstSync()!
                .id;

          photoTags.add(photoTag);
        }
      }
    }

    //Image Labels
    for (ImageLabel label in imageLabels) {
      //Tag Text.
      String tag = label.label.toLowerCase();

      //Check if it exists
      MlTag? existingMlTag = isarDatabase!.mlTags
          .where()
          .filter()
          .tagMatches(tag)
          .and()
          .tagTypeEqualTo(mlTagType.imageLabel)
          .findFirstSync();

      if (existingMlTag != null) {
        PhotoTag photoTag = PhotoTag()
          ..photoPath = photoFilePath
          ..confidence = label.confidence
          ..boundingBox = null
          ..tagUID = existingMlTag.id;

        photoTags.add(photoTag);
      } else {
        //Create new mlTag.
        MlTag mlTag = MlTag()
          ..tag = tag
          ..tagType = mlTagType.imageLabel;

        isarDatabase!.writeTxnSync((isar) => isar.mlTags.putSync(mlTag));

        PhotoTag photoTag = PhotoTag()
          ..photoPath = photoFilePath
          ..confidence = label.confidence
          ..boundingBox = null
          ..tagUID = isarDatabase!.mlTags
              .filter()
              .tagMatches(mlTag.tag)
              .and()
              .tagTypeEqualTo(mlTagType.imageLabel)
              .findFirstSync()!
              .id;

        photoTags.add(photoTag);
      }
    }

    //Text
    final RecognisedText recognisedText =
        await textDetector.processImage(inputImage);

    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        for (String word in line.text.split(' ').toList()) {
          //Tag Text.
          String tag = word.toLowerCase();

          //Check if it exists
          MlTag? existingMlTag = isarDatabase!.mlTags
              .where()
              .filter()
              .tagMatches(tag)
              .and()
              .tagTypeEqualTo(mlTagType.text)
              .findFirstSync();

          if (existingMlTag != null) {
            PhotoTag photoTag = PhotoTag()
              ..photoPath = photoFilePath
              ..confidence = 1.0
              ..boundingBox = null
              ..tagUID = existingMlTag.id;

            photoTags.add(photoTag);
          } else {
            //Create new mlTag.
            MlTag mlTag = MlTag()
              ..tag = tag
              ..tagType = mlTagType.text;

            isarDatabase!.writeTxnSync((isar) => isar.mlTags.putSync(mlTag));

            PhotoTag photoTag = PhotoTag()
              ..photoPath = photoFilePath
              ..confidence = 1.0
              ..boundingBox = null
              ..tagUID = isarDatabase!.mlTags
                  .filter()
                  .tagMatches(mlTag.tag)
                  .and()
                  .tagTypeEqualTo(mlTagType.text)
                  .findFirstSync()!
                  .id;

            photoTags.add(photoTag);
          }
        }
      }
    }

    //Create containerPhoto.
    ContainerPhoto newContainerPhoto = ContainerPhoto()
      ..containerUID = widget.containerUID
      ..photoPath = photoFilePath
      ..photoThumbnailPath = thumbnailPhotoPath;

    //Write to database.
    isarDatabase!.writeTxnSync((isar) {
      isar.containerPhotos.putSync(newContainerPhoto);

      isar.photoTags.putAllSync(photoTags);
    });

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

    if (isDone == false) {
      isDone = true;
      setState(() {});
    }

    return processedResult;
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
