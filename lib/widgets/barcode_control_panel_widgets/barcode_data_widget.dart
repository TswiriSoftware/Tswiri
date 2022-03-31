// import 'package:flutter/material.dart';
// import 'package:flutter_google_ml_kit/objects/all_barcode_data.dart';
// import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/dark_container.dart';
// import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/orange_outline_container.dart';

// import 'package:provider/provider.dart';

// import '../../objects/change_notifiers.dart';
// import '../basic_outline_containers/light_container.dart';

// class BarcodeDataContainer extends StatefulWidget {
//   const BarcodeDataContainer({Key? key, required this.barcodeAndTagData})
//       : super(key: key);

//   final AllBarcodeData barcodeAndTagData;

//   @override
//   State<BarcodeDataContainer> createState() => _BarcodeDataContainerState();
// }

// class _BarcodeDataContainerState extends State<BarcodeDataContainer> {
//   double barcodeSize = 0;
//   String description = '';
//   final TextEditingController _barcodeDiagonalLengthController =
//       TextEditingController();

//   final TextEditingController _barcodeDescriptionController =
//       TextEditingController();

//   @override
//   void initState() {
//     _barcodeDiagonalLengthController.text =
//         widget.barcodeAndTagData.barcodeSize.toString();
//     _barcodeDescriptionController.text =
//         widget.barcodeAndTagData.description.toString();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LightContainer(
//       margin: 6,
//       padding: 5,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           //Heading Barcode ID
//           Padding(
//             padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Barcode ID: ' +
//                       widget.barcodeAndTagData.barcodeID.toString(),
//                   style: const TextStyle(fontSize: 20),
//                 ),
//               ],
//             ),
//           ),
//           const Divider(
//             color: Colors.white,
//           ),
//           DarkContainer(
//             padding: 10,
//             child: Row(
//               children: [
//                 const Text(
//                   'Barcode diagonal length: ',
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 Expanded(
//                   child: OrangeOutlineContainer(
//                     padding: 5,
//                     child: SizedBox(
//                       height: 25,
//                       child: TextField(
//                         textAlign: TextAlign.end,
//                         keyboardType: const TextInputType.numberWithOptions(),
//                         maxLines: 1,
//                         controller: _barcodeDiagonalLengthController,
//                         onTap: () {
//                           _barcodeDiagonalLengthController.clear();
//                         },
//                         onSubmitted: (value) {
//                           if (double.tryParse(value) != null) {
//                             _barcodeDiagonalLengthController.text = value;
//                             Provider.of<BarcodeDataChangeNotifier>(context,
//                                     listen: false)
//                                 .changeBarcodeSize(
//                                     widget.barcodeAndTagData.barcodeID,
//                                     double.parse(value));
//                           } else {
//                             _barcodeDiagonalLengthController.text = 'invalid';
//                           }
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//                 const Text(' mm'),
//                 SizedBox(
//                   width: 20,
//                   child: IconButton(
//                     onPressed: () {
//                       barcodeDiagonalLengthDialog(context);
//                     },
//                     icon: const Icon(Icons.info_outline_rounded),
//                     color: Colors.deepOrange,
//                     iconSize: 20,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 5),
//           DarkContainer(
//             padding: 10,
//             child: InkWell(
//                 onTap: () {
//                   Provider.of<BarcodeDataChangeNotifier>(context, listen: false)
//                       .changeFixed(widget.barcodeAndTagData.barcodeID);
//                 },
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'Is this barcode a marker: ',
//                       style: TextStyle(fontSize: 18),
//                     ),
//                     OrangeOutlineContainer(
//                       padding: 5,
//                       child: Padding(
//                         padding: const EdgeInsets.only(
//                             left: 5, right: 5, top: 1, bottom: 1),
//                         child: Builder(
//                           builder: (context) {
//                             bool isMarker =
//                                 Provider.of<BarcodeDataChangeNotifier>(context)
//                                     .isFixed;
//                             if (isMarker) {
//                               return const Text(
//                                 'yes',
//                                 style: TextStyle(fontSize: 15),
//                               );
//                             } else {
//                               return const Text(
//                                 'no',
//                                 style: TextStyle(fontSize: 15),
//                               );
//                             }
//                           },
//                         ),
//                       ),
//                     )
//                   ],
//                 )),
//           ),
//           const SizedBox(height: 5),
//           DarkContainer(
//             padding: 10,
//             child: InkWell(
//               onTap: () {
//                 editBarcodeDescription(context);
//               },
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Description: ',
//                     style: TextStyle(fontSize: 18),
//                   ),
//                   const SizedBox(height: 5),
//                   Text(Provider.of<BarcodeDataChangeNotifier>(context)
//                       .description),
//                   const SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: const [
//                       OrangeOutlineContainer(
//                         padding: 5,
//                         child: Text(
//                           'Tap to edit',
//                           style: TextStyle(fontSize: 12),
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void barcodeDiagonalLengthDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Barcode Diagonal Length'),
//           content: const Text(
//               "Image here\nThe length in mm from the barcode's top left corner to the bottom right corner."),
//           //TODO: Request Image to show Barcode Sides with arrow.
//           actions: [
//             ElevatedButton(
//               child: const Text('Ok'),
//               onPressed: () {
//                 description = _barcodeDescriptionController.text;
//                 setBarcodeDescription();
//                 Navigator.of(context).pop();
//               },
//             )
//           ],
//         );
//       },
//     );
//   }

//   void editBarcodeDescription(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Enter Barcode Description.'),
//           content: TextField(
//             controller: _barcodeDescriptionController,
//             textCapitalization: TextCapitalization.sentences,
//             maxLines: 3,
//             textInputAction: TextInputAction.go,
//             decoration:
//                 const InputDecoration(hintText: "Enter barcode description."),
//           ),
//           actions: [
//             ElevatedButton(
//               child: const Text('Submit'),
//               onPressed: () {
//                 description = _barcodeDescriptionController.text;
//                 setBarcodeDescription();
//                 Navigator.of(context).pop();
//               },
//             )
//           ],
//         );
//       },
//     );
//   }

//   setBarcodeDescription() {
//     Provider.of<BarcodeDataChangeNotifier>(context, listen: false)
//         .changeBarcodeDescription(
//             widget.barcodeAndTagData.barcodeID, description);
//   }
// }
