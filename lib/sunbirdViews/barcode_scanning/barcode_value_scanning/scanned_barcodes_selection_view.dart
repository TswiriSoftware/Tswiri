// import 'package:flutter/material.dart';

// class ScannedBarcodesSelectionView extends StatefulWidget {
//   const ScannedBarcodesSelectionView({Key? key, required this.scannedBarcodes})
//       : super(key: key);
//   final Set<String> scannedBarcodes;
//   @override
//   _ScannedBarcodesSelectionViewState createState() =>
//       _ScannedBarcodesSelectionViewState();
// }

// class _ScannedBarcodesSelectionViewState
//     extends State<ScannedBarcodesSelectionView> {
//   List<String> scannedBarcodes = [];

//   @override
//   void initState() {
//     scannedBarcodes = widget.scannedBarcodes.toList();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.deepOrange,
//           title: const Text(
//             'Barcodes',
//             style: TextStyle(fontSize: 25),
//           ),
//           centerTitle: true,
//           elevation: 0,
//         ),
//         body: ListView.builder(
//             itemCount: scannedBarcodes.length,
//             itemBuilder: (context, index) {
//               scannedBarcodes.sort();
//               return BarcodeDisplayWidget(barcodeID: scannedBarcodes[index]);
//             }));
//   }
// }

// class BarcodeDisplayWidget extends StatelessWidget {
//   const BarcodeDisplayWidget({Key? key, required this.barcodeID})
//       : super(key: key);
//   final String barcodeID;
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//         onTap: () {
//           ///Pop screen and return selected barcode ID.
//           Navigator.pop(context, barcodeID);
//         },
//         child: Container(
//           margin: const EdgeInsets.only(bottom: 5),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.white60, width: 0.8),
//             borderRadius: const BorderRadius.all(
//               Radius.circular(5),
//             ),
//           ),
//           child: Container(
//             margin: const EdgeInsets.all(4),
//             height: 60,
//             width: (MediaQuery.of(context).size.width * 0.13),
//             decoration: const BoxDecoration(
//                 color: Colors.deepOrange, shape: BoxShape.circle),
//             child: Center(
//               child: Text(barcodeID.toString()),
//             ),
//           ),
//         ));
//   }
// }
