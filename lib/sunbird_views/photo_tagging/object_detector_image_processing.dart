import 'dart:io';
import 'package:flutter_google_ml_kit/extentions/get_model.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/photo/photo.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/ml_tag/ml_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/tag_bounding_box/object_bounding_box.dart';
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
  //TextRecognizer.
  final _textRecognizer = TextRecognizer();

  //ImageLabeler.
  final ImageLabeler _imageLabeler = ImageLabeler(
    options: ImageLabelerOptions(
        confidenceThreshold: googleVisionConfidenceThreshold / 100),
  );

  final _objectDetector = ObjectDetector(
      options: ObjectDetectorOptions(
    classifyObjects: true,
    multipleObjects: false,
  ));

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
    _textRecognizer.close();
    _imageLabeler.close();
    _objectDetector.close();
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
    //Get Image Extention.
    String fileExtention = imageFile.path.split('.').last;
    //Create file name.
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

    //Is Google Vision Enabled ?
    if (googleVision) {
      final List<ImageLabel> labels =
          await _imageLabeler.processImage(inputImage);
      imageLabels.addAll(labels);

      List<DetectedObject> objects =
          await _objectDetector.processImage(inputImage);

      detectedObjects.addAll(objects);
    }

    //InceptionV4 products if enabled.
    if (inceptionV4) {
      detectedObjects.addAll(await getObjectsOnImage(
          'assets/ml/inception_v4_quant_1_metadata_1.tflite',
          inceptionV4ConfidenceThreshold / 100,
          inputImage));
    }

    RecognizedText recognisedText =
        await _textRecognizer.processImage(inputImage);

    ///Processing///
    photos = [];

    //1. Create the photo reference.
    Photo photo = Photo()
      ..containerUID = widget.containerUID
      ..photoPath = photoFilePath
      ..thumbnailPath = thumbnailPhotoPath;

    isarDatabase!.writeTxnSync((isar) => isar.photos.putSync(photo));

    addImageLabels(imageLabels, photo);
    addObjectLabels(detectedObjects, photo);
    addTextLabels(recognisedText, photo);

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
        imageRotation: InputImageRotation.rotation90deg,
        size: imageSize);

    if (isDone == false) {
      isDone = true;
      setState(() {});
    }

    return processedResult;
  }

  void addTextLabels(RecognizedText recognisedText, Photo photo) {
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        for (String word in line.text.split(' ').toList()) {
          //TODO: implement spell checker/dictionary.

          //i. Label Text.
          String labelText = word.toLowerCase();

          if (labelText.length > 3) {
            //ii. Check if label text exists.
            TagText? tagText = isarDatabase!.tagTexts
                .filter()
                .textMatches(labelText)
                .findFirstSync();

            //iii. Create new TagText.
            if (tagText == null) {
              tagText = TagText()..text = labelText;
              isarDatabase!
                  .writeTxnSync((isar) => isar.tagTexts.putSync(tagText!));
            }

            //iv. Create MlTag.
            MlTag mlTag = MlTag()
              ..photoID = photo.id
              ..tagType = MlTagType.text
              ..textID = tagText.id
              ..confidence = 0.99
              ..blackListed = false;
            isarDatabase!.writeTxnSync((isar) => isar.mlTags.putSync(mlTag));
          }
        }
      }
    }
  }

  void addObjectLabels(List<DetectedObject> detectedObjects, Photo photo) {
    //2. Create Object Labels.
    for (DetectedObject object in detectedObjects) {
      //i. Get object Labels.
      List<Label> objectLabels = object.labels;

      //ii. Get Object BoundingBox.
      List<double> boundingBox = [
        object.boundingBox.left,
        object.boundingBox.top,
        object.boundingBox.right,
        object.boundingBox.bottom
      ];
      if (objectLabels.isEmpty) {
        //iii. Label Text.
        String labelText = '-';

        //iv. Check if label text exists.
        TagText? tagText = isarDatabase!.tagTexts
            .filter()
            .textMatches(labelText)
            .findFirstSync();

        //v. Create new TagText.
        if (tagText == null) {
          tagText = TagText()..text = labelText;
          isarDatabase!.writeTxnSync((isar) => isar.tagTexts.putSync(tagText!));
        }

        //vii. Create MlTag.
        MlTag mlTag = MlTag()
          ..photoID = photo.id
          ..tagType = MlTagType.objectLabel
          ..textID = tagText.id
          ..confidence = 0.0
          ..blackListed = true;
        isarDatabase!.writeTxnSync((isar) => isar.mlTags.putSync(mlTag));

        //viii. Create BoundingBox.
        ObjectBoundingBox tagBoundingBox = ObjectBoundingBox()
          ..mlTagID = mlTag.id
          ..boundingBox = boundingBox;

        isarDatabase!.writeTxnSync(
            (isar) => isar.objectBoundingBoxs.putSync(tagBoundingBox));
      } else {
        for (Label objectLabel in objectLabels) {
          //iv. Label Text.
          String labelText = objectLabel.text.toLowerCase();

          //v. Check if label text exists.
          TagText? tagText = isarDatabase!.tagTexts
              .filter()
              .textMatches(labelText)
              .findFirstSync();

          //vi. Create new TagText.
          if (tagText == null) {
            tagText = TagText()..text = labelText;
            isarDatabase!
                .writeTxnSync((isar) => isar.tagTexts.putSync(tagText!));
          }

          //vii. Create MlTag.
          MlTag mlTag = MlTag()
            ..photoID = photo.id
            ..tagType = MlTagType.objectLabel
            ..textID = tagText.id
            ..confidence = objectLabel.confidence
            ..blackListed = false;
          isarDatabase!.writeTxnSync((isar) => isar.mlTags.putSync(mlTag));

          //viii. Create BoundingBox.
          ObjectBoundingBox tagBoundingBox = ObjectBoundingBox()
            ..mlTagID = mlTag.id
            ..boundingBox = boundingBox;

          isarDatabase!.writeTxnSync(
              (isar) => isar.objectBoundingBoxs.putSync(tagBoundingBox));
        }
      }
    }
  }

  void addImageLabels(List<ImageLabel> imageLabels, Photo photo) {
//3. Create Image Labels.
    for (ImageLabel label in imageLabels) {
      //i. Label Text.
      String labelText = label.label.toLowerCase();

      //ii. Check if label text exists.
      TagText? tagText = isarDatabase!.tagTexts
          .filter()
          .textMatches(labelText)
          .findFirstSync();

      //iii. Create new TagText.
      if (tagText == null) {
        tagText = TagText()..text = labelText;
        isarDatabase!.writeTxnSync((isar) => isar.tagTexts.putSync(tagText!));
      }

      //iv. Create MlTag.
      MlTag mlTag = MlTag()
        ..photoID = photo.id
        ..tagType = MlTagType.imageLabel
        ..textID = tagText.id
        ..confidence = label.confidence
        ..blackListed = false;
      isarDatabase!.writeTxnSync((isar) => isar.mlTags.putSync(mlTag));
    }
  }

  Future<List<DetectedObject>> getObjectsOnImage(
      String path, double confidenceThreshold, InputImage inputImage) async {
    final modelPath = await getModel(path);

    final objectDetector = ObjectDetector(
      options: LocalObjectDetectorOptions(
          modelPath: modelPath,
          classifyObjects: true,
          multipleObjects: true,
          confidenceThreshold: confidenceThreshold),
    );

    //Get list of objects.
    List<DetectedObject> detectedObjects =
        await objectDetector.processImage(inputImage);

    //Close object detector.
    objectDetector.close();

    return detectedObjects;
  }
}

Future<String> getStorageDirectory() async {
  if (Platform.isAndroid) {
    return (await getExternalStorageDirectory())!.path;
  } else {
    return (await getApplicationDocumentsDirectory()).path;
  }
}
