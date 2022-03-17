// import 'package:flutter/material.dart';
// import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';

// import '../../../widgets/custom_card_widget.dart';
// import '../barcode_selection_view.dart';

// ///Shows all barcode navigation tools.
// class BarcodeNavigationToolsView extends StatefulWidget {
//   const BarcodeNavigationToolsView({Key? key}) : super(key: key);

//   @override
//   _BarcodeNavigationToolsViewState createState() =>
//       _BarcodeNavigationToolsViewState();
// }

// class _BarcodeNavigationToolsViewState
//     extends State<BarcodeNavigationToolsView> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: limeGreenMuted,
//         title: const Text(
//           'Barcode Navigation Tools',
//           style: TextStyle(fontSize: 25),
//         ),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: Center(
//         child: GridView.count(
//           padding: const EdgeInsets.all(16),
//           mainAxisSpacing: 8,
//           crossAxisSpacing: 16,
//           crossAxisCount: 2,
//           // ignore: prefer_const_literals_to_create_immutables
//           children: [
//             const CustomCard(
//               'Barcode Navigator',
//               BarcodeSelectionView(),
//               Icons.camera,
//               featureCompleted: true,
//               tileColor: limeGreenMuted,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
