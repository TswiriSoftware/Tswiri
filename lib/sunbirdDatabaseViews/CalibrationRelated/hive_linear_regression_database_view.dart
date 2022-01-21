import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/dataInjectors/functions.dart';
import 'package:hive/hive.dart';

class HiveLinearRegressionDatabaseView extends StatefulWidget {
  const HiveLinearRegressionDatabaseView({Key? key}) : super(key: key);

  @override
  _HiveLinearRegressionDatabaseViewState createState() =>
      _HiveLinearRegressionDatabaseViewState();
}

class _HiveLinearRegressionDatabaseViewState
    extends State<HiveLinearRegressionDatabaseView> {
  var displayList = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Hive Calibrated Database'),
          centerTitle: true,
          elevation: 0,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                heroTag: null,
                onPressed: () async {
                  var matchedDataBox = await Hive.openBox('matchedDataBox');
                  matchedDataBox.clear();
                  setState(() {});
                },
                child: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
        body: FutureBuilder(
            future: _getPoints(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              } else {
                var dataPoints = snapshot.data;
                //print(dataPoints.runtimeType);
                //print(dataPoints);
                return Center(
                  child: InteractiveViewer(
                    maxScale: 6,
                    minScale: 0.3,
                    child: CustomPaint(
                      size: Size.infinite,
                      painter: OpenPainter(dataPoints: dataPoints),
                    ),
                  ),
                );
              }
            }));
  }

  Future<List> loadData() async {
    displayList.clear();

    displayList.add('');
    return displayList;
  }
}

class OpenPainter extends CustomPainter {
  OpenPainter({required this.dataPoints});
  var dataPoints;

  @override
  paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Colors.blueAccent
      ..strokeWidth = 6;

    canvas.drawPoints(PointMode.points, dataPoints, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

_getPoints(BuildContext context) async {
  var matchedDataBox = await Hive.openBox('matchedDataBox');

  List<Offset> points = listOfPoints(matchedDataBox);
  return points;
}

//TODO: LinearEquation { properties : m,b } DONE

//TODO: CalulateDistance { LinearEquation,x } -> y DONE

//TODO: Calulate equation (Data ..... ) { output : Linear equation object} DONE