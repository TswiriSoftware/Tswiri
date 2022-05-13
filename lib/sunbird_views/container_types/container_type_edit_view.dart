import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/extentions/capitalize_first_character.dart';
import 'package:flutter_google_ml_kit/functions/keyboard_functions/hide_keyboard.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_type/container_type.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:isar/isar.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ContainerTypeEditView extends StatefulWidget {
  const ContainerTypeEditView({Key? key, required this.containerType})
      : super(key: key);

  final ContainerType containerType;
  @override
  State<ContainerTypeEditView> createState() => _ContainerTypeEditViewState();
}

class _ContainerTypeEditViewState extends State<ContainerTypeEditView> {
  late ContainerType containerType;
  late Color containerColor;
  late bool moveable;
  late bool markerToChildren;

  late List<ContainerType> containerTypes;
  List<String> canContainTypes = [];
  bool showCanContain = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  late Color pickerColor;
  late Color currentColor;

  @override
  void initState() {
    //Current Setup
    containerType = widget.containerType;
    containerColor =
        Color(int.parse(containerType.containerColor)).withOpacity(1);
    moveable = containerType.moveable;
    markerToChildren = containerType.markerToChilren;
    nameController.text = containerType.containerType.capitalize();
    descriptionController.text = containerType.containerDescription;

    pickerColor = containerColor;
    currentColor = containerColor;

    //Other types
    containerTypes = isarDatabase!.containerTypes.where().findAllSync();
    canContainTypes = containerType.canContain;

    //log(canContainTypes.toString());
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
            containerType.containerType.capitalize(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: containerColor,
          actions: [
            IconButton(
              onPressed: () {
                //Save changes
                saveChanges();
              },
              icon: const Icon(Icons.save),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //Info
              //_infoTile(),
              _info(),
              //CanContain.
              _canContain(),
              //Options.
              _options(),
              //Color.
              _color(),
              //Bottom Space
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
        side: BorderSide(
            color:
                Color(int.parse(containerType.containerColor)).withOpacity(0.8),
            width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
    );
  }

  Widget _nameTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
          border:
              OutlineInputBorder(borderSide: BorderSide(color: containerColor)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: containerColor)),
        ),
      ),
    );
  }

  Widget _descriptionTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
          border:
              OutlineInputBorder(borderSide: BorderSide(color: containerColor)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: containerColor)),
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
        side: BorderSide(
            color:
                Color(int.parse(containerType.containerColor)).withOpacity(0.8),
            width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(
              'Can Contain',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          _dividerHeavy(),
          _canContainListBuilder(),
        ],
      ),
    );
  }

  Widget _canContainListBuilder() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: containerTypes.map((e) => canContainCard(e)).toList(),
      ),
    );
  }

  Widget canContainCard(ContainerType canContainType) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      color: Colors.white12,
      elevation: 5,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        side: BorderSide(
            color: Color(int.parse(canContainType.containerColor)), width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
              fillColor: MaterialStateProperty.all(
                  Color(int.parse(canContainType.containerColor))
                      .withOpacity(1)),
              value: canContainTypes.contains(canContainType.containerType),
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
        side: BorderSide(
            color:
                Color(int.parse(containerType.containerColor)).withOpacity(0.8),
            width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
            color:
                Color(int.parse(containerType.containerColor)).withOpacity(0.8),
            width: 1.5),
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
              fillColor: MaterialStateProperty.all(containerColor),
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
            color:
                Color(int.parse(containerType.containerColor)).withOpacity(0.8),
            width: 1.5),
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
              fillColor: MaterialStateProperty.all(containerColor),
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
            color:
                Color(int.parse(containerType.containerColor)).withOpacity(0.8),
            width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
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
            containerColor = newColor;
            //log(containerColor.toString());
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
              child: Text(
                'change',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ],
        );
      },
    );
  }

  ///MISC///

  Widget _dividerHeavy() {
    return Divider(
      color: containerColor,
      thickness: 1,
      indent: 5,
      height: 10,
    );
  }

  Widget _bottomSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 10,
    );
  }

  ///FUNCTIONS///

  void saveChanges() {
    if (nameController.text.isEmpty) {
      //If no name is entered revert to previous name;
      nameController.text = containerType.containerType;
    }

    if (descriptionController.text.isEmpty) {
      //If no description is entered revert to previous description;
      descriptionController.text = containerType.containerDescription;
    }

    // log(containerColor.toString());
    isarDatabase!.writeTxnSync((isar) => isar.containerTypes.putSync(
        ContainerType()
          ..id = containerType.id
          ..containerType = nameController.text.toLowerCase()
          ..containerDescription = descriptionController.text
          ..canContain = canContainTypes
          ..containerColor = containerColor.value.toString()
          ..moveable = moveable
          ..markerToChilren = markerToChildren,
        replaceOnConflict: true));

    // log(containerType.toString());
    Navigator.pop(context);
  }

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
      containerColor = color;
      pickerColor = color;
      currentColor = color;
    });
  }
}
