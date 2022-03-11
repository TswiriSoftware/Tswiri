import 'package:flutter/material.dart';

import 'package:flutter_google_ml_kit/objects/all_barcode_data.dart';
import 'package:flutter_google_ml_kit/objects/change_notifiers.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcodeControlPanel/widgets/tags_widget.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcodeNavigation/barcode_camera_navigator_view.dart';

import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../databaseAdapters/allBarcodes/barcode_data_entry.dart';
import '../../databaseAdapters/barcodePhotoAdapter/barcode_photo_entry.dart';
import '../../functions/barcodeTools/get_data_functions.dart';
import '../../globalValues/global_hive_databases.dart';
import 'widgets/barcode_data_widget.dart';
import 'widgets/barcode_photo_view.dart';

class BarcodeControlPanelView extends StatefulWidget {
  const BarcodeControlPanelView({Key? key, required this.barcodeID})
      : super(key: key);

  final int barcodeID;
  @override
  State<BarcodeControlPanelView> createState() =>
      _BarcodeControlPanelViewState();
}

class _BarcodeControlPanelViewState extends State<BarcodeControlPanelView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text(
          'Barcode',
          style: TextStyle(fontSize: 25),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.navigation,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BarcodeCameraNavigatorView(
                          barcodeID: widget.barcodeID.toString(),
                          pop: true,
                        )),
              );
            },
          )
        ],
        centerTitle: true,
        elevation: 3,
      ),
      body: FutureBuilder<AllBarcodeData>(
        future: getCurrentBarcodeData(widget.barcodeID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            AllBarcodeData barcodeAndTagData = snapshot.data!;

            return SingleChildScrollView(
              child: Column(
                children: [
                  ChangeNotifierProvider<BarcodeDataChangeNotifier>(
                      create: (_) => BarcodeDataChangeNotifier(
                          barcodeSize: barcodeAndTagData.barcodeSize,
                          isFixed: barcodeAndTagData.isFixed,
                          description: barcodeAndTagData.description ??
                              'Add a description'),
                      child: BarcodeDataContainer(
                        barcodeAndTagData: barcodeAndTagData,
                      )),
                  ChangeNotifierProvider<PhotosAndTags>(
                    create: (_) => PhotosAndTags(
                        assignedTags: barcodeAndTagData.tags ?? [],
                        unassignedTags: barcodeAndTagData.unassignedTags ?? [],
                        barcodePhotoData:
                            barcodeAndTagData.barcodePhotoData ?? {}),
                    child: Column(
                      children: [
                        TagsContainerWidget(
                            barcodeID: barcodeAndTagData.barcodeID),
                        BarcodePhotoView(barcodeID: barcodeAndTagData.barcodeID)
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Future<AllBarcodeData> getCurrentBarcodeData(int barcodeID) async {
    //Gets a list of all barcodeTagEntries
    List<String> barcodeTags = await getCurrentBarcodeTags(barcodeID);
    List<String> barcodeUnassignedTags = await getUnassignedTags();

    //Get all generated barcodes.
    Box<BarcodeDataEntry> allBarcodes = await Hive.openBox(allBarcodesBoxName);

    BarcodeDataEntry? barcodeData = allBarcodes.get(barcodeID);
    if (allBarcodes.get(barcodeID) == null) {
      barcodeData = BarcodeDataEntry(
          uid: barcodeID.toString(),
          barcodeSize: 100,
          isMarker: false,
          description: '');

      allBarcodes.put(barcodeID, barcodeData);
    } else {
      barcodeData = allBarcodes.get(barcodeID)!;
    }

    //Remove the assigned tags from unassigned tags.
    barcodeUnassignedTags
        .removeWhere((element) => barcodeTags.contains(element));

    //Photos entry box.
    Box<BarcodePhotosEntry> barcodePhotoEntries =
        await Hive.openBox(barcodePhotosBoxName);

    BarcodePhotosEntry? currentBarcodePhotosEntry =
        barcodePhotoEntries.get(barcodeID);

    Map<String, List<String>> barcodePhotos = {};
    if (currentBarcodePhotosEntry != null) {
      barcodePhotos = currentBarcodePhotosEntry.photoData;
    }

    AllBarcodeData barcodeAndTagData = AllBarcodeData(
        barcodeID: barcodeID,
        barcodeSize: barcodeData.barcodeSize,
        isFixed: barcodeData.isMarker,
        tags: barcodeTags,
        unassignedTags: barcodeUnassignedTags,
        barcodePhotoData: barcodePhotos,
        description: barcodeData.description);

    return barcodeAndTagData;
  }
}
