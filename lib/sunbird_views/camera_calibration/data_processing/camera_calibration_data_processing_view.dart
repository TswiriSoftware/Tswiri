import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/global_values/shared_prefrences.dart';

import 'package:flutter_google_ml_kit/isar_database/barcode_property/barcode_property.dart';
import 'package:flutter_google_ml_kit/isar_database/barcode_size_distance_entry/barcode_size_distance_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/objects/calibration/user_accelerometer_z_axis_data_objects.dart';
import 'package:flutter_google_ml_kit/objects/calibration/barcode_size_objects.dart';
import 'package:flutter_google_ml_kit/sunbird_views/app_settings/app_settings.dart';

import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'camera_calibration_display_widgets.dart';

class CameraCalibrationDataProcessingView extends StatefulWidget {
  const CameraCalibrationDataProcessingView({
    Key? key,
    required this.rawBarcodeData,
    required this.rawUserAccelerometerData,
    required this.startTimeStamp,
    required this.barcodeUID,
  }) : super(key: key);

  final List<BarcodeData> rawBarcodeData;
  final List<RawUserAccelerometerZAxisData> rawUserAccelerometerData;
  final int startTimeStamp;
  final String barcodeUID;

  @override
  _CameraCalibrationDataProcessingViewState createState() =>
      _CameraCalibrationDataProcessingViewState();
}

class _CameraCalibrationDataProcessingViewState
    extends State<CameraCalibrationDataProcessingView> {
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
            FloatingActionButton(
              heroTag: null,
              onPressed: () {
                Navigator.pop(context);
                // Navigator.of(context).pushReplacement(MaterialPageRoute(
                //     builder: (context) =>
                //         const CalibrationDataVisualizerView()));
              },
              child: const Icon(Icons.check_circle_outline_rounded),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Processing Calibration Data'),
      ),
      body: Center(
        child: FutureBuilder<List<BarcodeSizeDistanceEntry>>(
          future: processData(
            widget.rawBarcodeData,
            widget.rawUserAccelerometerData,
            widget.barcodeUID,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            } else {
              List myList = snapshot.data!;
              return ListView.builder(
                  itemCount: myList.length,
                  itemBuilder: (context, index) {
                    BarcodeSizeDistanceEntry data = myList[index];

                    if (index == 0) {
                      return Column(
                        children: <Widget>[
                          const DisplayDataHeader(
                            dataObject: [
                              'Barcode Size',
                              'Distance from Camera'
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CameraCalibrationDisplayWidget(
                            dataObject: data,
                          ),
                        ],
                      );
                    } else {
                      return CameraCalibrationDisplayWidget(
                        dataObject: data,
                      );
                    }
                  });
            }
          },
        ),
      ),
    );
  }

  // Data that we are working with:

  //    i. rawBarcodeData  (This is all the collected barcode data so we can determine the barcodes diagonal length at a given point in time.)
  //   ii. rawUserAccelerometerData (This is all the data collected by the accelerometer, we are specifically looking at the Z axis's acceleration values.)
  //  iii. startTimeStamp (This is the timestamp created when the used indicates that the phone is in the startting position.)
  //
  //  1. Get all barcodes.
  //    i.find current barcode actual size
  //
  //  2. Build a list that contains the barcode diagonal side lengths at different points in time.
  //
  //  3. Grab the relevant time range from the accelerometer data using the startTimeStamp and onImageBarcodeSizes.last.timestamp.
  //
  //  4. Set up the starting position in the list processedAccelerometerData.
  //
  //  5. Process the rawUserAccelerometerData
  //      This calculates the distance the phone has moved in the Z direction for each recorded accelerometer event.
  //
  //  6. Matching the distance moved to the barcode sizes using timestamps
  //

  Future<List<BarcodeSizeDistanceEntry>> processData(
    List<BarcodeData> rawBarcodesData,
    List<RawUserAccelerometerZAxisData> rawAccelerometData,
    String barcodeUID,
  ) async {
    List<BarcodeSizeDistanceEntry> barcodeSizeDistanceEntries = [];
    if (rawAccelerometData.isNotEmpty && rawBarcodesData.isNotEmpty) {
      //Get the barcode size if it exists else use defaultBarcodeDiagonalLength
      double currentBarcodeSize = isarDatabase!.barcodePropertys
              .filter()
              .barcodeUIDMatches(barcodeUID)
              .findFirstSync()
              ?.size ??
          defaultBarcodeDiagonalLength!;

      List<double> focalLengths = [];

      //2. A list of all barcode diagonal side lengths at different points in time.
      List<OnImageBarcodeSize> onImageBarcodeSizes =
          getOnImageBarcodeSizes(rawBarcodesData);

      //3. Get range of relevant rawAccelerometer data
      List<RawUserAccelerometerZAxisData> relevantRawAccelerometData =
          getRelevantRawAccelerometerData(
              rawAccelerometData, widget.startTimeStamp);

      //List that contains processed accelerometer data
      List<ProcessedUserAccelerometerZAxisData> processedAccelerometerData = [];

      //4. Set the starting distance as 0
      processedAccelerometerData.add(ProcessedUserAccelerometerZAxisData(
          timestamp: relevantRawAccelerometData.first.timestamp,
          barcodeDistanceFromCamera: 0));

      //Used to keep track of total distance from barcode.
      double totalDistanceMoved = 0;

      //5. Processing rawAccelerometer Data.
      //   i. Take backward direction as positive
      for (int i = 1; i < relevantRawAccelerometData.length; i++) {
        int deltaT = relevantRawAccelerometData[i].timestamp -
            relevantRawAccelerometData[i - 1].timestamp;

        if (checkMovementDirection(
            totalDistanceMoved, relevantRawAccelerometData, i, deltaT)) {
          totalDistanceMoved = totalDistanceMoved +
              (-relevantRawAccelerometData[i].rawAcceleration * deltaT);

          processedAccelerometerData.add(ProcessedUserAccelerometerZAxisData(
              timestamp: relevantRawAccelerometData[i].timestamp,
              barcodeDistanceFromCamera: totalDistanceMoved));
        }
      }

      //  6. We now have 2 lists
      //     i. processedAccelerometerData(distanceMoved,timestamp)
      //    ii. onImageBarcodeSizes(Barcode sizes,timestamp)
      //
      //  Now we will match the distance moved to the barcode sizes using the timestamps.
      //  Then Write the matched data to the matchedDataHiveBox.

      //Matches OnImageBarcodeSize and DistanceFromCamera using timestamps and writes to Hive Database
      for (OnImageBarcodeSize onImageBarcodeSize in onImageBarcodeSizes) {
        //Find the firts accelerometer data where the timestamp is >= to the OnImageBarcodeSize timestamp
        int distanceFromCameraIndex = processedAccelerometerData.indexWhere(
            (element) => element.timestamp >= onImageBarcodeSize.timestamp);
        //Checks that entry exists
        if (distanceFromCameraIndex != -1) {
          //Create the entry.
          BarcodeSizeDistanceEntry sizeDistanceEntry =
              BarcodeSizeDistanceEntry()
                ..diagonalSize = onImageBarcodeSize.averageBarcodeDiagonalLength
                ..distanceFromCamera =
                    processedAccelerometerData[distanceFromCameraIndex]
                        .barcodeDistanceFromCamera;

          //Add to entries list.
          barcodeSizeDistanceEntries.add(sizeDistanceEntry);

          double focalLength = onImageBarcodeSize.averageBarcodeDiagonalLength *
              (processedAccelerometerData[distanceFromCameraIndex]
                      .barcodeDistanceFromCamera /
                  currentBarcodeSize);

          focalLengths.add(focalLength);
        }
      }

      final prefs = await SharedPreferences.getInstance();

      //Calculate the average focal length.
      double sumOfFocalLengths = prefs.getDouble(focalLengthPreference) ?? 0;
      for (double focalLength in focalLengths) {
        sumOfFocalLengths = sumOfFocalLengths + focalLength;
      }
      double finalFocalLength = sumOfFocalLengths / focalLengths.length;
      //Set the focal Length of the camera

      prefs.setDouble(focalLengthPreference, finalFocalLength);
      focalLength = finalFocalLength;
      log('focal length: ' + finalFocalLength.toString());

      isarDatabase!.writeTxnSync((isar) => isar.barcodeSizeDistanceEntrys
          .putAllSync(barcodeSizeDistanceEntries));
    }
    return barcodeSizeDistanceEntries;
  }
}

///Check that the movement is away from the barcode
bool checkMovementDirection(
    double totalDistanceMoved,
    List<RawUserAccelerometerZAxisData> relevantRawAccelerometData,
    int i,
    int deltaT) {
  return totalDistanceMoved <=
      totalDistanceMoved +
          (-relevantRawAccelerometData[i].rawAcceleration * deltaT);
}

//Get rawAccelerationData that falls in the timerange of the scanned Barcodes
List<RawUserAccelerometerZAxisData> getRelevantRawAccelerometerData(
    List<RawUserAccelerometerZAxisData> allRawAccelerometData,
    int timeRangeStart) {
  //Sort rawAccelerometerData by timestamp descending.
  allRawAccelerometData.sort((a, b) => a.timestamp.compareTo(b.timestamp));

  return allRawAccelerometData
      .where((element) => element.timestamp >= timeRangeStart)
      .toList();
}

//Returns all OnImageBarcodeSizes (timestamp, averageBarcodeDiagonalLength)
List<OnImageBarcodeSize> getOnImageBarcodeSizes(
    List<BarcodeData> rawBarcodesData) {
  List<OnImageBarcodeSize> onImageBarcodeSizes = [];
  for (BarcodeData rawBarcodeData in rawBarcodesData) {
    onImageBarcodeSizes.add(OnImageBarcodeSize(
        timestamp: rawBarcodeData.timestamp,
        averageBarcodeDiagonalLength:
            rawBarcodeData.averageBarcodeDiagonalLength));
  }

  return onImageBarcodeSizes;
}
