import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/calibrationAdapters/distance_from_camera_lookup_entry.dart';
import 'package:flutter_google_ml_kit/globalValues/global_hive_databases.dart';
import 'package:flutter_google_ml_kit/objects/calibration/user_accelerometer_z_axis_data_objects.dart';
import 'package:flutter_google_ml_kit/objects/calibration/barcode_size_objects.dart';
import 'package:hive/hive.dart';

import '../../databaseAdapters/allBarcodes/barcode_entry.dart';
import '../../functions/barcodeTools/get_data_functions.dart';
import 'calibration_data_visualizer_view.dart';
import 'widgets/calibration_display_widgets.dart';

class BarcodeCalibrationDataProcessingView extends StatefulWidget {
  const BarcodeCalibrationDataProcessingView(
      {Key? key,
      required this.rawBarcodeData,
      required this.rawUserAccelerometerData,
      required this.startTimeStamp})
      : super(key: key);

  final List<BarcodeData> rawBarcodeData;
  final List<RawUserAccelerometerZAxisData> rawUserAccelerometerData;
  final int startTimeStamp;

  @override
  _BarcodeCalibrationDataProcessingViewState createState() =>
      _BarcodeCalibrationDataProcessingViewState();
}

class _BarcodeCalibrationDataProcessingViewState
    extends State<BarcodeCalibrationDataProcessingView> {
  List<DistanceFromCameraLookupEntry> displayList = [];

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
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) =>
                        const CalibrationDataVisualizerView()));
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
        child: FutureBuilder<List>(
          future: processData(
              widget.rawBarcodeData, widget.rawUserAccelerometerData),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            } else {
              List myList = snapshot.data!;
              return ListView.builder(
                  itemCount: myList.length,
                  itemBuilder: (context, index) {
                    DistanceFromCameraLookupEntry data = myList[index];

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
                          DisplayMatchedDataWidget(
                            dataObject: data,
                          ),
                        ],
                      );
                    } else {
                      return DisplayMatchedDataWidget(
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

  Future<List<DistanceFromCameraLookupEntry>> processData(
      List<BarcodeData> rawBarcodesData,
      List<RawUserAccelerometerZAxisData> rawAccelerometData) async {
    if (rawAccelerometData.isNotEmpty && rawBarcodesData.isNotEmpty) {
      //1. Get all barcodes.
      List<BarcodeDataEntry> allBarcodes = [];
      allBarcodes.addAll(await getGeneratedBarcodes());
      double currentBarcodeSize = 0;

      if (rawBarcodesData.first.barcode.value.displayValue != null) {
        int currentBarcodeID =
            int.parse(rawBarcodesData.first.barcode.value.displayValue!);
        currentBarcodeSize = allBarcodes
            .firstWhere((element) => element.barcodeID == currentBarcodeID)
            .barcodeSize;
      } else {
        return Future.error('Error: Unkown barcode scanned.');
      }

      //2. A list of all barcode diagonal side lengths at different points in time.
      List<OnImageBarcodeSize> onImageBarcodeSizes =
          getOnImageBarcodeSizes(rawBarcodesData);

      //3. Get range of relevant rawAccelerometer data
      List<RawUserAccelerometerZAxisData> relevantRawAccelerometData =
          getRelevantRawAccelerometerData(rawAccelerometData,
              widget.startTimeStamp, onImageBarcodeSizes.last.timestamp);

      //List that contains processed accelerometer data//
      List<ProcessedUserAccelerometerZAxisData> processedAccelerometerData = [];

      //4. Set the starting distance as 0
      processedAccelerometerData.add(ProcessedUserAccelerometerZAxisData(
          timestamp: rawAccelerometData.first.timestamp,
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
              timestamp: rawAccelerometData[i].timestamp,
              barcodeDistanceFromCamera: totalDistanceMoved));
        }
      }

      //  6. We now have 2 lists
      //     i. processedAccelerometerData(distanceMoved,timestamp)
      //    ii. onImageBarcodeSizes(Barcode sizes,timestamp)
      //
      //  Now we will match the distance moved to the barcode sizes using the timestamps.
      //  Then Write the matched data to the matchedDataHiveBox.

      //Box to store valid calibration Data
      Box<DistanceFromCameraLookupEntry> matchedDataHiveBox =
          await Hive.openBox(matchedDataHiveBoxName);

      //Matches OnImageBarcodeSize and DistanceFromCamera using timestamps and writes to Hive Database
      for (OnImageBarcodeSize onImageBarcodeSize in onImageBarcodeSizes) {
        //Find the firts accelerometer data where the timestamp is >= to the OnImageBarcodeSize timestamp
        int distanceFromCameraIndex = processedAccelerometerData.indexWhere(
            (element) => element.timestamp >= onImageBarcodeSize.timestamp);
        //Checks that entry exists
        if (distanceFromCameraIndex != -1) {
          //Creates an entry in the Hive Database.
          DistanceFromCameraLookupEntry matchedCalibrationDataHiveObject =
              DistanceFromCameraLookupEntry(
                  onImageBarcodeDiagonalLength:
                      onImageBarcodeSize.averageBarcodeDiagonalLength,
                  distanceFromCamera:
                      processedAccelerometerData[distanceFromCameraIndex]
                          .barcodeDistanceFromCamera,
                  actualBarcodeDiagonalLengthKey: currentBarcodeSize);

          matchedDataHiveBox.put(onImageBarcodeSize.timestamp.toString(),
              matchedCalibrationDataHiveObject);

          //log(matchedCalibrationDataHiveObject.toString());

          displayList.add(matchedCalibrationDataHiveObject);
        }
      }
    }
    return displayList;
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
    int timeRangeStart,
    int timeRangeEnd) {
  //Sort rawAccelerometerData by timestamp descending.
  allRawAccelerometData.sort((a, b) => a.timestamp.compareTo(b.timestamp));

  //The +10 includes a couple of extra measurements.
  return allRawAccelerometData
      .where((element) =>
          element.timestamp >= timeRangeStart &&
          element.timestamp + 10 <= timeRangeEnd)
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
