import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/extentions/capitalize_first_character.dart';
import 'package:flutter_google_ml_kit/isar_database/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/container_photo/container_photo.dart';
import 'package:flutter_google_ml_kit/isar_database/container_relationship/container_relationship.dart';
import 'package:flutter_google_ml_kit/isar_database/container_type/container_type.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/marker/marker.dart';
import 'package:flutter_google_ml_kit/isar_database/ml_tag/ml_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/photo_tag/photo_tag.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcode_scanning/single_barcode_scanner/single_barcode_scanner_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_manager/container_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/photo_tagging/object_detector_view.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/custom_outline_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/light_container.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:isar/isar.dart';

import '../../isar_database/container_photo_thumbnail/container_photo_thumbnail.dart';
import 'objects/photo_data.dart';

class NewContainerView extends StatefulWidget {
  const NewContainerView(
      {Key? key, this.parentContainer, this.barcodeUID, this.navigatorHistory})
      : super(key: key);

  //This is passed in if this screen is called from another container.
  final ContainerEntry? parentContainer;
  final List<ContainerEntry>? navigatorHistory;

  //If the barcodeUID is passed in.
  final String? barcodeUID;

  @override
  State<NewContainerView> createState() => _NewContainerViewState();
}

class _NewContainerViewState extends State<NewContainerView> {
  //1. Parent container if Provided. (Optional)
  ContainerEntry? parentContainer;

  //2. Select container Type (Required)
  late List<ContainerType> containerTypes;
  ContainerType? selectedContainerType;
  Color? containerColor;

  //3. Scanned BarcodeUID (Required)
  String? barcodeUID;

  //4. Container Name and Description.
  //-Name (Optional)
  TextEditingController nameController = TextEditingController();
  String? name;

  //-Description (Optional)
  TextEditingController descriptionController = TextEditingController();
  String? description;

  //5. A list of photos added to this container.
  List<PhotoData> newPhotoData = [];

  //6. Is this containers barcode considered a marker to its children ?
  Marker? marker;

  @override
  void initState() {
    if (widget.parentContainer != null) {
      parentContainer = widget.parentContainer;
      List<String> canContain = isarDatabase!.containerTypes
          .filter()
          .containerTypeMatches(widget.parentContainer!.containerType)
          .canContainProperty()
          .findFirstSync()!;

      containerTypes = isarDatabase!.containerTypes
          .filter()
          .repeat(canContain,
              (q, String element) => q.containerTypeMatches(element))
          .findAllSync();
    } else {
      containerTypes = isarDatabase!.containerTypes.where().findAllSync();
    }

    if (widget.barcodeUID != null) {
      barcodeUID = widget.barcodeUID;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: containerColor,
        title: Builder(builder: (context) {
          if (selectedContainerType == null) {
            return Text(
              'New Container',
              style: Theme.of(context).textTheme.titleMedium,
            );
          } else {
            return Text(
              'New ' + selectedContainerType!.containerType.capitalize(),
              style: Theme.of(context).textTheme.titleMedium,
            );
          }
        }),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _createButtonBuilder(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _typeBuilder(),
            const Divider(),
            _barcodeBuilder(),
            const Divider(),
            _infoBuilder(),
            const Divider(),
            _photoBuilder(),
            const Divider(),
            SizedBox(
              height: MediaQuery.of(context).size.height / 5,
            )
          ],
        ),
      ),
    );
  }

  Widget _typeBuilder() {
    return LightContainer(
      margin: 2.5,
      padding: 0,
      backgroundColor: Colors.transparent,
      child: Builder(builder: (context) {
        //Set ContainerType Border Color.
        return CustomOutlineContainer(
          outlineColor: containerColor?.withOpacity(0.8) ??
              Colors.deepOrange.withOpacity(0.8),
          // backgroundColor: Colors.transparent,
          margin: 2.5,
          padding: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Container Type',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              _dividerHeavy(),
              Builder(builder: (context) {
                if (selectedContainerType != null) {
                  return typeWidget(selectedContainerType!);
                } else {
                  return Column(
                    children: [
                      Text('please select one',
                          style: Theme.of(context).textTheme.bodySmall),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            containerTypes.map((e) => typeWidget(e)).toList(),
                      ),
                    ],
                  );
                }
              })
            ],
          ),
        );
      }),
    );
  }

  ///TYPE///

  Widget typeWidget(ContainerType containerType) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedContainerType = containerType;
          containerColor =
              Color(int.parse(containerType.containerColor)).withOpacity(1);
        });
      },
      child: LightContainer(
        margin: 2.5,
        padding: 0,
        backgroundColor: Colors.transparent,
        child: CustomOutlineContainer(
          backgroundColor: Colors.white10,
          margin: 2.5,
          padding: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    containerType.containerType.capitalize(),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  _undoTypeButtonBuilder(),
                ],
              ),
              _dividerLight(),
              Text(
                containerType.containerDescription,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          outlineColor:
              Color(int.parse(containerType.containerColor)).withOpacity(1),
        ),
      ),
    );
  }

  Widget _undoTypeButtonBuilder() {
    return Builder(
      builder: (context) {
        if (selectedContainerType != null) {
          return InkWell(
            onTap: () {
              setState(() {
                selectedContainerType = null;
              });
            },
            child: CustomOutlineContainer(
                margin: 2.5,
                padding: 5,
                child: Row(
                  children: [
                    Text(
                      'undo',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.undo,
                    ),
                  ],
                ),
                outlineColor: containerColor!),
          );
        } else {
          return Container();
        }
      },
    );
  }

  ///BARCODE///

  Widget _barcodeBuilder() {
    return Builder(
      builder: (context) {
        if (selectedContainerType != null) {
          return LightContainer(
            margin: 2.5,
            padding: 0,
            backgroundColor: Colors.transparent,
            child: CustomOutlineContainer(
              margin: 2.5,
              padding: 5,
              outlineColor: containerColor!.withOpacity(0.8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Linked Barcode',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  _dividerHeavy(),
                  _scannedBarcodeBuilder(),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _scannedBarcodeBuilder() {
    return CustomOutlineContainer(
      outlineColor: containerColor!,
      backgroundColor: Colors.white10,
      padding: 5,
      margin: 2.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BarcodeUID',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  barcodeUID ?? 'Please scan a barcode',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              await barcodeScanner();
            },
            child: _barcodeScannerButtonBuilder(),
          ),
        ],
      ),
    );
  }

  Widget _barcodeScannerButtonBuilder() {
    return Builder(builder: (context) {
      if (barcodeUID != null) {
        return CustomOutlineContainer(
            margin: 2.5,
            padding: 5,
            child: Row(
              children: [
                Text(
                  'change',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.change_circle,
                ),
              ],
            ),
            outlineColor: containerColor!);
      } else {
        return CustomOutlineContainer(
            margin: 2.5,
            padding: 5,
            child: Row(
              children: [
                Text(
                  'scan',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.qr_code_scanner,
                ),
              ],
            ),
            outlineColor: containerColor!);
      }
    });
  }

  Future<void> barcodeScanner() async {
    String? scannedBarcodeUID = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SingleBarcodeScannerView(),
      ),
    );

    //log(scannedBarcodeUID.toString());
    if (scannedBarcodeUID != null) {
      ContainerEntry? linkedContainer = isarDatabase!.containerEntrys
          .filter()
          .barcodeUIDMatches(scannedBarcodeUID)
          .findFirstSync();
      if (linkedContainer == null) {
        barcodeUID = scannedBarcodeUID;
        setState(() {});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(snackBar(linkedContainer));
      }
    }
  }

  ///INFO///

  Widget _infoBuilder() {
    return Builder(builder: (context) {
      if (selectedContainerType != null && barcodeUID != null) {
        return LightContainer(
          margin: 2.5,
          padding: 0,
          backgroundColor: Colors.transparent,
          child: CustomOutlineContainer(
            margin: 2.5,
            padding: 5,
            outlineColor: containerColor!.withOpacity(0.8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Name and Description',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                _dividerHeavy(),
                _nameTextField(),
                _descriptionTextField(),
              ],
            ),
          ),
        );
      } else {
        return Row();
      }
    });
  }

  Widget _nameTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: TextField(
        controller: nameController,
        onChanged: (value) {
          if (value.isNotEmpty) {
            setState(() {
              name = value;
            });
          } else {
            setState(() {
              name = null;
            });
          }
        },
        style: const TextStyle(fontSize: 18),
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white10,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          labelText: 'Name',
          labelStyle: const TextStyle(fontSize: 15, color: Colors.white),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: containerColor!)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: containerColor!)),
        ),
      ),
    );
  }

  Widget _descriptionTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: TextField(
        controller: descriptionController,
        onChanged: (value) {
          if (value.isNotEmpty) {
            setState(() {
              description = value;
            });
          } else {
            setState(() {
              description = null;
            });
          }
        },
        style: const TextStyle(fontSize: 18),
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white10,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          labelText: 'Description',
          labelStyle: const TextStyle(fontSize: 15, color: Colors.white),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: containerColor!)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: containerColor!)),
        ),
      ),
    );
  }

  ///PHOTOS///

  Widget _photoBuilder() {
    //TODO: if user exits screen ensure that photos have been deleted.
    return Builder(builder: (context) {
      if (selectedContainerType != null && barcodeUID != null) {
        return LightContainer(
          margin: 2.5,
          padding: 0,
          backgroundColor: Colors.transparent,
          child: CustomOutlineContainer(
            margin: 2.5,
            padding: 5,
            outlineColor: containerColor!.withOpacity(0.8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Photo(s)',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                _dividerHeavy(),
                CustomOutlineContainer(
                  backgroundColor: Colors.white10,
                  outlineColor: Colors.white54,
                  padding: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _photoAddButton(),
                        ],
                      ),
                      const Divider(),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.spaceEvenly,
                        spacing: 5,
                        runSpacing: 10,
                        children: newPhotoData
                            .map((e) => photoDisplayWidget(e))
                            .toList(),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      } else {
        return Row();
      }
    });
  }

  Widget photoDisplayWidget(PhotoData photoData) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.29,
          child: CustomOutlineContainer(
            outlineColor: containerColor!,
            padding: 2,
            child: Image.file(
              File(photoData.photoPath),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            //Delete Photo.
            File(photoData.photoPath).delete();

            //Delete Photo Thumbnail.
            File(photoData.thumbnailPhotoPath).delete();

            newPhotoData.removeWhere(
                (element) => element.photoPath == photoData.photoPath);

            setState(() {});
          },
          icon: const Icon(Icons.delete),
          color: containerColor,
        ),
      ],
    );
  }

  Widget _photoAddButton() {
    return InkWell(
      onTap: () async {
        PhotoData? result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ObjectDetectorView(
              customColor: containerColor,
            ),
          ),
        );
        if (result != null) {
          setState(() {
            newPhotoData.add(result);
          });
          log(newPhotoData.toString());
        }
      },
      child: CustomOutlineContainer(
          margin: 2.5,
          padding: 5,
          width: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'add',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                width: 5,
              ),
              const Icon(Icons.camera),
            ],
          ),
          outlineColor: containerColor!),
    );
  }

  ///CREATE///

  Widget _createButtonBuilder() {
    return Builder(builder: (context) {
      if (selectedContainerType != null && barcodeUID != null) {
        return FloatingActionButton.extended(
            backgroundColor: containerColor,
            onPressed: () {
              createContainer();
            },
            label: Row(
              children: [
                const Icon(
                  Icons.create,
                  color: Colors.white,
                ),
                Text(
                  'Create',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ));
      } else {
        return Row();
      }
    });
  }

  void createContainer() {
    //Create ContainerEntry.
    if (selectedContainerType != null && barcodeUID != null) {
      //Create ContainerUID.
      String containerUID = selectedContainerType!.containerType +
          '_' +
          DateTime.now().millisecondsSinceEpoch.toString();

      //Create ContainerEntry.
      ContainerEntry newContainerEntry = ContainerEntry()
        ..containerType = selectedContainerType!.containerType
        ..containerUID = containerUID
        ..barcodeUID = barcodeUID
        ..name = name
        ..description = description;

      //Write ContainerEntry.
      isarDatabase!.writeTxnSync(
          (isar) => isar.containerEntrys.putSync(newContainerEntry));

      //Create PhotoEntries.
      if (newPhotoData.isNotEmpty) {
        createPhotoEntries(newContainerEntry);
      }

      if (parentContainer != null) {
        //Create ContainerRelationship.
        ContainerRelationship newContainerRelationship = ContainerRelationship()
          ..parentUID = parentContainer!.containerUID
          ..containerUID = newContainerEntry.containerUID;

        //Write ContainerRelationship.
        isarDatabase!.writeTxnSync((isar) =>
            isar.containerRelationships.putSync(newContainerRelationship));
      }

      if (selectedContainerType!.markerToChilren && barcodeUID != null) {
        Marker newMarker = Marker()
          ..barcodeUID = barcodeUID!
          ..parentContainerUID = newContainerEntry.containerUID;
        isarDatabase!.writeTxnSync((isar) => isar.markers.putSync(newMarker));
      }

      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ContainerView(
                    containerEntry: newContainerEntry,
                    navigatorHistory: widget.navigatorHistory,
                  )));
    }
  }

  void createPhotoEntries(ContainerEntry newContainerEntry) {
    List<ContainerPhoto> newPhotos = [];
    List<ContainerPhotoThumbnail> newPhotosThumbnails = [];
    List<PhotoTag> newPhotoTags = [];

    for (PhotoData photo in newPhotoData) {
      //Create Container photo.
      ContainerPhoto containerPhoto = ContainerPhoto()
        ..containerUID = newContainerEntry.containerUID
        ..photoPath = photo.photoPath;

      //Add photo to list.
      newPhotos.add(containerPhoto);

      //Create Container thumbnail.
      ContainerPhotoThumbnail newThumbnail = ContainerPhotoThumbnail()
        ..photoPath = photo.photoPath
        ..thumbnailPhotoPath = photo.thumbnailPhotoPath;

      //Add to thumbnail List.
      newPhotosThumbnails.add(newThumbnail);

      for (DetectedObject detectedObject in photo.photoObjects) {
        List<Label> labels = detectedObject.getLabels();

        for (Label label in labels) {
          int mlTagID = isarDatabase!.mlTags
              .filter()
              .tagMatches(label.getText().toLowerCase())
              .findFirstSync()!
              .id;

          List<double> boundingBox = [
            detectedObject.getBoundinBox().left,
            detectedObject.getBoundinBox().top,
            detectedObject.getBoundinBox().right,
            detectedObject.getBoundinBox().bottom
          ];

          //Create PhotoTag.
          PhotoTag newPhotoTag = PhotoTag()
            ..photoPath = photo.photoPath
            ..tagUID = mlTagID
            ..boundingBox = boundingBox
            ..confidence = label.getConfidence();

          newPhotoTags.add(newPhotoTag);
        }
      }

      for (ImageLabel imageLabel in photo.photoLabels) {
        int mlTagID = isarDatabase!.mlTags
            .filter()
            .tagMatches(imageLabel.label.toLowerCase())
            .findFirstSync()!
            .id;

        //Create PhotoTag.
        PhotoTag newPhotoTag = PhotoTag()
          ..photoPath = photo.photoPath
          ..tagUID = mlTagID
          ..boundingBox = null
          ..confidence = imageLabel.confidence;

        newPhotoTags.add(newPhotoTag);
      }
    }

    //Write newPhotos, newPhotosThumbnails, newPhotoTags.
    isarDatabase!.writeTxnSync((isar) {
      isar.containerPhotos.putAllSync(newPhotos);
      isar.containerPhotoThumbnails.putAllSync(newPhotosThumbnails);
      isar.photoTags.putAllSync(newPhotoTags);
    });
  }

  ///MISC///

  Widget _dividerLight() {
    return const Divider(
      height: 10,
      thickness: .5,
      color: Colors.white54,
    );
  }

  Widget _dividerHeavy() {
    return const Divider(
      height: 10,
      thickness: 1,
      color: Colors.white,
    );
  }

  SnackBar snackBar(ContainerEntry containerEntry) {
    return SnackBar(
      content: Builder(builder: (context) {
        if (containerEntry.name != null) {
          return Text('Barcode in use => ' + containerEntry.name!);
        } else {
          return Text('Barcode in use => ' + containerEntry.containerUID);
        }
      }),
    );
  }
}
