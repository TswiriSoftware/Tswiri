import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/barcodeTools/hide_keyboard.dart';
import 'package:flutter_google_ml_kit/functions/mathfunctions/round_to_double.dart';
import 'package:flutter_google_ml_kit/isar_database/barcode_property/barcode_property.dart';
import 'package:flutter_google_ml_kit/isar_database/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcode_manager/objects/barcode_manager_object.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_manager/add_container_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_manager/container_view.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/custom_outline_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/dark_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/light_container.dart';
import 'package:isar/isar.dart';

class BarcodeManagerView extends StatefulWidget {
  const BarcodeManagerView({Key? key}) : super(key: key);

  @override
  State<BarcodeManagerView> createState() => _BarcodeManagerViewState();
}

class _BarcodeManagerViewState extends State<BarcodeManagerView> {
  String? enteredKeyword = '';
  bool showFilter = false;
  bool showUnlinked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode Manager',
            style: Theme.of(context).textTheme.titleMedium),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          ///Search Bar.
          _searchBar(),
          const SizedBox(height: 10),
          _optionsText(),
          const SizedBox(height: 5),
          Builder(
            builder: (context) {
              List<BarcodeProperty> allBarcodes = isarDatabase!.barcodePropertys
                  .filter()
                  .barcodeUIDContains(enteredKeyword!)
                  .findAllSync();

              List<BarcodeManagerObject> barcodeManagerObejects = [];

              for (BarcodeProperty barcodeProperty in allBarcodes) {
                ContainerEntry? linkedContainerEntry = isarDatabase!
                    .containerEntrys
                    .filter()
                    .barcodeUIDMatches(barcodeProperty.barcodeUID)
                    .findFirstSync();

                BarcodeManagerObject barcodeManagerObject =
                    BarcodeManagerObject(
                        barcodeProperty: barcodeProperty,
                        containerEntry: linkedContainerEntry);

                barcodeManagerObejects.add(barcodeManagerObject);
              }

              barcodeManagerObejects.sort(
                ((a, b) {
                  return int.parse(a.barcodeProperty.barcodeUID
                          .toString()
                          .split('_')
                          .first)
                      .compareTo(int.parse(b.barcodeProperty.barcodeUID
                          .toString()
                          .split('_')
                          .first));
                }),
              );

              if (showUnlinked == false) {
                barcodeManagerObejects
                    .removeWhere((element) => element.containerEntry == null);
              } else {
                barcodeManagerObejects
                    .removeWhere((element) => element.containerEntry != null);
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: barcodeManagerObejects.length,
                  itemBuilder: ((context, index) {
                    BarcodeManagerObject barcodeManagerObeject =
                        barcodeManagerObejects[index];

                    return barcodeTile(
                        barcodeProperty: barcodeManagerObeject.barcodeProperty,
                        linkedContainer: barcodeManagerObeject.containerEntry);
                  }),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget viewContainer(ContainerEntry containerEntry) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContainerView(
                  containerEntry: containerEntry,
                ),
              ),
            );
            setState(() {});
          },
          child: CustomOutlineContainer(
            padding: 5,
            child: Text(
              'View container',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            outlineColor: Colors.deepOrange,
          ),
        ),
      ],
    );
  }

  Widget linkContainer(String barcodeUID) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddContainerView(
                        barcodeUID: barcodeUID,
                      )),
            );
            setState(() {});
          },
          child: CustomOutlineContainer(
            padding: 5,
            child: Text(
              'Link to container',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            outlineColor: Colors.deepOrange,
          ),
        ),
      ],
    );
  }

  Widget _searchBar() {
    return CustomOutlineContainer(
      outlineColor: Colors.deepOrange,
      backgroundColor: Colors.black12,
      borderWidth: 1,
      margin: 0,
      padding: 5,
      child: Builder(
        builder: ((context) {
          if (showFilter) {
            return searchFilter();
          } else {
            return searchInput();
          }
        }),
      ),
    );
  }

  Widget searchFilter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Filter: ',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showFilter = !showFilter;
                      setState(() {});
                    },
                    icon: const Icon(Icons.filter_alt_outlined),
                  ),
                ],
              ),
              LightContainer(
                margin: 2.5,
                padding: 0,
                child: DarkContainer(
                  margin: 2.5,
                  padding: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Show unlinked containers?',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Checkbox(
                        value: showUnlinked,
                        onChanged: (value) {
                          showUnlinked = !showUnlinked;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget searchInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            style: const TextStyle(fontSize: 18),
            onEditingComplete: (() => hideKeyboard(context)),
            onChanged: (value) {
              enteredKeyword = value;
              setState(() {});
            },
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              icon: Icon(Icons.search),
              labelText: 'search',
              labelStyle: TextStyle(fontSize: 18),
            ),
          ),
        ),
        IconButton(
            onPressed: () {
              showFilter = !showFilter;
              setState(() {});
            },
            icon: const Icon(Icons.filter_alt_outlined))
      ],
    );
  }

  Widget barcodeTile(
      {required BarcodeProperty barcodeProperty,
      ContainerEntry? linkedContainer}) {
    return LightContainer(
      margin: 2.5,
      padding: 0,
      child: Builder(builder: (context) {
        Color color = Colors.white54;
        if (linkedContainer != null) {
          color = getContainerColor(containerUID: linkedContainer.containerUID);
          //color = Colors.deepOrange;
        }
        return CustomOutlineContainer(
          outlineColor: color,
          margin: 5,
          padding: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'BarcodeUID',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                barcodeProperty.barcodeUID,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Divider(
                height: 5,
              ),
              Text(
                'Barcode Size',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                roundDouble(barcodeProperty.size, 2).toString() + 'mm',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Divider(
                height: 5,
              ),
              Builder(
                builder: (context) {
                  if (linkedContainer != null) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ContainerUID',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          linkedContainer.containerUID,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
              Builder(
                builder: (context) {
                  if (linkedContainer != null) {
                    return viewContainer(linkedContainer);
                  } else {
                    return linkContainer(barcodeProperty.barcodeUID);
                  }
                },
              ),
            ],
          ),
        );
      }),
    );
  }

  // Widget _searchBar() {
  //   return SearchBarWidget(
  //     onChanged: (value) {
  //       setState(() {
  //         enteredKeyword = value;
  //       });
  //     },
  //   );
  // }

  Widget _optionsText() {
    return const Text(
      'Swipe for more options',
      style: TextStyle(fontSize: 12),
    );
  }
}
