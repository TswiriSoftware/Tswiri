// ignore_for_file: implementation_imports

import 'package:hive/hive.dart';

processData(Box rawDataBox, Box processedDataBox) async {}

 // processedDataBox.clear();
  // var data = rawDataBox.toMap();
  // List displayList = [];
  // List displayListUID1 = [];

  // data.forEach((key, value) {
  //   List vectorData =
  //       value.toString().replaceAll(RegExp(r'\[\]'), '').split('_').toList();
  //   displayListUID1.add(vectorData[0].toString());
  //   displayList.add(vectorData);
  //   displayListUID1.removeDuplicates();
  // });
  // //print(displayListUID1.toString());

  // for (var i = 0; i < displayList.length; i++) {
  //   if (displayListUID1.contains(displayList[i][1])) {
  //     print(displayList[i]);
  //     displayList.removeAt(i);
  //   }
  // }

  // displayList.toString().replaceAll(RegExp(r'\[\]\_'), '').split(',');
  // for (var i = 0; i < displayList.length; i++) {
  //   var displayListItem = displayList[i]
  //       .toString()
  //       .replaceAll('[', '')
  //       .replaceAll(']', '')
  //       .replaceAll(' ', '')
  //       .split(',')
  //       .toList();

  //   //print('${displayListItem[0]}_${displayListItem[1]}');
  //   var qrCodesVector = QrCodes(
  //       uid: '${displayListItem[0]}_${displayListItem[1]}'.toString(),
  //       X: double.parse(displayListItem[2]),
  //       Y: double.parse(displayListItem[3]),
  //       createdDated: int.parse(displayListItem[4]));

  //   processedDataBox.put(
  //       '${displayListItem[0]}_${displayListItem[1]}', qrCodesVector);
  // }
  // //print(processedDataBox.values);