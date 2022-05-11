// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
// import 'package:flutter_google_ml_kit/global_values/global_colours.dart';
// import 'package:flutter_google_ml_kit/isar_database/container_entry/container_entry.dart';
// import 'package:flutter_google_ml_kit/objects/grid/container_relationship_object.dart';
// import 'package:flutter_google_ml_kit/objects/grid/grid.dart';
// import 'package:flutter_google_ml_kit/objects/grid/isolate_grid.dart';
// import 'package:flutter_google_ml_kit/sunbird_views/container_manager/container_view.dart';

// class GridVisualizerView extends StatefulWidget {
//   const GridVisualizerView({Key? key}) : super(key: key);

//   @override
//   State<GridVisualizerView> createState() => _GridVisualizerViewState();
// }

// class _GridVisualizerViewState extends State<GridVisualizerView> {
//   late Grid grid = Grid();
//   late List<ContainerEntry> higherContainers = grid.parents();

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: _refresh(),
//       appBar: _appBar(),
//       body: _body(),
//     );
//   }

//   ///APP BAR///

//   AppBar _appBar() {
//     return AppBar(
//       backgroundColor: sunbirdOrange,
//       elevation: 25,
//       centerTitle: true,
//       title: _title(),
//       shadowColor: Colors.black54,
//     );
//   }

//   Text _title() {
//     return Text(
//       'Tree Visualizer',
//       style: Theme.of(context).textTheme.titleMedium,
//     );
//   }

//   ///BODY///
//   Widget _body() {
//     return ListView.builder(
//       itemCount: higherContainers.length,
//       itemBuilder: (context, index) {
//         return highContainer(higherContainers[index]);
//       },
//     );
//   }

//   Widget highContainer(ContainerEntry containerEntry) {
//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//       color: Colors.white12,
//       elevation: 5,
//       shadowColor: Colors.black26,
//       shape: RoundedRectangleBorder(
//         side: const BorderSide(color: sunbirdOrange, width: 2),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 containerEntry.name ?? containerEntry.containerUID,
//                 style: Theme.of(context).textTheme.labelLarge,
//               ),
//             ),
//             Builder(builder: (context) {
//               ContainerRelationshipObject containerTree =
//                   ContainerRelationshipObject(parentContainer: containerEntry);
//               //log(containerTree.children.toString());
//               return ExpansionTile(
//                 expandedCrossAxisAlignment: CrossAxisAlignment.start,
//                 title: Text(
//                   'Decendants',
//                   style: Theme.of(context).textTheme.labelMedium,
//                 ),
//                 children: containerTree.children
//                     .map((e) => lowerContainerBuilder(e))
//                     .toList(),
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget lowerContainerBuilder(ContainerEntry containerEntry) {
//     return Builder(builder: (context) {
//       ContainerRelationshipObject containerTree =
//           ContainerRelationshipObject(parentContainer: containerEntry);
//       //log(containerTree.children.toString());
//       if (containerTree.children.isNotEmpty) {
//         return lowerContainer(containerTree);
//       } else {
//         return lowerContainerEnd(containerTree);
//       }
//     });
//   }

//   Widget lowerContainer(ContainerRelationshipObject containerTree) {
//     return Builder(builder: (context) {
//       Color color = getContainerColor(
//           containerUID: containerTree.parentContainer.containerUID);
//       return Card(
//         margin: const EdgeInsets.all(10),
//         color: Colors.white12,
//         elevation: 5,
//         shadowColor: Colors.black26,
//         shape: RoundedRectangleBorder(
//           side: BorderSide(color: color, width: 2),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: ExpansionTile(
//           title: Row(
//             children: [
//               Text(
//                 containerTree.parentContainer.name ??
//                     containerTree.parentContainer.containerUID,
//               ),
//               edit(containerTree.parentContainer),
//             ],
//           ),
//           children: containerTree.children
//               .map((e) => lowerContainerBuilder(e))
//               .toList(),
//         ),
//       );
//     });
//   }

//   Widget lowerContainerEnd(ContainerRelationshipObject containerTree) {
//     return Builder(builder: (context) {
//       Color color = getContainerColor(
//           containerUID: containerTree.parentContainer.containerUID);
//       return Card(
//         margin: const EdgeInsets.all(8),
//         color: Colors.white12,
//         elevation: 5,
//         shadowColor: Colors.black26,
//         shape: RoundedRectangleBorder(
//           side: BorderSide(color: color, width: 2),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Text(
//                   containerTree.parentContainer.name ??
//                       containerTree.parentContainer.containerUID,
//                   style: Theme.of(context).textTheme.labelMedium,
//                 ),
//                 edit(containerTree.parentContainer),
//               ],
//             )),
//       );
//     });
//   }

//   ///EDIT///
//   Widget edit(ContainerEntry containerEntry) {
//     return IconButton(
//       onPressed: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ContainerView(
//               containerEntry: containerEntry,
//             ),
//           ),
//         );
//       },
//       icon: const Icon(Icons.edit),
//     );
//   }

//   ///ACTIONS///
//   Widget _refresh() {
//     return FloatingActionButton(
//       onPressed: () {
//         log(Grid().positionalGrids.toString());
//       },
//       child: const Icon(Icons.refresh),
//     );
//   }
// }
