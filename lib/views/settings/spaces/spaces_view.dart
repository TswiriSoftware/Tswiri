import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:tswiri_database/export.dart';
import 'package:tswiri_database/models/settings/global_settings.dart';
import 'package:tswiri_widgets/colors/colors.dart';

class SpacesView extends StatefulWidget {
  const SpacesView({Key? key}) : super(key: key);

  @override
  State<SpacesView> createState() => _SpacesViewState();
}

class _SpacesViewState extends State<SpacesView> {
  List<Directory> spaceDirectories = [];

  @override
  void initState() {
    _listofFiles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'Spaces',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      centerTitle: true,
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (Directory directory in spaceDirectories) _space(directory),
          _newSpace(),
        ],
      ),
    );
  }

  Widget _space(Directory directory) {
    return Card(
      child: ListTile(
        leading: directory.path == currentSpacePath
            ? const Icon(
                Icons.square,
                color: tswiriOrange,
              )
            : const Icon(Icons.square),
        title: Text(directory.path.split('/').last),
        trailing: directory.path == currentSpacePath
            ? const Text('Current Space')
            : ElevatedButton(
                onPressed: () async {
                  await swapSpace(directory);
                  _listofFiles();
                },
                child: Text(
                  'Swap',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
      ),
    );
  }

  final TextEditingController _textFieldController = TextEditingController();

  Widget _newSpace() {
    return Card(
      child: InkWell(
        onTap: () async {
          String? name = await showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Enter space name'),
              content: Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: background[500],
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        labelText: 'name',
                        labelStyle:
                            const TextStyle(fontSize: 15, color: Colors.white),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: tswiriOrange)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: tswiriOrange)),
                      ),
                      controller: _textFieldController,
                    ),
                  ),
                  const Text('_space'),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, null),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                        context,
                        _textFieldController.text.isNotEmpty
                            ? _textFieldController.text
                            : null);
                  },
                  child: const Text('OK'),
                ),
              ],
              actionsAlignment: MainAxisAlignment.spaceBetween,
            ),
          );

          setState(() {
            _textFieldController.clear();
          });

          if (name != null && mounted) {
            bool createdSpace = await createNewSpace(name);
            if (createdSpace = true) {
              _listofFiles();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Already Exisits',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              );
            }
          }
        },
        child: const ListTile(
          leading: Icon(Icons.new_label_sharp),
          title: Text('new space'),
        ),
      ),
    );
  }

  // Make New Function
  void _listofFiles() async {
    Directory directory = (await getApplicationSupportDirectory());
    setState(() {
      spaceDirectories.clear();
      for (var element in directory.listSync()) {
        if (element is Directory) spaceDirectories.add(element);
      }
    });
  }
}
