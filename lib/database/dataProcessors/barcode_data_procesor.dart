// // ignore_for_file: implementation_imports

// import 'package:fast_immutable_collections/src/ilist/list_extension.dart';
// import 'package:flutter_google_ml_kit/database/raw_data_adapter.dart';
// import 'package:hive/hive.dart';

// processRawData() async {
//   var processedDataBox = await Hive.openBox('processedDataBox');
//   var rawDataBox = await Hive.openBox('rawDataBox');

//   var rawData = rawDataBox.toMap();
//   print(rawDataBox.toMap());
//   List uids = [];
//   uids.clear();
//   rawData.forEach((key, value) {
//     List vectorData = value
//         .toString()
//         .replaceAll(RegExp(r'\[\]'), '')
//         .replaceAll('_', ',')
//         .replaceAll(' ', '')
//         .split(',')
//         .toList();

//     uids.add(vectorData[0].toString());
//     uids.removeDuplicates();
//     if (uids.contains(vectorData[1])) {
//     } else {
//       var qrCodesVector = QrCodes(
//           uid: '${vectorData[0]}_${vectorData[1]}'.toString(),
//           X: double.parse(vectorData[2]),
//           Y: double.parse(vectorData[3]),
//           createdDated: int.parse(vectorData[4]));
//       processedDataBox.put('${vectorData[0]}_${vectorData[1]}', qrCodesVector);
//     }
//   });
// }
