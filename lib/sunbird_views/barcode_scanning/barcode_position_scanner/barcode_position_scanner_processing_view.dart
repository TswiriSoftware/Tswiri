import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/allBarcodes/barcode_data_entry.dart';

import 'package:flutter_google_ml_kit/functions/dataProccessing/barcode_scanner_data_processing_functions.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';

import 'package:flutter_google_ml_kit/globalValues/shared_prefrences.dart';
import 'package:flutter_google_ml_kit/isar_database/real_interbarcode_vector_entry/real_interbarcode_vector_entry.dart';
import 'package:flutter_google_ml_kit/objects/raw_on_image_barcode_data.dart';
import 'package:flutter_google_ml_kit/objects/raw_on_image_inter_barcode_data.dart';
import 'package:flutter_google_ml_kit/objects/real_inter_barcode_offset.dart';

import 'package:flutter_google_ml_kit/sunbird_views/barcode_scanning/barcode_position_scanner/barcode_position_scanner_data_visualization_view.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/dark_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/light_container.dart';
import 'package:isar/isar.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../databaseAdapters/calibrationAdapter/distance_from_camera_lookup_entry.dart';

class BarcodePositionScannerProcessingView extends StatefulWidget {
  const BarcodePositionScannerProcessingView({
    Key? key,
    required this.allRawOnImageBarcodeData,
    required this.database,
    required this.parentContainerUID,
    required this.relevantBarcodes,
  }) : super(key: key);

  final List<RawOnImageBarcodeData> allRawOnImageBarcodeData;
  final Isar database;
  final String parentContainerUID;
  final List<String> relevantBarcodes;

  @override
  _BarcodePositionScannerProcessingViewState createState() =>
      _BarcodePositionScannerProcessingViewState();
}

class _BarcodePositionScannerProcessingViewState
    extends State<BarcodePositionScannerProcessingView> {
  int shelfUID = 1;
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _continueToVisualizer(),
          ],
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
            child: Text(
          'Processing Data',
          style: Theme.of(context).textTheme.titleLarge,
        )),
      ),
      body: Center(
        child: FutureBuilder<List<RealInterBarcodeOffset>>(
          future: processData(
              allRawOnImageBarcodeData: widget.allRawOnImageBarcodeData),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<RealInterBarcodeOffset> data = snapshot.data!;

              return _listView(data);
            } else if (snapshot.hasError) {
              return Text(
                "${snapshot.error}",
                style: const TextStyle(fontSize: 20, color: deeperOrange),
              );
            }
            // By default, show a loading spinner
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Widget _listView(List<RealInterBarcodeOffset> data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          RealInterBarcodeOffset realInterBarcodeOffset = data[index];
          return LightContainer(
            margin: 2.5,
            padding: 0,
            child: DarkContainer(
              margin: 2.5,
              padding: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _uid(realInterBarcodeOffset),
                  _vector(realInterBarcodeOffset),
                ],
              ),
            ),
          );
        });
  }

  Widget _uid(RealInterBarcodeOffset realInterBarcodeOffset) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'UID',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Row(
          children: [
            Text(
              realInterBarcodeOffset.uidStart,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              ' => ',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              realInterBarcodeOffset.uidEnd,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const Divider(color: Colors.white24),
      ],
    );
  }

  Widget _vector(RealInterBarcodeOffset realInterBarcodeOffset) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Vector',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          'X: ' + realInterBarcodeOffset.offset.dx.toString(),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          'Y: ' + realInterBarcodeOffset.offset.dy.toString(),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          'Z: ' + realInterBarcodeOffset.zOffset.toString(),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const Divider(color: Colors.white24),
      ],
    );
  }

  Widget _continueToVisualizer() {
    return FloatingActionButton(
      heroTag: null,
      onPressed: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BarcodePositionScannerDataVisualizationView(
              database: widget.database,
              parentContainerUID: widget.parentContainerUID,
            ),
          ),
        );
      },
      child: const Icon(Icons.check_circle_outline_rounded),
    );
  }

  //1. Get all initial data that will be used.
//
//  1.1 getMatchedCalibrationData (This is the lookupTable that allows for distance from camera calculations)
//  1.2 getGeneratedBarcodeData (This list contains all the real life barcode sizes)
//
//2. Build a list of all onImageInterBarcodeData based on allRawOnImageBarcodeData.
//
//3. Create list containing AllRealInterBarcodeOffsets and uniqueRealInterBarcodeOffsets.
//
//  3.1 buildAllRealInterBarcodeOffsets.
//    i. Takes the phones rotation into consideration
//    ii. It calculates the real distance between barcodes.
//    iii. It calculates the distance between the barcodes and the camera.
//
//  3.2 uniqueRealInterBarcodeOffsets
//    i. Removes duplicate realInterBarcodeOffsets.
//
//4. processRealInterBarcodeData
//    i. Removes data outleirs
//    ii. Calculates averages with the remaining data.
//

  Future<List<RealInterBarcodeOffset>> processData({
    required List<RawOnImageBarcodeData> allRawOnImageBarcodeData,
  }) async {
    //1.1 List of all matchedCalibration Data
    List<DistanceFromCameraLookupEntry> distanceFromCameraLookup =
        await getMatchedCalibrationData();

    //1.2 This list contains all barcodes and their real life sizes.
    List<BarcodeDataEntry> allBarcodes = await getAllExistingBarcodes();

    //2. This list contains all onImageInterBarcodeData.
    List<RawOnImageInterBarcodeData> allOnImageInterBarcodeData =
        buildAllOnImageInterBarcodeData(allRawOnImageBarcodeData);

    List<RawOnImageInterBarcodeData> allRelevantOnImageInterBarcodeData = [];

    for (RawOnImageInterBarcodeData item in allOnImageInterBarcodeData) {
      if (widget.relevantBarcodes.contains(item.startBarcode.displayValue) &&
          widget.relevantBarcodes.contains(item.endBarcode.displayValue)) {
        allRelevantOnImageInterBarcodeData.add(item);
      }
    }

    //3.1 Calculates all real interBarcodeOffsets.
    //Get the camera's focal length
    final prefs = await SharedPreferences.getInstance();
    double focalLength = prefs.getDouble(focalLengthPreference) ?? 0;

    //Check Function for details.
    List<RealInterBarcodeOffset> allRealInterBarcodeOffsets =
        buildAllRealInterBarcodeOffsets(
      allOnImageInterBarcodeData: allRelevantOnImageInterBarcodeData,
      calibrationLookupTable: distanceFromCameraLookup,
      allBarcodes: allBarcodes,
      focalLength: focalLength,
    );

    //3.2 This list contains only unique realInterBarcodeOffsets
    List<RealInterBarcodeOffset> uniqueRealInterBarcodeOffsets =
        allRealInterBarcodeOffsets.toSet().toList();

    //4. To build the list of final RealInterBarcodeOffsets we:
    //  i. Remove all the outliers from allOnImageInterBarcodeData
    //  ii. Then use the uniqueRealInterBarcodeOffsets as a reference to
    //      calculate the average from allRealInterBarcodeOffsets.

    List<RealInterBarcodeOffset> finalRealInterBarcodeOffsets =
        processRealInterBarcodeData(
            uniqueRealInterBarcodeOffsets: uniqueRealInterBarcodeOffsets,
            listOfRealInterBarcodeOffsets: allRealInterBarcodeOffsets);

    List<RealInterBarcodeVectorEntry> interbarcodeOffsetEntries = [];

    for (RealInterBarcodeOffset interBarcodeOffset
        in finalRealInterBarcodeOffsets) {
      RealInterBarcodeVectorEntry vectorEntry = RealInterBarcodeVectorEntry()
        ..startBarcodeUID = interBarcodeOffset.uidStart
        ..endBarcodeUID = interBarcodeOffset.uidEnd
        ..x = interBarcodeOffset.offset.dx
        ..y = interBarcodeOffset.offset.dy
        ..z = interBarcodeOffset.zOffset;
      interbarcodeOffsetEntries.add(vectorEntry);
    }

    widget.database.writeTxnSync((isar) => isar.realInterBarcodeVectorEntrys
        .putAllSync(interbarcodeOffsetEntries));

    log(interbarcodeOffsetEntries.toString());

    return finalRealInterBarcodeOffsets;
  }
}