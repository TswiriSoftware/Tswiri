import 'dart:developer';
import 'dart:io';
import 'package:flutter_google_ml_kit/isar_database/photo/photo.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/ml_tag/ml_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/tag_bounding_box/tag_bounding_box.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/tag_text/tag_text.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/sunbird_views/app_settings/app_settings.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../objects/photo_tagging/image_data.dart';
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

  List<Photo> photos = [];
  List<MlTag> mlTags = [];

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

    ///Processing///
    photos = [];

    //1. Create the photo reference.
    Photo photo = Photo()
      ..containerUID = widget.containerUID
      ..photoPath = photoFilePath
      ..thumbnailPath = thumbnailPhotoPath;

    isarDatabase!.writeTxnSync((isar) => isar.photos.putSync(photo));

    //2. Create Object Labels.
    for (DetectedObject object in detectedObjects) {
      //i. Get object Labels.
      List<Label> objectLabels = object.getLabels();
      //ii. Get Object BoundingBox.
      List<double> boundingBox = [
        object.getBoundinBox().left,
        object.getBoundinBox().top,
        object.getBoundinBox().right,
        object.getBoundinBox().bottom
      ];

      //iii. Create MlTags for each label.
      for (Label objectLabel in objectLabels) {
        //iv. Label Text.
        String labelText = objectLabel.getText().toLowerCase();

        //v. Check if label text exists.
        TagText? tagText = isarDatabase!.tagTexts
            .filter()
            .tagMatches(labelText)
            .findFirstSync();

        //vi. Create new TagText.
        if (tagText == null) {
          tagText = TagText()..tag = labelText;
          isarDatabase!.writeTxnSync((isar) => isar.tagTexts.putSync(tagText!));
        }

        //vii. Create MlTag.
        MlTag mlTag = MlTag()
          ..mlTagID = photo.id
          ..tagType = mlTagType.objectLabel
          ..textTagID = tagText.id
          ..confidence = objectLabel.getConfidence()
          ..blackListed = false;
        isarDatabase!.writeTxnSync((isar) => isar.mlTags.putSync(mlTag));

        //viii. Create BoundingBox.
        TagBoundingBox tagBoundingBox = TagBoundingBox()
          ..mlTagID = mlTag.mlTagID
          ..boundingBox = boundingBox;
        isarDatabase!.writeTxnSync(
            (isar) => isar.tagBoundingBoxs.putSync(tagBoundingBox));
      }
    }

    //3. Create Image Labels.
    for (ImageLabel label in imageLabels) {
      //i. Label Text.
      String labelText = label.label.toLowerCase();

      //ii. Check if label text exists.
      TagText? tagText =
          isarDatabase!.tagTexts.filter().tagMatches(labelText).findFirstSync();

      //iii. Create new TagText.
      if (tagText == null) {
        tagText = TagText()..tag = labelText;
        isarDatabase!.writeTxnSync((isar) => isar.tagTexts.putSync(tagText!));
      }

      //iv. Create MlTag.
      MlTag mlTag = MlTag()
        ..mlTagID = photo.id
        ..tagType = mlTagType.imageLabel
        ..textTagID = tagText.id
        ..confidence = label.confidence
        ..blackListed = false;
      isarDatabase!.writeTxnSync((isar) => isar.mlTags.putSync(mlTag));
    }

    //4. Text Labels.
    final RecognisedText recognisedText =
        await textDetector.processImage(inputImage);

    for (TextBlock block in recognisedText.blocks) {
      log(block.text);

      for (TextLine line in block.lines) {
        for (String word in line.text.split(' ').toList()) {
          //TODO: implement spell checker/dictionary.

          //i. Label Text.
          String labelText = word.toLowerCase();

          if (labelText.length > 3) {
            //ii. Check if label text exists.
            TagText? tagText = isarDatabase!.tagTexts
                .filter()
                .tagMatches(labelText)
                .findFirstSync();

            //iii. Create new TagText.
            if (tagText == null) {
              tagText = TagText()..tag = labelText;
              isarDatabase!
                  .writeTxnSync((isar) => isar.tagTexts.putSync(tagText!));
            }

            //iv. Create MlTag.
            MlTag mlTag = MlTag()
              ..mlTagID = photo.id
              ..tagType = mlTagType.text
              ..textTagID = tagText.id
              ..confidence = 0.99
              ..blackListed = false;
            isarDatabase!.writeTxnSync((isar) => isar.mlTags.putSync(mlTag));
          }
        }
      }
    }

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
