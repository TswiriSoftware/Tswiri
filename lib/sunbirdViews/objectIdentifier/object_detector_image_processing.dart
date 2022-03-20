import 'dart:io';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:path_provider/path_provider.dart';

import '../../databaseAdapters/barcodePhotoAdapter/barcode_photo_entry.dart';
import '../../globalValues/global_hive_databases.dart';
import '../../objects/image_data.dart';
import '../barcode_control_panel/barcode_control_panel_view.dart';
import 'painter/object_detector_painter.dart';

///Displays the Photo and objects detected
class ObjectDetectorProcessingView extends StatefulWidget {
  const ObjectDetectorProcessingView(
      {Key? key, required this.imagePath, required this.barcodeID})
      : super(key: key);
  final String imagePath;
  final String barcodeID;
  @override
  _ObjectDetectorProcessingView createState() =>
      _ObjectDetectorProcessingView();
}

class _ObjectDetectorProcessingView
    extends State<ObjectDetectorProcessingView> {
  //Object detector config
  ObjectDetector objectDetector = GoogleMlKit.vision.objectDetector(
      ObjectDetectorOptions(classifyObjects: true, trackMutipleObjects: true));

  //Image labeler Config.
  ImageLabeler imageLabeler = GoogleMlKit.vision
      .imageLabeler(ImageLabelerOptions(confidenceThreshold: 0.6));

  //Text Detector
  TextDetector textDetector = GoogleMlKit.vision.textDetector();

  late String imagePath;
  //LocalModel model = LocalModel('object_detector.tflite');

  @override
  void initState() {
    //Image Path.
    imagePath = widget.imagePath;

    //TODO: figure out custom .tflite

    //Object Detector Config.
    // objectDetector = GoogleMlKit.vision.objectDetector(
    //     CustomObjectDetectorOptions(model,
    //         classifyObjects: true, trackMutipleObjects: true));

    super.initState();
  }

  bool isBusy = false;
  CustomPaint? customPaint;

  @override
  void dispose() {
    objectDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                backgroundColor: Colors.orange,
                heroTag: null,
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BarcodeControlPanelView(barcodeID: widget.barcodeID),
                    ),
                  );
                },
                child: const Icon(Icons.check_circle_outline_rounded),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Text('Processing Image'),
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
    String fileName =
        '${widget.barcodeID}_${DateTime.now().millisecondsSinceEpoch}';

    //Get the Storage Path if it does not exist create it.
    String storagePath = await getStorageDirectory();
    if (!await Directory('$storagePath/sunbird').exists()) {
      Directory('$storagePath/sunbird').create();
    }

    //Create the photo file path.
    String photoFilePath = '$storagePath/sunbird/$fileName' + fileExtention;
    //log(photoFilePath);

    await imageFile.copy(photoFilePath);

    //Create InputImage.
    InputImage inputImage = InputImage.fromFile(imageFile);

    List<String> photoTags = [];

    //Image Processing:

    ///Objects
    final objects = await objectDetector.processImage(inputImage);
    for (DetectedObject object in objects) {
      //log('Object label: ' + object.getLabels().toList().toString());
      List<Label> objectLabels = object.getLabels();
      for (Label objectLabel in objectLabels) {
        photoTags.add(objectLabel.getText());
      }
    }

    ///Labels
    final labels = await imageLabeler.processImage(inputImage);
    for (ImageLabel label in labels) {
      //log('Image Label: ' + label.label);
      photoTags.add(label.label);
    }

    ///Text
    final RecognisedText recognisedText =
        await textDetector.processImage(inputImage);
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        if (line.text.length >= 3) {
          photoTags.add(line.text.toLowerCase());
        }

        // for (TextElement element in line.elements) {
        //   log(element.text.toString());
        // }
      }
    }

    //Decode Image for properties
    var decodedImage = await decodeImageFromList(imageFile.readAsBytesSync());

    //Get Image Size
    Size imageSize =
        Size(decodedImage.height.toDouble(), decodedImage.width.toDouble());

    //Create the object that contains all data from the object Detector and Image Labeler.
    ImageData processedResult = ImageData(
        detectedObjects: objects,
        detectedLabels: labels,
        detectedText: recognisedText,
        imageRotation: InputImageRotation.Rotation_90deg,
        size: imageSize);

    Map<String, List<String>> currentPhotoDataMap = {};
    currentPhotoDataMap.putIfAbsent(photoFilePath, () => photoTags);

    Box<BarcodePhotosEntry> barcodePhotoEntries =
        await Hive.openBox(barcodePhotosBoxName);

    BarcodePhotosEntry? barcodePhotoEntry =
        barcodePhotoEntries.get(widget.barcodeID);

    if (barcodePhotoEntry == null) {
      BarcodePhotosEntry newBarcodePhotosEntry = BarcodePhotosEntry(
          uid: widget.barcodeID, photoData: currentPhotoDataMap);
      barcodePhotoEntries.put(widget.barcodeID, newBarcodePhotosEntry);
    } else {
      barcodePhotoEntry.photoData.addAll(currentPhotoDataMap);
    }

    //log(barcodePhotoEntries.values.toString());
    return processedResult;
  }
}

Future<String> getStorageDirectory() async {
  if (Platform.isAndroid) {
    return (await getExternalStorageDirectory())!.path;
  } else {
    return (await getApplicationDocumentsDirectory()).path;
  }
}
