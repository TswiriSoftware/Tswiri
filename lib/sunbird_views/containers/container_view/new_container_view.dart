// ignore_for_file: use_build_context_synchronously, sort_child_properties_last

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/extentions/capitalize_first_character.dart';
import 'package:flutter_google_ml_kit/global_values/global_colours.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_entry/container_entry.dart';

import 'package:flutter_google_ml_kit/isar_database/containers/container_relationship/container_relationship.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_type/container_type.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/barcodes/marker/marker.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/photo/photo.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcodes/barcode_scanning/single_barcode_scanner/single_scanner_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/containers/container_view/container_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/containers/container_view/photo_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/photo_tagging/object_detector_view.dart';
import 'package:isar/isar.dart';

class NewContainerView extends StatefulWidget {
  const NewContainerView({Key? key, this.parentContainer, this.barcodeUID})
      : super(key: key);

  //This is passed in if this screen is called from another container.
  final ContainerEntry? parentContainer;

  //If the barcodeUID is passed in.
  final String? barcodeUID;

  @override
  State<NewContainerView> createState() => _NewContainerViewState();
}

class _NewContainerViewState extends State<NewContainerView> {
  //Setup
  late ContainerEntry? parentContainer = widget.parentContainer;
  String? containerUID;

  //1. Container Type (required)
  late List<ContainerType> containerTypes;
  ContainerType? selectedContainerType;
  Color? _containerColor;

  //2. Scanned BarcodeUID (Required)
  late String? barcodeUID = widget.barcodeUID;

  //4. Container Name and Description.
  //-Name (Optional)
  TextEditingController nameController = TextEditingController();
  String? name;

  //-Description (Optional)
  TextEditingController descriptionController = TextEditingController();
  String? description;

  //5. A list of photos added to this container.
  List<Photo> photos = [];

  //6. Is this containers barcode considered a marker to its children ?
  Marker? marker;

  //7. Created ?
  bool hasCreated = false;

  @override
  void initState() {
    if (parentContainer != null) {
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
  void dispose() {
    if (!hasCreated) {
      for (Photo photo in photos) {
        File(photo.photoPath).deleteSync();
        File(photo.thumbnailPath).deleteSync();
        isarDatabase!.writeTxnSync((isar) => isar.photos.deleteSync(photo.id));
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      floatingActionButton: _createButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: _containerColor,
      title: Builder(builder: (context) {
        if (selectedContainerType == null) {
          return Text(
            'New Container',
            style: Theme.of(context).textTheme.titleMedium,
          );
        } else {
          return Text(
            'New ${selectedContainerType!.containerType.capitalize()}',
            style: Theme.of(context).textTheme.titleMedium,
          );
        }
      }),
      centerTitle: true,
      elevation: 0,
    );
  }

  Widget _body() {
    return ListView(
      children: [
        //Container Type.
        _type(),
        //Barcode
        _barcode(),
        //Info
        _info(),
        //Photos
        _photos(),
      ],
    );
  }

  ///CONTAINER TYPE///

  Widget _type() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      color: Colors.white12,
      elevation: 5,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: _containerColor ?? sunbirdOrange, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _typeHeading(),
            _dividerHeading(),
            _types(),
          ],
        ),
      ),
    );
  }

  Widget _typeHeading() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Container Type',
            style: Theme.of(context).textTheme.headlineSmall),
      ],
    );
  }

  Widget _types() {
    return Builder(builder: (context) {
      if (selectedContainerType == null) {
        return Column(
          children: containerTypes.map((e) => containerType(e)).toList(),
        );
      } else {
        return containerType(selectedContainerType!);
      }
    });
  }

  Widget containerType(ContainerType containerType) {
    return Builder(
      builder: (context) {
        Color typeColor =
            Color(int.parse(containerType.containerColor)).withOpacity(1);
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          color: Colors.white12,
          elevation: 5,
          shadowColor: Colors.black26,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: typeColor, width: 1.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                typeInfo(containerType),
                _divider(),
                _typeActionBuilder(containerType, typeColor),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget typeInfo(ContainerType containerType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              containerType.containerType.capitalize(),
              style: Theme.of(context).textTheme.labelMedium,
            ),
            //_undoTypeButtonBuilder(),
          ],
        ),
        _divider(),
        Text(
          containerType.containerDescription,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _typeActionBuilder(ContainerType containerType, Color typeColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Visibility(
          visible: selectedContainerType == null,
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(typeColor)),
            onPressed: () {
              selectedContainerType = containerType;
              _containerColor = typeColor;

              containerUID =
                  '${selectedContainerType!.containerType}_${DateTime.now().millisecondsSinceEpoch}';

              setState(() {});
            },
            child: Text(
              'select',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      ],
    );
  }

  ///BARCODE///

  Widget _barcode() {
    return Visibility(
      visible: selectedContainerType != null,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        color: Colors.white12,
        elevation: 5,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: _containerColor ?? sunbirdOrange, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _barcodeHeading(),
              _dividerHeading(),
              _barcodeBuilder(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _barcodeHeading() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Barcode', style: Theme.of(context).textTheme.headlineSmall),
      ],
    );
  }

  Widget _barcodeBuilder() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   'BarcodeUID',
              //   style: Theme.of(context).textTheme.bodySmall,
              // ),
              Text(
                barcodeUID ?? 'Please scan a barcode',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () async {
            await barcodeScannerProcess();
          },
          child: _scanBarcode(),
        ),
      ],
    );
  }

  Widget _scanBarcode() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(_containerColor)),
          onPressed: () async {
            await barcodeScannerProcess();
          },
          child: Text(
            'Scan',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  Future<void> barcodeScannerProcess() async {
    String? scannedBarcodeUID = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SingleScannerView(
          color: _containerColor,
        ),
      ),
    );

    if (scannedBarcodeUID != null) {
      ContainerEntry? linkedContainer = isarDatabase!.containerEntrys
          .filter()
          .barcodeUIDMatches(scannedBarcodeUID)
          .findFirstSync();
      if (linkedContainer == null) {
        barcodeUID = scannedBarcodeUID;
        nameController.text =
            '${selectedContainerType!.containerType.capitalize()} ${barcodeUID!.split('_').first}';
        name = nameController.text;
        setState(() {});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(snackBar(linkedContainer));
      }
    }
  }

  ///INFO HEADING///

  Widget _info() {
    return Visibility(
      visible: selectedContainerType != null && barcodeUID != null,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        color: Colors.white12,
        elevation: 5,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: _containerColor ?? sunbirdOrange, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _infoHeading(),
              _dividerHeading(),
              _name(),
              _description(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoHeading() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Info', style: Theme.of(context).textTheme.headlineSmall),
      ],
    );
  }

  Widget _name() {
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
              borderSide: BorderSide(color: _containerColor ?? sunbirdOrange)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: _containerColor ?? sunbirdOrange)),
        ),
      ),
    );
  }

  Widget _description() {
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
              borderSide: BorderSide(color: _containerColor ?? sunbirdOrange)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: _containerColor ?? sunbirdOrange)),
        ),
      ),
    );
  }

  ///PHOTOS///

  Widget _photos() {
    return Visibility(
      visible: selectedContainerType != null && barcodeUID != null,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        color: Colors.white12,
        elevation: 5,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: _containerColor ?? sunbirdOrange, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _photosHeading(),
              _dividerHeading(),
              _photosBuilder(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _photosHeading() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Photos', style: Theme.of(context).textTheme.headlineSmall),
      ],
    );
  }

  Widget _photosBuilder() {
    return Builder(
      builder: (context) {
        photos = isarDatabase!.photos
            .filter()
            .containerUIDMatches(containerUID!)
            .findAllSync();

        List<Widget> photoWidgets = [
          _photoAddCard(),
        ];

        photoWidgets.addAll(photos.map((e) => photoCard(e)).toList());
        return Wrap(
          spacing: 1,
          runSpacing: 1,
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: photoWidgets,
        );
      },
    );
  }

  Widget photoCard(Photo containerPhoto) {
    return Card(
      child: InkWell(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PhotoView(photo: containerPhoto),
            ),
          );
          setState(() {});
        },
        child: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.27,
              height: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                border: Border.all(
                    color: _containerColor ?? sunbirdOrange, width: 1),
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              padding: const EdgeInsets.all(2.5),
              child: Image.file(
                File(containerPhoto.photoPath),
                fit: BoxFit.cover,
              ),
            ),
            photoDeleteButton(containerPhoto),
          ],
        ),
      ),
    );
  }

  Widget photoDeleteButton(Photo containerPhoto) {
    return Container(
      width: 35,
      height: 35,
      margin: const EdgeInsets.all(2.5),
      padding: const EdgeInsets.all(0),
      child: Center(
        child: IconButton(
          padding: const EdgeInsets.all(1),
          iconSize: 15,
          onPressed: () {
            deletePhoto(containerPhoto);
            setState(() {});
          },
          icon: const Icon(Icons.delete),
          color: Colors.white,
        ),
      ),
      decoration: BoxDecoration(
          border: Border.all(color: _containerColor ?? sunbirdOrange, width: 1),
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
          color: _containerColor),
    );
  }

  Widget _photoAddCard() {
    return InkWell(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ObjectDetectorView(
              customColor: _containerColor,
              containerUID: containerUID!,
            ),
          ),
        );

        setState(() {});
      },
      child: Card(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.27,
          height: MediaQuery.of(context).size.width * 0.4,
          padding: const EdgeInsets.all(2.5),
          decoration: BoxDecoration(
            border:
                Border.all(color: _containerColor ?? sunbirdOrange, width: 1),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Center(
            child: Text(
              '+',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
      ),
    );
  }

  void deletePhoto(Photo photo) {
    //Delete Photo.
    File(photo.photoPath).delete();

    //Delete Photo Thumbnail.
    File(photo.thumbnailPath).delete();

    //Delete References from database.
    isarDatabase!.writeTxnSync((isar) {
      isar.photos.filter().photoPathMatches(photo.photoPath).deleteFirstSync();

      isar.photos.filter().photoPathMatches(photo.photoPath).deleteAllSync();
    });
  }

  ///CREATE///
  Widget _createButton() {
    return Visibility(
      visible: selectedContainerType != null && barcodeUID != null,
      child: FloatingActionButton.extended(
        backgroundColor: _containerColor,
        onPressed: () {
          hasCreated = true;
          setState(() {});
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
        ),
      ),
    );
  }

  void createContainer() {
    //Create ContainerEntry.
    if (selectedContainerType != null && barcodeUID != null) {
      //Create ContainerEntry.

      ContainerEntry newContainerEntry = ContainerEntry()
        ..containerType = selectedContainerType!.containerType
        ..containerUID = containerUID!
        ..barcodeUID = barcodeUID
        ..name = name
        ..description = description;

      //Write ContainerEntry.
      isarDatabase!.writeTxnSync((isar) => isar.containerEntrys
          .putSync(newContainerEntry, replaceOnConflict: true));

      if (parentContainer != null) {
        //Create ContainerRelationship.
        ContainerRelationship newContainerRelationship = ContainerRelationship()
          ..parentUID = parentContainer!.containerUID
          ..containerUID = newContainerEntry.containerUID;

        //Write ContainerRelationship.
        isarDatabase!.writeTxnSync((isar) =>
            isar.containerRelationships.putSync(newContainerRelationship));
      }

      if (!selectedContainerType!.enclosing && barcodeUID != null) {
        Marker newMarker = Marker()
          ..barcodeUID = barcodeUID!
          ..parentContainerUID = newContainerEntry.containerUID;

        //log(newMarker.toString());
        isarDatabase!.writeTxnSync((isar) => isar.markers.putSync(newMarker));
      }

      if (parentContainer != null) {
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContainerView(
              containerEntry: newContainerEntry,
            ),
          ),
        );
      }
    }
  }

  ///MISC///

  Divider _divider() {
    return const Divider(
      height: 8,
      indent: 2,
      color: Colors.white30,
    );
  }

  Divider _dividerHeading() {
    return const Divider(
      height: 8,
      thickness: 1,
      color: Colors.white,
    );
  }

  SnackBar snackBar(ContainerEntry containerEntry) {
    return SnackBar(
      content: Builder(builder: (context) {
        if (containerEntry.name != null) {
          return Text('Barcode in use => ${containerEntry.name!}');
        } else {
          return Text('Barcode in use => ${containerEntry.containerUID}');
        }
      }),
    );
  }
}
