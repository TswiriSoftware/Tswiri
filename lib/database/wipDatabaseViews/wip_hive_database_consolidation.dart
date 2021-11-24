// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter_google_ml_kit/widgets/alert_dialog_widget.dart';
// import 'package:hive/hive.dart';
// import 'package:fast_immutable_collections/fast_immutable_collections.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../databaseAdapters/consolidated_data_adapter.dart';

// class WipHiveDatabaseConsolidationView extends StatefulWidget {
//   const WipHiveDatabaseConsolidationView({Key? key}) : super(key: key);

//   @override
//   _WipHiveDatabaseConsolidationViewState createState() =>
//       _WipHiveDatabaseConsolidationViewState();
// }

// class _WipHiveDatabaseConsolidationViewState
//     extends State<WipHiveDatabaseConsolidationView> {
//   List displayList = [];
//   List fixedPoints = ['1'];
//   List processedDataList = [];
//   Map<String, List> processedDataMap = {};
//   Map<String, List> consolidatedDataMap = {};
//   Map<String, List> currentPoints = {};
//   final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

//   @override
//   void initState() {
//     super.initState();
//     displayList.clear();
//     fixedPoints.clear();
//     _getPrefs(_prefs, fixedPoints);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.all(18.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             FloatingActionButton(
//               //Clear Database
//               heroTag: null,
//               onPressed: () async {
//                 displayList.clear();
//                 var consolidatedDataBox =
//                     await Hive.openBox('consolidatedDataBox');
//                 var pro = await Hive.openBox('processedDataBox');
//                 consolidatedDataBox.clear();
//                 pro.clear();
//                 showMyAboutDialog(context, "Deleted Database");
//               },
//               child: const Icon(Icons.delete),
//             ),
//             FloatingActionButton(
//               heroTag: null,
//               onPressed: () {
//                 fixedPointsDialog(context, fixedPoints, _prefs);
//               },
//               child: const Icon(Icons.change_circle),
//             ),
//             FloatingActionButton(
//               heroTag: null,
//               onPressed: () {
//                 displayList.clear();
//                 setState(() {});
//               },
//               child: const Icon(Icons.refresh),
//             ),
//           ],
//         ),
//       ),
//       appBar: AppBar(
//         title: const Text('Hive Database 2D'),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: FutureBuilder<List>(
//         future: consolidatingData(displayList),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState != ConnectionState.done) {
//             return Column(
//               children: [
//                 Form(child: TextFormField(
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter some text';
//                     }
//                     return null;
//                   },
//                 )),
//                 const Center(child: CircularProgressIndicator()),
//               ],
//             );
//           } else {
//             List myList = snapshot.data ?? [];
//             return ListView.builder(
//                 itemCount: myList.length,
//                 itemBuilder: (context, index) {
//                   var myText = myList[index]
//                       .toString()
//                       .replaceAll(RegExp(r'\[|\]'), '')
//                       .replaceAll(' ', '')
//                       .split(',')
//                       .toList();

//                   return Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         child: Text(myText[0], textAlign: TextAlign.start),
//                         width: 30,
//                       ),
//                       SizedBox(
//                         child: Text(myText[1], textAlign: TextAlign.start),
//                         width: 75,
//                       ),
//                       SizedBox(
//                         child: Text(myText[2], textAlign: TextAlign.start),
//                         width: 75,
//                       ),
//                       SizedBox(
//                         child: Text(myText[3], textAlign: TextAlign.start),
//                         width: 150,
//                       ),
//                     ],
//                   );
//                 });
//           }
//         },
//       ),
//     );
//   }

//   Future<List> consolidatingData(List displayList) async {
//     displayList.clear();
//     currentPoints.clear();

//     var processedDataBox = await Hive.openBox('processedDataBox');
//     var consolidatedDataBox = await Hive.openBox('WipConsolidatedDataBox');

//     _generateProcessedDataMap(processedDataBox, processedDataMap);
//     debugPrint('processedDataMap: ${processedDataMap.toIMap()}');
//     _generateConsolidatedDataMap(processedDataMap, consolidatedDataMap);

//     //_displayList(consolidatedDataMap, displayList, consolidatedDataBox);
//     return displayList;
//   }
// }

// _displayList(
//     Map consolidatedDataMap, List displayList, Box consolidatedDataBox) {
//   for (var i = 0; i < consolidatedDataMap.length; i++) {
//     displayList.add([
//       consolidatedDataMap.keys.elementAt(i),
//       consolidatedDataMap.values.elementAt(i)[0],
//       consolidatedDataMap.values.elementAt(i)[1],
//       consolidatedDataMap.values.elementAt(i)[2]
//     ]);

//     var data = ConsolidatedData(
//         uid: consolidatedDataMap.keys.elementAt(i),
//         X: consolidatedDataMap.values.elementAt(i)[0],
//         Y: consolidatedDataMap.values.elementAt(i)[1],
//         timeStamp:
//             int.parse(consolidatedDataMap.values.elementAt(i)[2].toString()),
//         fixed: false);
//     consolidatedDataBox.put(data.uid, data);
//   }
//   displayList.sort((a, b) => a[0].compareTo(b[0]));

//   //print('consolidatedDataBox: ${consolidatedDataBox.toMap().toIMap()}');
//   //print('displayList: ${displayList.toIList()}');
// }

// double roundDouble(double val, int places) {
//   num mod = pow(10.0, places);
//   return ((val * mod).round().toDouble() / mod);
// }

// _generateProcessedDataMap(Box processedDataBox, Map processedDataMap) {
//   var _processedDataBox = processedDataBox.toMap();
//   _processedDataBox.forEach((key, value) {
//     List qrCodeData = value
//         .toString()
//         .replaceAll(RegExp(r'\[\]'), '')
//         //.replaceAll('_', ',')
//         .replaceAll(' ', '')
//         .split(',')
//         .toList();
//     var qrCodeID = qrCodeData[0].toString().split('_').toList();
//     processedDataMap.putIfAbsent(
//         qrCodeData[0],
//         () => [
//               qrCodeID[0],
//               qrCodeID[1],
//               qrCodeData[1],
//               qrCodeData[2],
//               qrCodeData[3]
//             ]);
//   });
//   //debugPrint('qrCodeData: ${processedDataMap.toIMap()}');
// }

// _generateConsolidatedDataMap(Map processedDataMap, Map consolidatedDataMap) {}

// _getPrefs(Future<SharedPreferences> _prefs, List fixedPoints) async {
//   final SharedPreferences prefs = await _prefs;
//   fixedPoints.clear();
//   fixedPoints.add(prefs.getString('fixedPoints') ?? '1');
// }

// _setPrefs(Future<SharedPreferences> _prefs, List fixedPoints) async {
//   final SharedPreferences prefs = await _prefs;
//   prefs.setString('fixedPoints', fixedPoints[0]);
// }

// fixedPointsDialog(BuildContext context, List fixedPoints,
//     Future<SharedPreferences> _prefs) async {
//   String dropdownValue = fixedPoints[0];
//   return showDialog<void>(
//     context: context,
//     barrierDismissible: false, // user must tap button!
//     builder: (context) {
//       return AlertDialog(
//         title: const Text('Pick Fixed Point'),
//         content: SingleChildScrollView(
//             child: DropdownButton(
//                 value: dropdownValue,
//                 items: <String>['1', '2', '3', '4', '5', '6', '7']
//                     .map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//                 onChanged: (String? newValue) {
//                   fixedPoints.clear();
//                   fixedPoints.add(newValue);

//                   dropdownValue = newValue!;
//                   _setPrefs(_prefs, fixedPoints);
//                 })),
//         actions: <Widget>[
//           TextButton(
//             child: const Text('Ok'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
