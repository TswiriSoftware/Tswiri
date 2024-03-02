import 'package:flutter/material.dart';
import 'package:tswiri/providers.dart';
import 'package:tswiri/routes.dart';
import 'package:tswiri/views/abstract_screen.dart';
import 'package:tswiri_database/collections/collections_export.dart';
import 'package:tswiri_database/utils.dart';

class ContainersScreen extends ConsumerStatefulWidget {
  const ContainersScreen({super.key});

  @override
  ConsumerState<ContainersScreen> createState() => _ContainersScreenState();
}

class _ContainersScreenState extends AbstractScreen<ContainersScreen> {
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
            if (snapshot.hasError) {
              // If there is an error, display a message on the screen.
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData) {
              // If the snapshot is still loading, display a loading indicator.
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.data!.isEmpty) {
              // If there is no data, display a message on the screen.
              return const Center(
                child: Text('No Containers found'),
              );
            } else {
              // If there is data, display a list of items.
              final items = snapshot.data!;

              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  final containerType = space.getContainerType(item.typeUUID);
                  final name = Text(item.name.toString());
                  final description =
                      item.description != null && item.description!.isNotEmpty
                          ? Text(item.description.toString())
                          : null;
                  final leading = Tooltip(
                    message: containerType?.name,
                    child: Icon(
                      containerType?.iconData.iconData,
                      color: containerType?.color.color,
                    ),
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
                            leading: leading,
                            title: name,
                            subtitle: description,
                          ),
                          ListTile(
                            leading: const Icon(Icons.qr_code),
                            title: Text(
                              item.barcodeUUID.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
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
      appBar: appbar,
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
