import 'package:flutter/material.dart';
import 'package:sunbird_v2/globals/globals_export.dart';
import 'package:sunbird_v2/isar/collections/barcode_properties/barcode_property.dart';
import 'package:sunbird_v2/isar/collections/container_entry/container_entry.dart';
import 'package:sunbird_v2/isar/isar_database.dart';
import 'package:sunbird_v2/widgets/cards/barcode_card.dart';
import 'package:sunbird_v2/widgets/chips/filter_chip.dart';
import 'package:isar/isar.dart';

class BarcodesView extends StatefulWidget {
  const BarcodesView({Key? key}) : super(key: key);

  @override
  State<BarcodesView> createState() => _BarcodesViewState();
}

class _BarcodesViewState extends State<BarcodesView> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchNode = FocusNode();
  bool isSearching = false;

  Map<String, String> barcodeFilterTypes = {
    'Assigned': 'Assigned Barcodes',
    'Unassigned': 'Unassigned Barcodes',
  };

  List<String>? linkedContainers = [];
  List<BarcodeProperty>? allBarcodes;
  List<BarcodeProperty> barcodes = [];

  @override
  void initState() {
    _getBarcodes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isSearching ? _searchBar() : _titleBar(),
      body: _body(),
    );
  }

  PreferredSizeWidget _titleBar() {
    return AppBar(
      title: Text(
        'Barcodes',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              isSearching = true;
              _searchNode.requestFocus();
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
    return AppBar(
      title: TextField(
        controller: _searchController,
        focusNode: _searchNode,
        onChanged: (value) {
          _search(enteredKeyword: value);
        },
      ),
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              isSearching = false;
            });
          },
          icon: const Icon(
            Icons.close_sharp,
          ),
        ),
      ],
    );
  }

  Widget _body() {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        _barcodes(),
        _filters(),
      ],
    );
  }

  Widget _barcodes() {
    return Builder(
      builder: (context) {
        if (barcodes.isNotEmpty) {
          return ListView.builder(
            itemCount: barcodes.length,
            padding: const EdgeInsets.symmetric(
              vertical: 40,
            ),
            itemBuilder: (context, index) {
              return BarcodeCard(
                barcodeProperty: barcodes[index],
              );
            },
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: Text(
            'no results',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );
      },
    );
  }

  Widget _filters() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: Wrap(
          spacing: 5,
          children: barcodeFilterTypes.entries
              .map(
                (e) => CustomFilterChip(
                  label: e.key,
                  toolTip: 'Assigned Barcodes',
                  selected: barcodeFilters.contains(e.key),
                  onSelected: (value) {
                    _onSelected(value, e.key);
                    _getBarcodes();
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  void _onSelected(bool selected, String filter) {
    if (barcodeFilters.contains(filter)) {
      setState(() {
        barcodeFilters.removeWhere((element) => element == filter);
      });
    } else {
      setState(() {
        barcodeFilters.add(filter);
      });
    }
  }

  void _getBarcodes() async {
    setState(() {
      linkedContainers = isar!.containerEntrys
          .where()
          .findAllSync()
          .map((e) => e.barcodeUID!)
          .toList();

      allBarcodes = isar!.barcodePropertys.where().findAllSync();

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
