import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_google_ml_kit/extentions/capitalize_first_character.dart';
import 'package:flutter_google_ml_kit/functions/keyboard_functions/hide_keyboard.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_type/container_type.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';

import 'package:isar/isar.dart';

class NewContainerTypeView extends StatefulWidget {
  const NewContainerTypeView({Key? key}) : super(key: key);

  @override
  State<NewContainerTypeView> createState() => _NewContainerTypeViewState();
}

class _NewContainerTypeViewState extends State<NewContainerTypeView> {
  String? newContainerType;
  Color? newContainerColor;
  Color pickerColor = Colors.deepOrange;
  Color currentColor = Colors.deepOrange;
  bool moveable = false;
  bool markerToChildren = false;
  bool canContainSelf = false;

  late List<ContainerType> containerTypes;
  List<String> canContainTypes = [];
  bool showCanContain = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    containerTypes = isarDatabase!.containerTypes.where().findAllSync();
    nameController.text = '';
    descriptionController.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        hideKeyboard(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            newContainerType ?? 'New Container Type',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: newContainerColor ?? Colors.deepOrange,
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              createType();
            },
            backgroundColor: newContainerColor ?? Colors.deepOrange,
            label: Text(
              'Create',
              style: Theme.of(context).textTheme.labelMedium,
            )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //INFO.
              //_infoTile(),
              _info(),
              //CAN CONTAIN.
              //_canContainTile(),
              _canContain(),
              //OPTIONS.
              _options(),
              //COLOR.
              _color(),
              //BOTTOM SPACE.
              _bottomSpace(),
            ],
          ),
        ),
      ),
    );
  }

  ///INFO///
  Widget _info() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      color: Colors.white12,
      elevation: 5,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: currentColor, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Text(
                'Type Info',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            _dividerHeavy(),
            _nameTextField(),
            _descriptionTextField(),
          ],
        ),
      ),
    );
  }

  Widget _nameTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: TextField(
        controller: nameController,
        onChanged: (value) {
          if (value.isNotEmpty) {
            setState(() {});
          } else {
            setState(() {});
          }
        },
        style: const TextStyle(fontSize: 18),
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white10,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          labelText: 'Name',
          labelStyle: const TextStyle(fontSize: 15, color: Colors.white),
          border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: newContainerColor ?? Colors.deepOrange)),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: newContainerColor ?? Colors.deepOrange)),
        ),
      ),
    );
  }

  Widget _descriptionTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: TextField(
        controller: descriptionController,
        onChanged: (value) {
          if (value.isNotEmpty) {
            setState(() {});
          } else {
            setState(() {});
          }
        },
        maxLines: 5,
        style: const TextStyle(fontSize: 16),
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white10,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          labelText: 'Description',
          labelStyle: const TextStyle(fontSize: 15, color: Colors.white),
          border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: newContainerColor ?? Colors.deepOrange)),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: newContainerColor ?? Colors.deepOrange)),
        ),
      ),
    );
  }

  ///CAN CONTAIN///

  Widget _canContain() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      color: Colors.white12,
      elevation: 5,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: currentColor, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Text(
                'Can Contain',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            _dividerHeavy(),
            _canContainListBuilder(),
          ],
        ),
      ),
    );
  }

  Widget _canContainListBuilder() {
    return Column(
      children: containerTypes.map((e) => canContainCard(e)).toList(),
    );
  }

  Widget canContainCard(ContainerType canContainType) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      color: Colors.white12,
      elevation: 5,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        side: BorderSide(
            color:
                Color(int.parse(canContainType.containerColor)).withOpacity(1),
            width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  canContainType.containerType.capitalize(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            Checkbox(
              value: canContainTypes.contains(canContainType.containerType),
              fillColor: MaterialStateProperty.all(
                  Color(int.parse(canContainType.containerColor))
                      .withOpacity(1)),
              onChanged: (value) {
                _onSelectedContainer(value!, canContainType.containerType);
              },
            ),
          ],
        ),
      ),
    );
  }

  ///OPTIONS///

  Widget _options() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      color: Colors.white12,
      elevation: 5,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: currentColor, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Text(
                'Options',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            _dividerHeavy(),
            _moveable(),
            _isMarker(),
          ],
        ),
      ),
    );
  }

  Widget _moveable() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      color: Colors.white12,
      elevation: 5,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        side: BorderSide(
            color: newContainerColor ?? Colors.deepOrange, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Movable',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Checkbox(
              value: moveable,
              fillColor: MaterialStateProperty.all(
                  newContainerColor ?? Colors.deepOrange),
              onChanged: (value) {
                moveable = value!;

                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _isMarker() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      color: Colors.white12,
      elevation: 5,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        side: BorderSide(
            color: newContainerColor ?? Colors.deepOrange, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Marker to Children',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Checkbox(
              value: markerToChildren,
              fillColor: MaterialStateProperty.all(
                  newContainerColor ?? Colors.deepOrange),
              onChanged: (value) {
                markerToChildren = value!;

                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }

  ///COLOR///

  Widget _color() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      color: Colors.white12,
      elevation: 5,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        side: BorderSide(
            color: newContainerColor ?? Colors.deepOrange, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Text(
                'Color',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            _dividerHeavy(),
            _changeColorButton(),
          ],
        ),
      ),
    );
  }

  Widget _changeColorButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () async {
          Color? newColor = await showColorDialog();
          if (newColor != null) {
            newContainerColor = newColor;

            setState(() {});
          }
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(color: currentColor, width: 1),
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
              color: currentColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Change',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const Icon(Icons.color_lens)
            ],
          ),
        ),
      ),
    );
  }

  Future showColorDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: changeColor,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, currentColor);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Change',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  ///MISC///

  Widget _dividerHeavy() {
    return Divider(
      color: newContainerColor ?? Colors.deepOrange,
      thickness: 1,
      height: 10,
    );
  }

  Widget _bottomSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 10,
    );
  }

  SnackBar snackBar(String error) {
    return SnackBar(
      duration: const Duration(milliseconds: 500),
      content: Text(error),
    );
  }

  ///FUNCTIONS///

  void _onSelectedContainer(bool selected, String dataName) {
    if (selected == true) {
      setState(() {
        canContainTypes.add(dataName);
      });
    } else {
      setState(() {
        canContainTypes.remove(dataName);
      });
    }
  }

  void changeColor(Color color) {
    setState(() {
      newContainerColor = color;
      pickerColor = color;
      currentColor = color;
    });
  }

  void createType() {
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar('Please enter a name'));
    } else if (canContainTypes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar(
          'Please select at least one Can Contain (other than self).'));
    } else if (newContainerColor == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar('Please select a custom color.'));
    } else {
      if (canContainSelf) {
        canContainTypes.add(nameController.text.toLowerCase());
      }
      ContainerType newContainerType = ContainerType()
        ..containerType = nameController.text.toLowerCase()
        ..containerDescription = descriptionController.text
        ..containerColor = newContainerColor!.value.toString()
        ..moveable = moveable
        ..markerToChilren = markerToChildren
        ..canContain = canContainTypes;

      if (isarDatabase!.containerTypes
              .filter()
              .containerTypeMatches(nameController.text.toLowerCase())
              .findFirstSync() ==
          null) {
        isarDatabase!.writeTxnSync(
            (isar) => isar.containerTypes.putSync(newContainerType));
        Navigator.pop(context);
        //Write to isar
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar('Type already exists.'));
      }
    }
  }
}
