import 'package:flutter/material.dart';

import '../../../isar_database/container_entry/container_entry.dart';
import '../../../isar_database/functions/isar_functions.dart';
import '../../basic_outline_containers/custom_outline_container.dart';
import '../../basic_outline_containers/light_container.dart';

class ContainerDescriptionEditWidget extends StatefulWidget {
  const ContainerDescriptionEditWidget({
    Key? key,
    required this.containerUID,
  }) : super(key: key);
  final String containerUID;

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

  @override
  void initState() {
    //database.

    //Container ID.
    id = getContainerID(
        containerEntrys: isarDatabase!.containerEntrys,
        containerUID: widget.containerUID);

    //Container Name.
    description = isarDatabase!.containerEntrys.getSync(id!)?.description;
    descriptionController.text = description ?? '';

    //Container Outline Color.
    containerTypeColor =
        getContainerTypeColor(database: isarDatabase!, id: id!);

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
                      isarDatabase!.writeTxnSync((isar) {
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
