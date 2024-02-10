import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:tswiri/providers.dart';
import 'package:tswiri/routes.dart';
import 'package:tswiri/views/abstract_screen.dart';
import 'package:tswiri_database/collections/collections_export.dart';

class SpaceScreen extends ConsumerStatefulWidget {
  const SpaceScreen({super.key});

  @override
  ConsumerState<SpaceScreen> createState() => _AddScreenState();
}

class _AddScreenState extends AbstractScreen<SpaceScreen> {
  /// Returns a list of all [ContainerRelationship]s.
  Future<List<ContainerRelationship>> containerRelationships() async {
    return isar.containerRelationships.where().findAll();
  }

  @override
  Widget build(BuildContext context) {
    final body = StreamBuilder(
      stream: isar.containerRelationships.watchLazy(),
      builder: (context, snapshot) {
        return FutureBuilder<List<ContainerRelationship>>(
          future: containerRelationships(),
          initialData: null,
          builder: (context, snapshot) {
            // If there is an error, display a message on the screen.
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            // If the snapshot is still loading, display a loading indicator.
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            // If there is data, display a list of items.
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Item $index'),
                  );
                },
              );
            } else {
              // If there is no data, display a message on the screen.
              return const Center(
                child: Text('No Containers found'),
              );
            }
          },
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Space'),
      ),
      body: body,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, Routes.createContainer);
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Container'),
      ),
    );
  }
}
