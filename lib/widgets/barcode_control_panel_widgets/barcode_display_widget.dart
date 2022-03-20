import 'package:flutter/material.dart';

import '../../objects/all_barcode_data.dart';
import '../basic_outline_containers/dark_container.dart';
import '../basic_outline_containers/light_container.dart';

class BarcodeDisplayWidget extends StatelessWidget {
  const BarcodeDisplayWidget({Key? key, required this.barcodeAndTagData})
      : super(key: key);

  final AllBarcodeData barcodeAndTagData;

  @override
  Widget build(BuildContext context) {
    return LightContainer(
      padding: 5,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IDdisplayWidget(
            id: barcodeAndTagData.barcodeID.toString(),
            size: 40,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: DarkContainer(
              padding: 10,
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Tags: ' + checkIfEmpty(barcodeAndTagData.tags!),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//Checks if the barcode has any tags
String checkIfEmpty(List<String> listOfTags) {
  String tags = '';

  if (listOfTags.isEmpty) {
    tags = 'WoW much empty';
  } else {
    tags = listOfTags.toString().replaceAll(']', '').replaceAll('[', '');
  }
  return tags;
}

class IDdisplayWidget extends StatelessWidget {
  const IDdisplayWidget({Key? key, required this.id, required this.size})
      : super(key: key);
  final String id;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration:
          const BoxDecoration(color: Colors.deepOrange, shape: BoxShape.circle),
      child: Center(
        child: Text(id),
      ),
    );
  }
}

// Row(
//           children: [
// //Barcode ID
// Container(
//   margin: const EdgeInsets.all(4),
//   height: 60,
//   width: (MediaQuery.of(context).size.width * 0.13),
//   decoration: const BoxDecoration(
//       color: Colors.deepOrange, shape: BoxShape.circle),
//   child: Center(
//     child: Text(barcodeAndTagData.barcodeID.toString()),
//   ),
// ),
//             const SizedBox(
//               width: 5,
//             ),
//             Container(
//               decoration: const BoxDecoration(
//                   color: Colors.black38,
//                   borderRadius: BorderRadius.all(Radius.circular(8))),
//               height: 55,
//               width: (MediaQuery.of(context).size.width * 0.82),
//               child: Center(
                // child: Text(
                //   checkIfEmpty(barcodeAndTagData.tags!),
                //   textAlign: TextAlign.center,
                // ),
//               ),
//             )
//           ],
//         ),
