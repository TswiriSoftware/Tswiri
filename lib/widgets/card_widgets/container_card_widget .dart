import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar_database/container_relationship/container_relationship.dart';
import 'package:flutter_google_ml_kit/isar_database/container_type/container_type.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/custom_outline_container.dart';
import 'package:isar/isar.dart';

import '../../isar_database/container/container_isar.dart';
import '../basic_outline_containers/light_container.dart';

///This card is for displaying containers
class ContainerCardWidget extends StatelessWidget {
  const ContainerCardWidget({
    Key? key,
    required this.containerEntry,
    required this.database,
  }) : super(key: key);

  final ContainerEntry containerEntry;
  final Isar database;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        //Get outline color.
        Color color = Color(int.parse(database.containerTypes
                .filter()
                .containerTypeMatches(containerEntry.containerType)
                .findFirstSync()!
                .containerColor))
            .withOpacity(1);

        String numberOfChildren = database.containerRelationships
            .filter()
            .parentUIDMatches(containerEntry.containerUID)
            .findAllSync()
            .length
            .toString();

        return LightContainer(
            margin: 2.5,
            padding: 2.5,
            child: CustomOutlineContainer(
              outlineColor: color,
              borderWidth: 1.5,
              padding: 8,
              margin: 2.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Name: ',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        containerEntry.name ?? containerEntry.containerUID,
                        style: TextStyle(fontSize: 18, color: color),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Description: ',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Text(
                        containerEntry.description ?? '',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Children: ',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Text(
                        numberOfChildren,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  Text(
                    'UID: ${containerEntry.containerUID}',
                    style: const TextStyle(
                      fontSize: 8,
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }
}

// class ContainerCardWidget extends StatefulWidget {
//   const ContainerCardWidget({
//     Key? key,
//     required this.database,
//     this.containerEntry,
//     this.containerUID,
//   }) : super(key: key);

//   final Isar database;
//   final String? containerUID;
//   final ContainerEntry? containerEntry;

//   @override
//   State<ContainerCardWidget> createState() => _ContainerCardWidgetState();
// }

// class _ContainerCardWidgetState extends State<ContainerCardWidget> {
//   ContainerEntry? containerEntry;
//   Color? color;

//   @override
//   void initState() {
//     //Get containerEntry
//     containerEntry = widget.containerEntry;

//     //If it wasnt passed in.
//     containerEntry ??= widget.database.containerEntrys
//         .filter()
//         .containerUIDMatches(widget.containerUID!)
//         .findFirstSync();

//     //Get outline color.
//     color = Color(int.parse(widget.database.containerTypes
//             .filter()
//             .containerTypeMatches(containerEntry!.containerType)
//             .findFirstSync()!
//             .containerColor))
//         .withOpacity(1);

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Builder(
//       builder: (context) {
//         return LightContainer(
//             margin: 2.5,
//             padding: 2.5,
//             child: CustomOutlineContainer(
//               outlineColor: color!,
//               borderWidth: 1.5,
//               padding: 8,
//               margin: 2.5,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         'Name: ',
//                         style: Theme.of(context).textTheme.labelLarge,
//                       ),
//                       Text(
//                         containerEntry!.name ?? containerEntry!.containerUID,
//                         style: TextStyle(fontSize: 18, color: color),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         'Description: ',
//                         style: Theme.of(context).textTheme.labelMedium,
//                       ),
//                       Text(
//                         containerEntry!.description ?? '',
//                         style: Theme.of(context).textTheme.labelMedium,
//                       ),
//                     ],
//                   ),
//                   Text(
//                     'UID: ${containerEntry!.containerUID}',
//                     style: const TextStyle(
//                       fontSize: 8,
//                     ),
//                   )
//                 ],
//               ),
//             ));
//       },
//     );
//   }
// }
