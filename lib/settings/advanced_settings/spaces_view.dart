import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tswiri_database/functions/isar/isar_functions.dart';
import 'package:tswiri_database/tswiri_database.dart';
import 'package:tswiri_theme/widgets/cards/outlined_card.dart';
import 'package:tswiri_database/functions/general/get_directory_name.dart';

class SpacesView extends StatefulWidget {
  const SpacesView({super.key});

  @override
  State<SpacesView> createState() => _SpacesViewState();
}

class _SpacesViewState extends State<SpacesView> {
  Future<List<Directory>> spaceDirectories = getSpacesDirectories();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _floatingActionButton(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text('Spaces'),
      elevation: 10,
    );
  }

  Widget _body() {
    return FutureBuilder<List<Directory>>(
      future: spaceDirectories,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          List<Directory> directories = snapshot.data!;
          Directory currentDirectory = spaceDirectory!;
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemCount: directories.length,
            itemBuilder: (context, index) {
              if (directories[index].path == currentDirectory.path) {
                return selectedSpaceTile(directories[index]);
              } else {
                return deselectedSpaceTile(directories[index]);
              }
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  FloatingActionButton _floatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: () async {
        String? newSpaceName = await _spaceNameDialog(context);
        if (newSpaceName != null) {
          newSpaceName.trim();
          if (newSpaceName.isNotEmpty) {
            bool createdSpace = await createNewSpace(newSpaceName);
            if (createdSpace) {
              setState(() {
                spaceDirectories = getSpacesDirectories();
                _controller.clear();
              });
            } else {
              if (mounted) {
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
          }
        }
      },
      label: const Text('New Space'),
      icon: const Icon(Icons.add_rounded),
    );
  }

  Card deselectedSpaceTile(Directory directory) {
    return Card(
      elevation: 10,
      child: ListTile(
        title: Text(
          getDirectoryName(directory),
        ),
        trailing: OutlinedButton(
          onPressed: () async {
            await swapSpace(directory);
            setState(() {
              spaceDirectories = getSpacesDirectories();
            });
          },
          child: const Text('Switch'),
        ),
      ),
    );
  }

  Widget selectedSpaceTile(Directory directory) {
    return OutlinedCard(
      child: ListTile(
        title: Text(
          getDirectoryName(directory),
        ),
        trailing: const Icon(Icons.circle),
      ),
    );
  }

  Future<String?> _spaceNameDialog(BuildContext context) {
    return showDialog<String?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('New Space'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Pick a name for your new space',
              ),
              Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: _controller,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Text('_space')
                ],
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(),
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop(
                  _controller.text,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
