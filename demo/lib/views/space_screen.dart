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
  bool _isSearching = false;
  String _searchQuery = '';

  /// Returns a list of all [ContainerRelationship]s.
  Future<List<CatalogedContainer>> catalogedContainers() async {
    return db.catalogedContainers.where().findAll();
  }

  @override
  Widget build(BuildContext context) {
    final body = StreamBuilder(
      stream: db.catalogedContainers.watchLazy(),
      builder: (context, snapshot) {
        return FutureBuilder<List<CatalogedContainer>>(
          future: catalogedContainers(),
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
              final items = snapshot.data!;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  const contentPadding = EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 16,
                  );

                  final item = items[index];
                  final containerType = dbUtils.getContainerType(item.typeUUID);
                  final name = Text(item.name.toString());
                  final description =
                      item.description != null && item.description!.isNotEmpty
                          ? Text(item.description.toString())
                          : null;
                  final leading = Icon(
                    containerType?.iconData.iconData,
                    color: containerType?.color.color,
                  );

                  return Card(
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.container,
                          arguments: item,
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            contentPadding: contentPadding,
                            leading: leading,
                            title: name,
                            subtitle: description,
                          ),
                          ListTile(
                            contentPadding: contentPadding,
                            leading: const Icon(Icons.qr_code),
                            title: Text(
                              item.barcodeUUID.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ),
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

    final appbar = AppBar(
      title: TextField(),
    );

    return Scaffold(
      appBar: AppBar(),
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
