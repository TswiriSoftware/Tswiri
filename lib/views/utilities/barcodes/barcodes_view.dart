import 'package:tswiri/views/utilities/barcode_generator/generator_view.dart';
import 'package:flutter/material.dart';
import 'package:tswiri_database/export.dart';
import 'package:tswiri_database/models/settings/global_settings.dart';
import 'package:tswiri_widgets/colors/colors.dart';
import 'package:tswiri_widgets/widgets/general/sunbird_search_bar.dart';

class BarcodesView extends StatefulWidget {
  const BarcodesView({Key? key}) : super(key: key);

  @override
  State<BarcodesView> createState() => _BarcodesViewState();
}

class _BarcodesViewState extends State<BarcodesView> {
  bool isSearching = false;

  Map<String, String> barcodeFilterTypes = {
    'Assigned': 'Assigned Barcodes',
    'Unassigned': 'Unassigned Barcodes',
  };

  List<String>? linkedContainers = [];
  List<CatalogedBarcode>? allBarcodes;
  List<CatalogedBarcode> barcodes = [];

  @override
  void initState() {
    _getBarcodes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isSearching ? _searchBar() : _titleBar(),
      body: _barcodesListView(),
    );
  }

  PreferredSizeWidget _titleBar() {
    return AppBar(
      title: Text(
        'Barcodes',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              isSearching = true;
            });
          },
          icon: const Icon(
            Icons.search_sharp,
          ),
        ),
      ],
    );
  }

  PreferredSizeWidget _searchBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight + 50),
      child: SearchBar(
        filters: barcodeFilters,
        filterTypes: barcodeFilterTypes.entries.map((e) => e.key).toList(),
        onFilterChange: (enteredKeyWord) {
          _getBarcodes();
        },
        onCancel: () {
          setState(() {
            isSearching = false;
          });
        },
        onChanged: (value) {
          _search(enteredKeyword: value);
        },
        onSubmitted: (value) {},
        defaultFilterColor: tswiriOrange,
        filterChipColorMap: null,
      ),
    );
  }

  Widget _barcodesListView() {
    return Builder(
      builder: (context) {
        if (barcodes.isNotEmpty) {
          return ListView.builder(
            itemCount: barcodes.length,
            itemBuilder: (context, index) {
              return _barcodeCard(barcodes[index]);
            },
          );
        }
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => const GeneratorView()),
                );
              },
              child: Text(
                'Generate Barcodes',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _barcodeCard(CatalogedBarcode barcodeProperty) {
    //Check if barcode is linked.
    CatalogedContainer? linkedContainer = isar!.catalogedContainers
        .filter()
        .barcodeUIDMatches(barcodeProperty.barcodeUID)
        .findFirstSync();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ID: ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  barcodeProperty.barcodeUID,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            const Divider(
              indent: 5,
              endIndent: 5,
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Size: ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  '${barcodeProperty.width} x ${barcodeProperty.height} mm',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            const Divider(
              indent: 5,
              endIndent: 5,
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Linked: ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  (linkedContainer == null)
                      ? '-'
                      : linkedContainer.name ?? linkedContainer.containerUID,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _getBarcodes() async {
    setState(() {
      linkedContainers = isar!.catalogedContainers
          .where()
          .findAllSync()
          .map((e) => e.barcodeUID!)
          .toList();

      allBarcodes = isar!.catalogedBarcodes.where().findAllSync();

      if (barcodeFilters.contains('Assigned')) {
        barcodes = allBarcodes!
            .where((element) => linkedContainers!.contains(element.barcodeUID))
            .toList();
      }
      if (barcodeFilters.contains('Unassigned')) {
        barcodes = allBarcodes!
            .where((element) => !linkedContainers!.contains(element.barcodeUID))
            .toList();
      }
    });
  }

  void _search({String? enteredKeyword}) {
    setState(() {
      if (enteredKeyword != null) {
        barcodes = allBarcodes!
            .where((element) => element.barcodeUID.contains(enteredKeyword))
            .toList();
      } else {
        barcodes = allBarcodes!;
      }
    });
  }
}
