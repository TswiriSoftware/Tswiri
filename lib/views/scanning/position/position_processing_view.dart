// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'dart:io';

import 'package:flutter_google_ml_kit/functions/position_functions/average_inter_barcode_vectors.dart';
import 'package:flutter_google_ml_kit/functions/position_functions/generate_coordinates.dart';
import 'package:flutter_google_ml_kit/functions/position_functions/create_inter_barcode_vectors.dart';
import 'package:flutter_google_ml_kit/functions/position_functions/create_on_image_barcode_data.dart';
import 'package:flutter_google_ml_kit/global_values/shared_prefrences.dart';
import 'package:flutter_google_ml_kit/isar_database/barcodes/barcode_property/barcode_property.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/grid/coordinate_entry/coordinate_entry.dart';
import 'package:flutter_google_ml_kit/objects/grid/processing/on_image_inter_barcode_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/global_values/global_colours.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/objects/grid/interbarcode_vector.dart';
import 'package:isar/isar.dart';
import 'grid_visualizer_painter.dart';

class PositionProcessingView extends StatefulWidget {
  const PositionProcessingView({
    Key? key,
    required this.barcodeDataBatches,
    required this.parentContainer,
  }) : super(key: key);

  final List barcodeDataBatches;

  final ContainerEntry parentContainer;

  @override
  _PositionProcessingViewState createState() => _PositionProcessingViewState();
}

class _PositionProcessingViewState extends State<PositionProcessingView> {
  late Future<List<CoordinateEntry>> _future;

  @override
  void initState() {
    _future = processData(barcodeDataBatches: widget.barcodeDataBatches);
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
          children: [
            _continueToVisualizer(),
          ],
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Processing Data',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<CoordinateEntry>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _viewer(snapshot.data!);
          } else if (snapshot.hasError) {
            return Text(
              "${snapshot.error}",
              style: const TextStyle(fontSize: 20, color: deeperOrange),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Widget _viewer(List<CoordinateEntry> coordinates) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: sunbirdOrange, width: 1),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.8,
      child: InteractiveViewer(
        maxScale: 25,
        minScale: 0.01,
        child: CustomPaint(
          size: Size.infinite,
          painter: GridVisualizerPainter(
            coordinates: coordinates,
            parentBarcodeUID: widget.parentContainer.barcodeUID!,
          ),
        ),
      ),
    );
  }

  Widget _continueToVisualizer() {
    return FloatingActionButton(
      heroTag: null,
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Icon(Icons.check_circle_outline_rounded),
    );
  }

  ///1. Create a list of OnImageInterBarcodeData from barcodeDataBatches.
  ///2. Create list of InterbarcodeVector. (Real)
  ///3. Remove outliers and calculate the average.
  ///4. Build a grid from finalRealInterBarcodeData.

  Future<List<CoordinateEntry>> processData({
    required List barcodeDataBatches,
  }) async {
    String path = '/storage/emulated/0/Download/';

    File barcodeDataBatchesFile = File('${path}barcodeDataBatches.txt');
    if (!(await barcodeDataBatchesFile.exists())) {
      await barcodeDataBatchesFile.writeAsString(
        'barcodeDataBatches\n${barcodeDataBatches.length}\n\n$barcodeDataBatches',
        mode: FileMode.write,
      );
    }

    List<BarcodeProperty> barcodeProperties =
        isarDatabase!.barcodePropertys.where().findAllSync();

    ///1. Create a list of OnImageInterBarcodeData from barcodeDataBatches.
    List<OnImageInterBarcodeData> onImageInterBarcodeData =
        createOnImageBarcodeData(barcodeDataBatches);

    // List onImageInterBarcodeDataHashCode =
    //     onImageInterBarcodeData.map((e) => e.comparableHashCode).toList();

    // File onImageBarcodeDataFile = File('${path}onImageBarcodeData.txt');

    // if (!(await onImageBarcodeDataFile.exists())) {
    //   await onImageBarcodeDataFile.writeAsString(
    //     'onImageBarcodeDataHashCodes\n\n$onImageInterBarcodeDataHashCode',
    //     mode: FileMode.write,
    //   );
    // }

    //2. Create a list of InterbarcodeVectors from OnImageInterBarcodeData.
    List<InterBarcodeVector> interBarcodeVectors = createInterbarcodeVectors(
        onImageInterBarcodeData, barcodeProperties, focalLength);

    // List interBarcodeVectorsHashCode =
    //     interBarcodeVectors.map((e) => e.comparableHashCode).toList();

    // File interBarcodeVectorsFile = File('${path}InterBarcodeVectorData.txt');

    // if (!(await interBarcodeVectorsFile.exists())) {
    //   await interBarcodeVectorsFile.writeAsString(
    //     'InterBarcodeVectorDataHashCodes\n\n$interBarcodeVectorsHashCode',
    //     mode: FileMode.write,
    //   );
    // }

    //3. Remove outliers and calculate the averages.
    List<InterBarcodeVector> finalRealInterBarcodeData =
        averageInterbarcodeData(interBarcodeVectors);

    // List finalRealInterBarcodeDataHashCode =
    //     finalRealInterBarcodeData.map((e) => e.comparableHashCode).toList();

    // File finalRealInterBarcodeDataFile =
    //     File('${path}finalInterBarcodeVectorData.txt');

    // if (!(await finalRealInterBarcodeDataFile.exists())) {
    //   await finalRealInterBarcodeDataFile.writeAsString(
    //     'finalInterBarcodeVectorData\n\n$finalRealInterBarcodeDataHashCode',
    //     mode: FileMode.write,
    //   );
    // }

    //4. Generate the Grid.
    List<CoordinateEntry> coordinates =
        generateCoordinates(widget.parentContainer, finalRealInterBarcodeData);

    // List coordinatesHashCode = coordinates.map((e) => e.comparableHashCode).toList();

    File coordinatesFile = File('${path}coordinatesData.txt');

    if (!(await coordinatesFile.exists())) {
      await coordinatesFile.writeAsString(
        'coordinatesData\n\n',
        mode: FileMode.write,
      );
      for (var e in coordinates) {
        await coordinatesFile.writeAsString('$e\n', mode: FileMode.append);
      }
    }

    //5. Write to Isar.
    List<String> barcodes = coordinates.map((e) => e.barcodeUID).toList();
    isarDatabase!.writeTxnSync((isar) {
      isar.coordinateEntrys
          .filter()
          .repeat(barcodes, (q, String element) => q.barcodeUIDMatches(element))
          .deleteAllSync();
      isar.coordinateEntrys.putAllSync(coordinates, replaceOnConflict: true);
    });

    return coordinates;
  }
}
