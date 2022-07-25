import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sunbird_2/globals/globals_export.dart';
import 'package:sunbird_2/isar/isar_database.dart';
import 'package:sunbird_2/views/containers/barcode_scanner/single_scanner_view.dart';
import 'package:sunbird_2/views/containers/container_view/container_view.dart';
import 'package:sunbird_2/views/containers/containers_view/container_search_controller.dart';
import 'package:sunbird_2/views/containers/new_container_view/new_container_view.dart';
import 'package:sunbird_2/widgets/search_bar/search_bar.dart';

class ContainersView extends StatefulWidget {
  const ContainersView({
    Key? key,
    required this.isSearching,
  }) : super(key: key);
  final void Function(bool) isSearching;
  @override
  State<ContainersView> createState() => _ContainersViewState();
}

///Container Filters
List<String> containerFilters = ['Area', 'Drawer', 'Shelf', 'Box'];

class _ContainersViewState extends State<ContainersView> {
  final ContainerSearchController _containerSearch =
      ContainerSearchController();

  bool isSearching = false;
  bool isEditing = false;

  List<CatalogedContainer> selectedContainers = [];

  @override
  void initState() {
    _containerSearch.filterContainerEntries(
      enteredKeyWord: null,
      containerFilters: containerFilters,
    );

    log(isar!.containerRelationships.where().findAllSync().toString());

    // isar!.writeTxnSync((isar) => isar.containerRelationships.clearSync());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isSearching
          ? _searchBar()
          : isEditing
              ? _editBar()
              : _titleBar(),
      body: _body(),
    );
  }

  AppBar _titleBar() {
    return AppBar(
      title: Text(
        'Containers',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () async {
            String? barcodeUID = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SingleBarcodeScannerView(),
              ),
            );

            if (barcodeUID != null) {
              CatalogedContainer? catalogedContainer = isar!.catalogedContainers
                  .filter()
                  .barcodeUIDMatches(barcodeUID)
                  .findFirstSync();

              if (catalogedContainer != null && mounted) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        ContainerView(catalogedContainer: catalogedContainer),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'No Linked Container',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }
          },
          icon: const Icon(
            Icons.qr_code_2_sharp,
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              isSearching = true;
              widget.isSearching(isSearching);
            });
          },
          icon: const Icon(
            Icons.search_sharp,
          ),
        ),
      ],
      leading: IconButton(
        onPressed: () {
          setState(() {
            isEditing = true;
            widget.isSearching(isEditing);
          });
        },
        icon: const Icon(
          Icons.edit_sharp,
        ),
      ),
    );
  }

  PreferredSize _editBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight + 100),
      child: AppBar(
        title: Text(
          '${selectedContainers.length}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        leading: Row(
          children: [
            IconButton(
              onPressed: () {
                deleteMultipleContainers(selectedContainers);
                setState(() {
                  _containerSearch.filterContainerEntries(
                    enteredKeyWord: null,
                    containerFilters: containerFilters,
                  );
                  selectedContainers.clear();
                });
              },
              icon: const Icon(
                Icons.delete_sharp,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (selectedContainers.isEmpty) {
                  selectedContainers.addAll(_containerSearch.searchResults);
                } else {
                  selectedContainers.clear();
                }
              });
            },
            icon: const Icon(
              Icons.select_all_sharp,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                isEditing = false;
                selectedContainers.clear();
                widget.isSearching(isEditing);
              });
            },
            icon: const Icon(
              Icons.close_sharp,
            ),
          ),
        ],
        bottom: _searchBar(),
      ),
    );
  }

  PreferredSize _searchBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight + 50),
      child: SearchTextField(
        filters: containerFilters,
        filterTypes: _containerSearch.filterTypes(),
        filterChange: (enteredKeyWord) {
          setState(() {
            _containerSearch.filterContainerEntries(
              enteredKeyWord: enteredKeyWord,
              containerFilters: containerFilters,
            );
            selectedContainers.clear();
          });
        },
        onCancel: () {
          setState(() {
            isSearching = false;
            widget.isSearching(isSearching);
            _containerSearch.filterContainerEntries(
              enteredKeyWord: null,
              containerFilters: containerFilters,
            );
            selectedContainers.clear();
          });
        },
        onChanged: (enteredKeyWord) {
          setState(() {
            _containerSearch.filterContainerEntries(
              enteredKeyWord: enteredKeyWord,
              containerFilters: containerFilters,
            );
            selectedContainers.clear();
          });
        },
        onSubmitted: (enteredKeyWord) {
          if (enteredKeyWord.isEmpty) {
            setState(() {
              isSearching = false;
              widget.isSearching(isSearching);
            });
          } else {
            setState(() {
              _containerSearch.filterContainerEntries(
                enteredKeyWord: enteredKeyWord,
                containerFilters: containerFilters,
              );
              selectedContainers.clear();
            });
          }
        },
      ),
    );
  }

  Widget _body() {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 150),
      itemCount: _containerSearch.searchResults.length + 1,
      itemBuilder: (context, index) {
        if (index == 0 && !isSearching && !isEditing) {
          return _newContainerCard();
        } else if (index > 0) {
          return _containerCard(_containerSearch.searchResults[index - 1]);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _containerCard(CatalogedContainer catalogedContainer) {
    return InkWell(
      onTap: () async {
        onContainerSelect(catalogedContainer);
      },
      onLongPress: () {
        setState(() {
          isEditing = true;
          if (!selectedContainers.contains(catalogedContainer)) {
            selectedContainers.add(catalogedContainer);
          }
        });
        widget.isSearching(isEditing);
      },
      child: Card(
        shape: selectedContainers.contains(catalogedContainer)
            ? RoundedRectangleBorder(
                side: const BorderSide(
                  color: sunbirdOrange,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(10),
              )
            : null,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    catalogedContainer.name ?? catalogedContainer.containerUID,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Icon(
                    getContainerTypeIcon(catalogedContainer.containerTypeID),
                  ),
                ],
              ),
              Divider(
                color: colorModeEnabled
                    ? isar!.containerTypes
                        .getSync(catalogedContainer.containerTypeID)!
                        .containerColor
                    : null,
                thickness: 1,
              ),
              Text(
                'Description: ',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                catalogedContainer.description ?? '-',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const Divider(),
              Text(
                'Barcode: ',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                catalogedContainer.barcodeUID ?? 'err',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _newContainerCard() {
    return InkWell(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NewContainerView(),
          ),
        );
        setState(() {
          _containerSearch.filterContainerEntries(
            enteredKeyWord: null,
            containerFilters: containerFilters,
          );
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: sunbirdOrange,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    '+',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    '(New Container)',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onContainerSelect(CatalogedContainer catalogedContainer) async {
    if (isEditing) {
      if (selectedContainers.contains(catalogedContainer)) {
        setState(() {
          selectedContainers.remove(catalogedContainer);
        });
      } else {
        setState(() {
          selectedContainers.add(catalogedContainer);
        });
      }
    } else {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ContainerView(
            catalogedContainer: catalogedContainer,
          ),
        ),
      );

      setState(() {
        _containerSearch.filterContainerEntries(
          enteredKeyWord: null,
          containerFilters: containerFilters,
        );
      });
    }
  }
}
