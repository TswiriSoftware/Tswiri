import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/extentions/capitalize_first_character.dart';
import 'package:flutter_google_ml_kit/isar_database/container_type/container_type.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_types/container_type_edit_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_types/new_container_type_view.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/custom_outline_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/light_container.dart';
import 'package:isar/isar.dart';

class ContainerTypeView extends StatefulWidget {
  const ContainerTypeView({Key? key}) : super(key: key);

  @override
  State<ContainerTypeView> createState() => _ContainerTypeViewState();
}

class _ContainerTypeViewState extends State<ContainerTypeView> {
  late List<ContainerType> containerTypes;

  List<ContainerType> selectedContainers = [];
  bool showCheckBox = false;

  @override
  void initState() {
    //Get all Container Types.
    containerTypes = isarDatabase!.containerTypes.where().findAllSync();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Container Types',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          Builder(builder: (context) {
            if (showCheckBox) {
              return IconButton(
                onPressed: () {
                  _deleteSelectedContainers();
                  selectedContainers = [];
                  setState(() {
                    showCheckBox = false;
                  });
                },
                icon: const Icon(Icons.delete),
              );
            } else {
              return Row();
            }
          })
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: addNewTypeButton(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _select(),
            _typeListBuilder(),
            _bottomSpace(),
          ],
        ),
      ),
    );
  }

  ///SELECT///
  Widget _select() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Hold to select',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  ///TYPES///

  Widget _typeListBuilder() {
    return Column(
      children: containerTypes.map((e) => containerType(e)).toList(),
    );
  }

  Widget containerType(ContainerType containerType) {
    return InkWell(
      onLongPress: () {
        showCheckBox = true;
        selectedContainers.add(containerType);
        setState(() {});
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        color: Colors.white12,
        elevation: 5,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: Color(int.parse(containerType.containerColor)),
              width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    containerType.containerType.toString().capitalize(),
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Builder(builder: (context) {
                    if (showCheckBox) {
                      return Checkbox(
                        value: selectedContainers.contains(containerType),
                        onChanged: (value) {
                          _onSelectedContainer(value!, containerType);
                        },
                        fillColor: MaterialStateProperty.all(
                          Color(int.parse(containerType.containerColor))
                              .withOpacity(1),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
                ],
              ),
              _dividerHeavy(),
              Text(
                'Description',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                containerType.containerDescription,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              _dividerLight(),
              Text(
                'Can Contain',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                containerType.canContain.toString(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              _dividerLight(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Options',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        'Movable: ' + containerType.moveable.toString(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        'Marker to Children: ' +
                            containerType.markerToChilren.toString(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  editButton(containerType),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget editButton(ContainerType containerType) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              Color(int.parse(containerType.containerColor)))),
      onPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ContainerTypeEditView(containerType: containerType),
          ),
        );
        setState(() {
          containerTypes = isarDatabase!.containerTypes.where().findAllSync();
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'edit',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const Icon(Icons.edit),
        ],
      ),
    );
  }

  Widget addNewTypeButton() {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NewContainerTypeView()),
        );
        setState(() {
          containerTypes = isarDatabase!.containerTypes.where().findAllSync();
        });
      },
    );
  }

  ///MISC///
  Widget _dividerHeavy() {
    return const Divider(
      color: Colors.white54,
      thickness: 1,
      height: 10,
    );
  }

  Widget _dividerLight() {
    return const Divider(
      color: Colors.white30,
      height: 10,
    );
  }

  Widget _bottomSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 10,
    );
  }

  ///FUNCTIONS///

  void _deleteSelectedContainers() {
    isarDatabase!.writeTxnSync((isar) => isar.containerTypes
        .deleteAllSync(selectedContainers.map((e) => e.id).toList()));

    setState(() {
      containerTypes = isarDatabase!.containerTypes.where().findAllSync();
    });
  }

  void _onSelectedContainer(bool selected, ContainerType dataName) {
    if (selected == true) {
      setState(() {
        selectedContainers.add(dataName);
      });
    } else {
      setState(() {
        selectedContainers.remove(dataName);
        if (selectedContainers.isEmpty) {
          showCheckBox = false;
        }
      });
    }
  }
}
