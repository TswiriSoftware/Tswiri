import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import 'package:tswiri_database/export.dart';
import 'package:tswiri_database/functions/isar/get_functions.dart';
import 'package:tswiri_database/functions/other/get_model.dart';
import 'package:tswiri_database/models/image_data/image_data.dart';
import 'package:tswiri_database/models/settings/app_settings.dart';
import 'package:tswiri_database/widgets/ml_label_paint/ml_label_paint.dart';
import 'package:tswiri_database/widgets/photo/photo_display.dart';
import 'package:tswiri_database/widgets/tag_texts_search/tag_texts_search.dart';
import 'package:tswiri_widgets/colors/colors.dart';

class MlPhotoLabelingView extends StatefulWidget {
  const MlPhotoLabelingView({
    Key? key,
    required this.photo,
  }) : super(key: key);
  final XFile photo;

  @override
  State<MlPhotoLabelingView> createState() => _MlPhotoLabelingViewState();
}

class _MlPhotoLabelingViewState extends State<MlPhotoLabelingView> {
  late File photoFile = File(widget.photo.path);

  //ImageData from photo
  ImageData? _imageData;

  //Should Show ?.
  bool showObjects = true;
  bool showText = false;

  //Text Recognizer.
  late TextRecognizer _textRecognizer;

  //Image Labels.
  late ImageLabeler _imageLabeler;

  //Object Detector.
  late ObjectDetector _objectDetector;

  //For Using Tag Text Predictor.
  final GlobalKey<TagTextSearchState> _key = GlobalKey();

  int? objectID;

  bool isAddingPhotoLabel = false;
  bool isAddingObjectLabel = false;

  @override
  void initState() {
    processImage();
    super.initState();
  }

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
      appBar: _appBar(),
      body: _body(),
      bottomSheet: isAddingPhotoLabel
          ? _tagTextPredictor()
          : isAddingObjectLabel
              ? _tagTextPredictor()
              : const SizedBox.shrink(),
      resizeToAvoidBottomInset: true,
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'ML Labeling',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      centerTitle: true,
      leading: _cancelButton(),
      actions: [
        _continueButton(),
      ],
    );
  }

  Widget _cancelButton() {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: const Icon(Icons.close_sharp),
    );
  }

  Widget _continueButton() {
    return Visibility(
      visible: _imageData != null,
      child: IconButton(
        onPressed: () {
          Navigator.of(context).pop(_imageData!);
        },
        icon: const Icon(Icons.check_sharp),
      ),
    );
  }

  Widget _body() {
    return Builder(builder: (context) {
      if (_imageData != null) {
        return SingleChildScrollView(
          child: Column(
            children: [
              _photoCard(),
              _photoLabelsCard(),
              _mlObjectsCard(),
              _mlTextElementCard(),
            ],
          ),
        );
      } else {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 1.2,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    });
  }

  Widget _tagTextPredictor() {
    return TagTextSearch(
      key: _key,
      //Spagetti monster.
      excludedTags: isAddingPhotoLabel
          ? _imageData!.photoLabels.map((e) => e.tagTextID).toList()
          : isAddingObjectLabel
              ? _imageData!.objectLabels
                  .where((element) => element.objectID == objectID)
                  .map((e) => e.tagTextID)
                  .toList()
              : [],
      dismiss: () => setState(() {
        isAddingObjectLabel = false;
        isAddingPhotoLabel = false;
        objectID = null;
      }),
      onTagAdd: (tagTextID) {
        if (isAddingPhotoLabel) {
          //Create new Photo Label.
          PhotoLabel newPhotoLabel = PhotoLabel()
            ..photoID = 0
            ..tagTextID = tagTextID;

          setState(() {
            _imageData!.photoLabels.add(newPhotoLabel);
          });
        } else if (isAddingObjectLabel) {
          //Create new Object Label.
          ObjectLabel newObjectLabel = ObjectLabel()
            ..objectID = objectID!
            ..tagTextID = tagTextID;

          setState(() {
            _imageData!.objectLabels.add(newObjectLabel);
          });
        }
      },
    );
  }

  Widget _photoCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: _imageData!.size.height /
                  (_imageData!.size.width /
                      (MediaQuery.of(context).size.width - 16)),
              width: MediaQuery.of(context).size.width,
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                fit: StackFit.expand,
                children: [
                  PhotoDisplay(
                    photoPath: _imageData!.photoFile.path,
                  ),
                  MLLabelPaint(
                    imageData: _imageData!,
                    showObjects: showObjects,
                    showText: showText,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FilterChip(
                  label: Text(
                    'Objects',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  onSelected: (value) {
                    setState(() {
                      showObjects = value;
                    });
                  },
                  selected: showObjects,
                ),
                FilterChip(
                  label: Text(
                    'Text',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  onSelected: (value) {
                    setState(() {
                      showText = value;
                    });
                  },
                  selected: showText,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _photoLabelsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ExpansionTile(
              title: Text(
                'Photo Labels',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              children: [
                Wrap(
                  spacing: 4,
                  children: [
                    for (MLPhotoLabel e in _imageData?.mlPhotoLabels ?? [])
                      _mlPhotoLabelChip(e),
                    for (PhotoLabel e in _imageData!.photoLabels)
                      _photoLabelChip(e),
                    Visibility(
                      visible: !isAddingPhotoLabel,
                      child: ActionChip(
                        label: Text(
                          '+',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        // backgroundColor: sunbirdOrange,
                        onPressed: () {
                          setState(() {
                            isAddingPhotoLabel = true;
                          });
                          _key.currentState?.resetExcludedTags(_imageData!
                              .photoLabels
                              .map((e) => e.tagTextID)
                              .toList());
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _mlPhotoLabelChip(MLPhotoLabel imageLabel) {
    return Builder(builder: (context) {
      if (imageLabel.userFeedback == null) {
        return FilterChip(
          label: Text(getMLDetectedLabelText(imageLabel.detectedLabelTextID)),
          onSelected: (value) {
            setState(() {
              imageLabel.userFeedback = true;
            });
          },
          selected: false,
          // backgroundColor: background[200],
          avatar: const Icon(Icons.smart_toy),
        );
      } else if (imageLabel.userFeedback == true) {
        return FilterChip(
          label: Text(getMLDetectedLabelText(imageLabel.detectedLabelTextID)),
          onSelected: (value) {
            setState(() {
              imageLabel.userFeedback = false;
            });
          },
          backgroundColor: Colors.green,
          selectedColor: Colors.green,
          showCheckmark: true,
          selected: true,
        );
      } else {
        return FilterChip(
          label: Text(
            getMLDetectedLabelText(imageLabel.detectedLabelTextID),
            style: const TextStyle(
                decoration: TextDecoration.lineThrough,
                fontWeight: FontWeight.w300),
          ),
          onSelected: (value) {
            setState(() {
              imageLabel.userFeedback = null;
            });
          },
          avatar: const Icon(Icons.close_sharp),
          backgroundColor: background[300],
          selectedColor: background[300],
          showCheckmark: false,
          selected: false,
        );
      }
    });
  }

  Widget _photoLabelChip(PhotoLabel photoLabel) {
    return Chip(
      label: Text(
        isar!.tagTexts.getSync(photoLabel.tagTextID)?.text ?? 'err',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      avatar: const Icon(Icons.verified_user),
      backgroundColor: background[200],
      deleteIcon: const Icon(
        Icons.close_sharp,
        size: 20,
      ),
      onDeleted: () {
        setState(() {
          _imageData!.photoLabels.remove(photoLabel);
        });

        ///Let the TagTextPredictor know this tag has been removed.
        _key.currentState?.updateAssignedTags(photoLabel.tagTextID);
      },
      // backgroundColor: sunbirdOrange,
    );
  }

  Widget _mlObjectsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ExpansionTile(
              title: Text(
                'Objects',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              children: [
                Wrap(spacing: 4, children: [
                  for (var e in _imageData?.mlObjects ?? []) _mlObjectCard(e)
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _mlObjectCard(MLObject mlObject) {
    return Card(
      key: UniqueKey(),
      color: background[300],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'ID: ${mlObject.id}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            const Divider(),
            Wrap(
              spacing: 4,
              children: [
                for (MLObjectLabel e in _imageData?.mlObjectLabels
                        .where((element) => element.objectID == mlObject.id) ??
                    [])
                  _mlObjectLabelChip(e),
                for (ObjectLabel e in _imageData!.objectLabels
                    .where((element) => element.objectID == mlObject.id))
                  _objectLabelChip(e),
                Visibility(
                  key: UniqueKey(),
                  visible: !isAddingObjectLabel,
                  child: ActionChip(
                    label: Text(
                      '+',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    // backgroundColor: sunbirdOrange,
                    onPressed: () {
                      setState(() {
                        isAddingObjectLabel = true;
                        objectID = mlObject.id;
                      });

                      List<int> excludedLabels = _imageData!.objectLabels
                          .where((element) => element.objectID == mlObject.id)
                          .map((e) => e.tagTextID)
                          .toList();

                      setState(() {
                        _key.currentState?.resetExcludedTags(excludedLabels);
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _mlObjectLabelChip(MLObjectLabel mlObjectLabel) {
    return Builder(builder: (context) {
      if (mlObjectLabel.userFeedback == null) {
        return FilterChip(
          label:
              Text(getMLDetectedLabelText(mlObjectLabel.detectedLabelTextID)),
          onSelected: (value) {
            setState(() {
              mlObjectLabel.userFeedback = true;
            });
          },
          selected: false,
          // backgroundColor: background[200],
        );
      } else if (mlObjectLabel.userFeedback == true) {
        return FilterChip(
          label:
              Text(getMLDetectedLabelText(mlObjectLabel.detectedLabelTextID)),
          onSelected: (value) {
            setState(() {
              mlObjectLabel.userFeedback = false;
            });
          },
          backgroundColor: Colors.green,
          selectedColor: Colors.green,
          showCheckmark: true,
          selected: true,
        );
      } else {
        return FilterChip(
          label: Text(
            getMLDetectedLabelText(mlObjectLabel.detectedLabelTextID),
            style: const TextStyle(
                decoration: TextDecoration.lineThrough,
                fontWeight: FontWeight.w300),
          ),
          onSelected: (value) {
            setState(() {
              mlObjectLabel.userFeedback = null;
            });
          },
          backgroundColor: background[300],
          showCheckmark: false,
          selected: false,
        );
      }
    });
  }

  Widget _objectLabelChip(ObjectLabel objectLabel) {
    return Chip(
      label: Text(
        isar!.tagTexts.getSync(objectLabel.tagTextID)?.text ?? 'err',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      avatar: const Icon(Icons.verified_user),
      backgroundColor: background[200],
      deleteIcon: const Icon(
        Icons.close_sharp,
        size: 20,
      ),
      onDeleted: () {
        setState(() {
          _imageData!.objectLabels.remove(objectLabel);
        });

        ///Let the TagTextPredictor know this tag has been removed.
        _key.currentState?.updateAssignedTags(objectLabel.tagTextID);
      },
      // backgroundColor: sunbirdOrange,
    );
  }

  Widget _mlTextElementCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ExpansionTile(
              title: Text(
                'Recognized Text',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: ListView(
                    primary: false,
                    children: [
                      Wrap(
                        spacing: 4,
                        children: _imageData?.mlTextElements
                                .map((e) => _mlTextElementChip(e))
                                .toList() ??
                            [],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _mlTextElementChip(MLTextElement mlTextElement) {
    return Builder(builder: (context) {
      if (mlTextElement.userFeedback == null) {
        return FilterChip(
          label: Text(
              getMLDetectedElementText(mlTextElement.detectedElementTextID)),
          onSelected: (value) {
            setState(() {
              mlTextElement.userFeedback = true;
            });
          },
          selected: false,
          // backgroundColor: background[200],
        );
      } else if (mlTextElement.userFeedback == true) {
        return FilterChip(
          label: Text(
              getMLDetectedElementText(mlTextElement.detectedElementTextID)),
          onSelected: (value) {
            setState(() {
              mlTextElement.userFeedback = false;
            });
          },
          backgroundColor: Colors.green,
          selectedColor: Colors.green,
          showCheckmark: true,
          selected: true,
        );
      } else {
        return FilterChip(
          label: Text(
            getMLDetectedElementText(mlTextElement.detectedElementTextID),
            style: const TextStyle(
                decoration: TextDecoration.lineThrough,
                fontWeight: FontWeight.w300),
          ),
          onSelected: (value) {
            setState(() {
              mlTextElement.userFeedback = null;
            });
          },
          backgroundColor: background[300],
          showCheckmark: false,
          selected: false,
        );
      }
    });
  }

  ///Processes the image and returns a [ImageData] object that contains all image info.
  void processImage() async {
    //Inititate Detectors.
    _imageLabeler = await initiateImageLabeler();
    _objectDetector = await initiateObjectDetector();
    _textRecognizer = await initiateTextRecognizer();

    //Create InputImage.
    InputImage inputImage = InputImage.fromFile(photoFile);

    //Get Image Labels.
    List<MLPhotoLabel> mlPhotoLabels = [];
    if (imageLabeling == true) {
      List<ImageLabel> labels = await _imageLabeler.processImage(inputImage);

      mlPhotoLabels = labels
          .map(
            (e) => MLPhotoLabel()
              ..photoID = null
              ..confidence = e.confidence
              ..detectedLabelTextID = getMLDetectedLabelTextID(e.label)
              ..userFeedback = null,
          )
          .toList();
    }

    List<DetectedObject> detectedObjects = [];
    List<MLObject> mlObjects = [];
    List<MLObjectLabel> mlObjectLabels = [];
    if (objectDetection == true) {
      //Get Objects.
      detectedObjects = await _objectDetector.processImage(inputImage);

      for (var i = 0; i < detectedObjects.length; i++) {
        DetectedObject object = detectedObjects[i];

        List<double> boundingBox = [
          object.boundingBox.left,
          object.boundingBox.top,
          object.boundingBox.right,
          object.boundingBox.bottom,
        ];

        MLObject mlObject = MLObject()
          ..id = i
          ..boundingBox = boundingBox
          ..photoID = 0;

        mlObjects.add(mlObject);

        for (var label in object.labels) {
          if (label.confidence >= objectDetectionConfidence) {
            MLObjectLabel mlObjectLabel = MLObjectLabel()
              ..confidence = label.confidence
              ..detectedLabelTextID = getMLDetectedLabelTextID(label.text)
              ..objectID = mlObject.id
              ..userFeedback = null;

            mlObjectLabels.add(mlObjectLabel);
          }
        }
      }
    }

    List<MLTextBlock> mlTextBlocks = [];
    List<MLTextLine> mlTextLines = [];
    List<MLTextElement> mlTextElements = [];

    if (textDetection == true) {
      RecognizedText recognizedText =
          await _textRecognizer.processImage(inputImage);

      for (var i = 0; i < recognizedText.blocks.length; i++) {
        TextBlock textBlock = recognizedText.blocks[i];

        MLTextBlock mlTextBlock = MLTextBlock()
          ..id = i
          ..cornerPoints = textBlock.cornerPoints
          ..recognizedLanguages = recognizedText.blocks[i].recognizedLanguages;

        mlTextBlocks.add(mlTextBlock);

        for (var x = 0; x < textBlock.lines.length; x++) {
          TextLine textLine = textBlock.lines[x];

          MLTextLine mlTextLine = MLTextLine()
            ..blockID = i
            ..blockIndex = x
            ..cornerPoints = textLine.cornerPoints
            ..id = mlTextLines.length + 1
            ..recognizedLanguages = textLine.recognizedLanguages;

          mlTextLines.add(mlTextLine);

          for (var z = 0; z < textLine.elements.length; z++) {
            TextElement textElement = textLine.elements[z];
            MLTextElement mlTextElement = MLTextElement()
              ..cornerPoints = textElement.cornerPoints
              ..detectedElementTextID =
                  getMLDetectedElementTextID(textElement.text)
              ..lineID = mlTextLine.id
              ..lineIndex = z
              ..photoID = 0
              ..userFeedback = null;

            mlTextElements.add(mlTextElement);
          }
        }
      }
    }

    //Decode photo.
    final decodedImage = await decodeImageFromList(photoFile.readAsBytesSync());

    //Set photo size
    Size size =
        Size(decodedImage.width.toDouble(), decodedImage.height.toDouble());

    setState(() {
      _imageData = ImageData(
        photoFile: photoFile,
        size: size,
        rotation: InputImageRotation.rotation0deg,
        photoLabels: [],
        mlPhotoLabels: mlPhotoLabels,
        mlObjects: mlObjects,
        objectLabels: [],
        mlObjectLabels: mlObjectLabels,
        mlTextBlocks: mlTextBlocks,
        mlTextLines: mlTextLines,
        mlTextElements: mlTextElements,
      );
    });
  }

  Future<ObjectDetector> initiateObjectDetector() async {
    String modelPath = await getModel('assets/ml/object_labeler.tflite');
    return ObjectDetector(
        options: LocalObjectDetectorOptions(
      mode: DetectionMode.single,
      modelPath: modelPath,
      classifyObjects: true,
      multipleObjects: true,
    ));
  }

  Future<ImageLabeler> initiateImageLabeler() async {
    return ImageLabeler(
      options: ImageLabelerOptions(
        confidenceThreshold: imageLabelingConfidence,
      ),
    );
  }

  Future<TextRecognizer> initiateTextRecognizer() async {
    return TextRecognizer();
  }
}
