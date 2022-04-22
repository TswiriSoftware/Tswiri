import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/barcode_position_calulation/barcode_position_calculator.dart';
import 'package:flutter_google_ml_kit/functions/math_functionts/round_to_double.dart';
import 'package:flutter_google_ml_kit/objects/display/display_point.dart';
import 'package:flutter_google_ml_kit/objects/display/real_barcode_position.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcode_scanning/barcode_position_scanner/painters/barcode_position_visualizer_painter.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/marker/marker.dart';
import 'package:isar/isar.dart';

class BarcodePositionScannerDataVisualizationView extends StatefulWidget {
  const BarcodePositionScannerDataVisualizationView({
    Key? key,
    required this.parentContainerUID,
    required this.barcodesToScan,
    required this.gridMarkers,
  }) : super(key: key);

  final String parentContainerUID;
  final List<String> barcodesToScan;
  final List<String> gridMarkers;

  @override
  _BarcodePositionScannerDataVisualizationViewState createState() =>
      _BarcodePositionScannerDataVisualizationViewState();
}

class _BarcodePositionScannerDataVisualizationViewState
    extends State<BarcodePositionScannerDataVisualizationView> {
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              heroTag: null,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.check_circle_outline_rounded),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'Position Visualizer',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<List<DisplayPoint>>(
        future: calculateDisplaypoints(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error no positions to display',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          } else {
            List<DisplayPoint> myPoints = snapshot.data!;
            return Center(
              child: InteractiveViewer(
                maxScale: 25,
                minScale: 0.01,
                child: CustomPaint(
                  size: Size.infinite,
                  painter: BarcodePositionVisualizerPainter(myPoints: myPoints),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<List<DisplayPoint>> calculateDisplaypoints() async {
    //Calculate realBarcodePositions.
    List<RealBarcodePosition> realBarcodePositions =
        calculateRealBarcodePositions(parentUID: widget.parentContainerUID);

    if (realBarcodePositions.isEmpty) {
      return Future.error("realBarcodePositions.isEmpty",
          StackTrace.fromString("This is its trace"));
    }

    List<String>? markers = isarDatabase?.markers
        .filter()
        .parentContainerUIDMatches(widget.parentContainerUID)
        .barcodeUIDProperty()
        .findAllSync();

    //Get Screen width and height.
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    //Calculate unitVectors.
    List<double> unitVector = unitVectors(
      realBarcodePositions: realBarcodePositions,
      width: width,
      height: height,
    );

    List<DisplayPoint> myPoints = [];

    for (var i = 0; i < realBarcodePositions.length; i++) {
      RealBarcodePosition? realBarcodePosition =
          realBarcodePositions.elementAt(i);

      Offset? barcodePosition = Offset(
          (realBarcodePosition.offset?.dx ?? 1 * unitVector[0]) +
              (width / 2) -
              (width / 8),
          (realBarcodePosition.offset?.dy ?? 1 * unitVector[1]) +
              (height / 2) -
              (height / 8));

      List<double> barcodeRealPosition = [
        roundDouble(realBarcodePosition.offset?.dx ?? 0, 5),
        roundDouble(realBarcodePosition.offset?.dy ?? 0, 5),
        roundDouble(realBarcodePosition.zOffset ?? 0, 5),
      ];

      if (markers != null && markers.contains(realBarcodePosition.uid)) {
        myPoints.add(DisplayPoint(
            isMarker: true,
            barcodeID: realBarcodePosition.uid,
            barcodePosition: barcodePosition,
            realBarcodePosition: barcodeRealPosition));
      } else {
        myPoints.add(DisplayPoint(
            isMarker: false,
            barcodeID: realBarcodePosition.uid,
            barcodePosition: barcodePosition,
            realBarcodePosition: barcodeRealPosition));
      }
    }

    //log(myPoints.toString());
    return myPoints;
  }

  List<double> unitVectors(
      {required List<RealBarcodePosition> realBarcodePositions,
      required double width,
      required double height}) {
    double sX = 0;
    double bX = 0;
    double sY = 0;
    double bY = 0;

    for (var i = 0; i < realBarcodePositions.length; i++) {
      RealBarcodePosition data = realBarcodePositions.elementAt(i);
      if (data.offset != null) {
        double xDistance = data.offset!.dx;
        double yDistance = data.offset!.dy;
        if (xDistance < sX) {
          sX = xDistance;
        }
        if (xDistance > bX) {
          bX = xDistance;
        }
        if (yDistance < sY) {
          sY = yDistance;
        }
        if (yDistance > bY) {
          bY = yDistance;
        }
      }
    }

    double totalXdistance = (sX - bX).abs() + 500;
    double totalYdistance = (sY - bY).abs() + 500;

    double unitX = width / 2 / totalXdistance;
    double unitY = height / 2 / totalYdistance;

    return [unitX, unitY];
  }
}
