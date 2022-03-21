import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import '../../../isar_database/container/container_isar.dart';
import '../../../isar_database/functions/isar_functions.dart';
import '../../basic_outline_containers/custom_outline_container.dart';
import '../../basic_outline_containers/light_container.dart';

class ContainerDescriptionEditWidget extends StatefulWidget {
  const ContainerDescriptionEditWidget({
    Key? key,
    required this.containerUID,
    required this.database,
  }) : super(key: key);
  final String containerUID;
  final Isar database;

  @override
  State<ContainerDescriptionEditWidget> createState() =>
      _ContainerDescriptionEditWidgetState();
}

class _ContainerDescriptionEditWidgetState
    extends State<ContainerDescriptionEditWidget> {
  final TextEditingController descriptionController = TextEditingController();
  int? id;
  String? description;
  Color? containerTypeColor;
  Color? displayColor;
  ContainerEntry? containerEntry;
  Isar? database;

  @override
  void initState() {
    //database.
    database = widget.database;

    //Container ID.
    id = getContainerID(
        containerEntrys: database!.containerEntrys,
        containerUID: widget.containerUID);

    //Container Name.
    description = database!.containerEntrys.getSync(id!)?.description;
    descriptionController.text = description ?? '';

    //Container Outline Color.
    containerTypeColor = getContainerTypeColor(database: database!, id: id!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LightContainer(
      margin: 5,
      padding: 5,
      child: Row(
        children: [
          Expanded(
            child: Builder(builder: (context) {
              if (descriptionController.text.isEmpty) {
                displayColor = Colors.white60;
              } else {
                displayColor = containerTypeColor!;
              }

              return CustomOutlineContainer(
                outlineColor: displayColor!,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 5, top: 0),
                  child: TextFormField(
                    controller: descriptionController,
                    style: Theme.of(context).textTheme.titleSmall,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      icon: Builder(builder: (context) {
                        if (descriptionController.text.isNotEmpty) {
                          return Icon(
                            Icons.hexagon_rounded,
                            color: displayColor,
                          );
                        }
                        return const Icon(Icons.hexagon_rounded);
                      }),
                      hintText: 'Description',
                      labelText: 'Container description',
                    ),
                    onChanged: (value) {
                      database!.writeTxnSync((isar) {
                        ContainerEntry containerEntry =
                            isar.containerEntrys.getSync(id!)!;
                        containerEntry.description = descriptionController.text;
                        isar.containerEntrys.putSync(containerEntry);
                      });
                    },
                  ),
                ),
                margin: 0,
                padding: 0,
              );
            }),
          ),
        ],
      ),
    );
  }
}
