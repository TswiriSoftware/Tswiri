import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:tswiri/providers.dart';
import 'package:tswiri/views/abstract_screen.dart';
import 'package:tswiri_database/collections/collections_export.dart';

class CreateContainerScreen extends ConsumerStatefulWidget {
  final CatalogedContainer? _parentContainer;

  const CreateContainerScreen({
    required CatalogedContainer? parentContainer,
    super.key,
  }) : _parentContainer = parentContainer;

  @override
  AbstractScreen<CreateContainerScreen> createState() => _CreateContainerScreenState();
}

class _CreateContainerScreenState extends AbstractScreen<CreateContainerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Container'),
      ),
      body: Column(
        children: [
          const ContainerTypeWrapWidget(),
        ],
      ),
    );
  }
}

class ContainerTypeWrapWidget extends ConsumerWidget {
  const ContainerTypeWrapWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.read(spaceProvider).db?.containerTypes.where().findAll(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return Wrap(
            alignment: WrapAlignment.center,
            children: snapshot.data!.map(
              (type) {
                return ChoiceChip(label: Text(type.name), selected: false);

                return Container(
                  margin: const EdgeInsets.all(8),
                  child: Text(type.name),
                );
              },
            ).toList(),
          );
        } else {
          return const Center(
            child: Text('No Container Types found'),
          );
        }
      },
    );
  }
}
