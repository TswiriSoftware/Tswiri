import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar_database/container_entry/container_entry.dart';
import 'package:isar/isar.dart';

import '../../../isar_database/functions/isar_functions.dart';
import '../../basic_outline_containers/custom_outline_container.dart';
import '../../basic_outline_containers/light_container.dart';

///Used once the container exists.
class ContainerNameEditWidget extends StatefulWidget {
  const ContainerNameEditWidget({
    Key? key,
    required this.containerEntry,
  }) : super(key: key);

  final ContainerEntry containerEntry;

  @override
  State<ContainerNameEditWidget> createState() =>
      _ContainerNameEditWidgetState();
}

class _ContainerNameEditWidgetState extends State<ContainerNameEditWidget> {
  final TextEditingController nameController = TextEditingController();
  int? id;
  String? name;
  Color? containerTypeColor;
  Color? displayColor;
  ContainerEntry? containerEntry;

  @override
  void initState() {
    //database.
    containerEntry = isarDatabase!.containerEntrys
        .filter()
        .containerUIDMatches(widget.containerEntry.containerUID)
        .findFirstSync();

    //Container Name.
    name = containerEntry?.name ?? containerEntry!.containerUID;
    nameController.text = name!;

    //Container Outline Color.
    containerTypeColor =
        getContainerColor(containerUID: widget.containerEntry.containerUID);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LightContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Builder(builder: (context) {
              if (nameController.text.isEmpty) {
                displayColor = Colors.white60;
              } else {
                displayColor = containerTypeColor!;
              }

              return CustomOutlineContainer(
                outlineColor: displayColor!,
                padding: 0,
                margin: 0,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 5, top: 0),
                  child: TextFormField(
                    controller: nameController,
                    autovalidateMode: AutovalidateMode.always,
                    style: Theme.of(context).textTheme.titleSmall,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      icon: Builder(
                        builder: (context) {
                          if (nameController.text.isNotEmpty) {
                            return Icon(
                              Icons.hexagon_rounded,
                              color: displayColor!,
                            );
                          }
                          return const Icon(Icons.hexagon_rounded);
                        },
                      ),
                      hintText: 'Name',
                      labelText: 'Container Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {});
                      //Update name.
                      isarDatabase!.writeTxnSync((isar) {
                        containerEntry!.name = nameController.text;
                        isar.containerEntrys.putSync(containerEntry!);
                      });
                    },
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
