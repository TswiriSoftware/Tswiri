import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar/container_isar/container_isar.dart';
import 'package:isar/isar.dart';

import '../../sunbirdViews/containerSystem/functions/isar_functions.dart';
import '../basic_outline_containers/custom_outline_container.dart';
import '../basic_outline_containers/light_container.dart';

///Used once the container exists.
class ContainerNameWidget extends StatefulWidget {
  const ContainerNameWidget({
    Key? key,
    required this.containerUID,
    required this.database,
  }) : super(key: key);

  final String containerUID;
  final Isar database;

  @override
  State<ContainerNameWidget> createState() => _ContainerNameWidgetState();
}

class _ContainerNameWidgetState extends State<ContainerNameWidget> {
  final TextEditingController nameController = TextEditingController();
  int? id;
  String? name;
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
    name = database!.containerEntrys.getSync(id!)?.name ?? widget.containerUID;
    nameController.text = name!;

    //Container Outline Color.
    containerTypeColor = getContainerTypeColor(database: database!, id: id!);

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
                      database!.writeTxnSync((isar) {
                        ContainerEntry? containerEntry =
                            isar.containerEntrys.getSync(id!);
                        containerEntry!.name = nameController.text;
                        isar.containerEntrys.putSync(containerEntry);
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
