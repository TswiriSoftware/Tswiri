import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:sunbird_v2/extentions/string_extentions.dart';
import 'package:sunbird_v2/isar/collections/container_type/container_type.dart';
import 'package:sunbird_v2/isar/collections/photo/photo.dart';
import 'package:sunbird_v2/isar/isar_database.dart';
import 'package:sunbird_v2/views/barcode_scanning/single_barcode/single_scanner_view.dart';
import 'package:sunbird_v2/views/photo_labeling/photo_labeling_camera_view.dart';
import 'package:sunbird_v2/widgets/cards/new_photo_card.dart';
import 'package:sunbird_v2/widgets/cards/photo_card.dart';

import '../../globals/globals_export.dart';

class NewAreaView extends StatefulWidget {
  const NewAreaView({Key? key}) : super(key: key);

  @override
  State<NewAreaView> createState() => _NewAreaViewState();
}

class _NewAreaViewState extends State<NewAreaView> {
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nameNode = FocusNode();
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _descriptionNode = FocusNode();

  String? barcodeUID;
  List<Photo> photos = [];

  @override
  void initState() {
    _nameNode.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'New Area',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.close_sharp,
        ),
      ),
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          onPressed: () {
            _showInfoDialog(type: 'area');
          },
          icon: const Icon(
            Icons.info,
          ),
        ),
      ],
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _info(),
        ],
      ),
    );
  }

  Widget _info() {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [_name(), _description(), _barcode(), _photos()],
      ),
    );
  }

  Widget _name() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _nameController,
        focusNode: _nameNode,
        onSubmitted: (value) {
          _descriptionNode.requestFocus();
        },
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white10,
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          labelText: 'Name',
          labelStyle: TextStyle(fontSize: 15, color: Colors.white),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: sunbirdOrange)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: sunbirdOrange)),
        ),
      ),
    );
  }

  Widget _description() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _descriptionController,
        focusNode: _descriptionNode,
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white10,
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          labelText: 'Description',
          labelStyle: TextStyle(fontSize: 15, color: Colors.white),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: sunbirdOrange)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: sunbirdOrange)),
        ),
      ),
    );
  }

  Widget _barcode() {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: background[400],
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Barcode UID: ',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  barcodeUID ?? '-',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                ElevatedButton(
                  onPressed: () async {
                    barcodeUID = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SingleBarcodeScannerView(),
                      ),
                    );
                    setState(() {});
                  },
                  child: Text(
                    'Scan',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _photos() {
    return Container(
      height: 150,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: background[400],
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: ListView.builder(
        itemCount: 10 + 1,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index < 10) {
            return PhotoCard();
          }
          return NewPhotoCard(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PhotoLabelingCameraView(),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _showInfoDialog({required String type}) async {
    ContainerType containerType = isar!.containerTypes
        .filter()
        .containerTypeMatches(type)
        .findFirstSync()!;

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child:
                  Text(containerType.containerType.capitalizeFirstCharacter())),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  '${containerType.containerDescription.split('.').first}.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  '${containerType.containerDescription.split('.')[1]}.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  '${containerType.containerDescription.split('.')[2]}.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
