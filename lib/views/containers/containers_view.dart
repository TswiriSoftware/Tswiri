import 'package:tswiri/views/containers/container/container_view.dart';
import 'package:tswiri/views/containers/new_container/new_container_view.dart';
import 'package:tswiri/views/ml_kit/barcode_scanner/single_scanner_view.dart';
import 'package:flutter/material.dart';
import 'package:tswiri_database/export.dart';
import 'package:tswiri_database/functions/isar/delete_functions.dart';
import 'package:tswiri_database/models/containers/container_search_controller.dart';
import 'package:tswiri_database/models/settings/global_settings.dart';
import 'package:tswiri_database/widgets/containers/container_card.dart';
import 'package:tswiri_widgets/colors/colors.dart';
import 'package:tswiri_widgets/colors/colors_m3.dart';
import 'package:tswiri_widgets/widgets/general/search_text_field.dart';

class ContainersView extends StatefulWidget {
  const ContainersView({
    Key? key,
    required this.isSearching,
  }) : super(key: key);
  final void Function(bool) isSearching;
  @override
  State<ContainersView> createState() => _ContainersViewState();
}

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 75,
      child: Scaffold(
        appBar: isSearching
            ? _searchBar()
            : isEditing
                ? _editBar()
                : _titleBar(),
        body: _body(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: newContainer(),
      ),
    );
  }

  FloatingActionButton newContainer() {
    return FloatingActionButton(
      backgroundColor: secondary,
      onPressed: () async {
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
      child: Icon(
        Icons.add,
      ),
    );
  }

  AppBar _titleBar() {
    return AppBar(
      // title: Text(
      //   'Containers',
      //   style: Theme.of(context).textTheme.titleLarge,
      // ),
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
        backgroundColor: background[400]!,
        defaultFilterColor: tswiriOrange,
        filterChipColorMap: null,
      ),
    );
  }

  Widget _body() {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 150),
      itemCount: _containerSearch.searchResults.length,
      itemBuilder: (context, index) {
        // if (index == 0 && !isSearching && !isEditing) {
        //   // return _newContainerCard();
        //   return NewContainerCard(
        //     onTap: () async {
        //   await Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => const NewContainerView(),
        //     ),
        //   );
        //   setState(() {
        //     _containerSearch.filterContainerEntries(
        //       enteredKeyWord: null,
        //       containerFilters: containerFilters,
        //     );
        //   });
        // },
        //   );
        // } else if (index > 0) {
        CatalogedContainer catalogedContainer =
            _containerSearch.searchResults[index];
        return ContainerCard(
          catalogedContainer: catalogedContainer,
          isSelected: selectedContainers.contains(catalogedContainer),
          onTap: () {
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
          borderColor: tertiary,
        );
        // } else {
        //   return const SizedBox.shrink();
        // }
      },
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
