import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:tswiri/ml_kit/barcode_scanner/barcode_scanner_view.dart';
import 'package:tswiri_database/collections/essential/cataloged_coordinate/cataloged_coordinate.dart';
import 'package:tswiri_database/collections/essential/cataloged_grid/cataloged_grid.dart';
import 'package:tswiri_database/collections/essential/marker/marker.dart';
import 'package:tswiri_database/embedded/embedded_vector_3/embedded_vector_3.dart';
import 'package:tswiri_database/tswiri_database.dart';
import 'package:vector_math/vector_math_64.dart' as vm;

class NewGridView extends StatefulWidget {
  const NewGridView({Key? key, this.originBarcodeUID}) : super(key: key);
  final String? originBarcodeUID;
  @override
  State<NewGridView> createState() => NewGridViewState();
}

class NewGridViewState extends State<NewGridView> {
  late int numOfGrids = getCatalogedGridsSync().length;
  late String? originBarcodeUID = widget.originBarcodeUID;
  String? parentBarcodeUID;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text('New Grid: ${numOfGrids + 1}'),
      centerTitle: true,
      elevation: 10,
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            _origin(),
            _parent(),
            const Divider(),
            _create(),
          ],
        ),
      ),
    );
  }

  Widget _origin() {
    return ListTile(
      leading: Icon(
        originBarcodeUID == null
            ? Icons.question_mark_rounded
            : Icons.qr_code_2_rounded,
      ),
      title: const Text('Origin Barcode'),
      subtitle: Text(originBarcodeUID ?? '-'),
      trailing: OpenContainer<String>(
        openColor: Colors.transparent,
        closedColor: Colors.transparent,
        closedBuilder: (context, action) {
          return OutlinedButton(
            onPressed: action,
            child: Text(originBarcodeUID == null ? 'Scan' : 'Change'),
          );
        },
        openBuilder: (context, action) {
          return const BarcodeScannerView();
        },
        onClosed: (barcodeUID) {
          if (barcodeUID == null) return;
          Marker? marker = getMarker(barcodeUID: barcodeUID);
          if (marker == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Barcode is not a marker are you sure?',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          }

          setState(() {
            originBarcodeUID = barcodeUID;
          });
        },
      ),
    );
  }

  Widget _parent() {
    return ListTile(
      leading: Icon(
        parentBarcodeUID == null
            ? Icons.question_mark_rounded
            : Icons.qr_code_2_rounded,
      ),
      title: const Text('Parent Barcode'),
      subtitle: Text(parentBarcodeUID ?? '-'),
      trailing: OpenContainer<String>(
        openColor: Colors.transparent,
        closedColor: Colors.transparent,
        closedBuilder: (context, action) {
          return OutlinedButton(
            onPressed: action,
            child: Text(parentBarcodeUID == null ? 'Scan' : 'Change'),
          );
        },
        openBuilder: (context, action) {
          return const BarcodeScannerView();
        },
        onClosed: (barcodeUID) {
          if (barcodeUID == null) return;
          setState(() {
            parentBarcodeUID = barcodeUID;
          });
        },
      ),
    );
  }

  Widget _create() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OutlinedButton(
        onPressed: () {
          if (originBarcodeUID == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Please scan a Orgin Barcode',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
            return;
          }

          CatalogedGrid catalogedGrid = CatalogedGrid()
            ..barcodeUID = originBarcodeUID!
            ..parentBarcodeUID = parentBarcodeUID;

          CatalogedCoordinate catalogedCoordinate = CatalogedCoordinate()
            ..barcodeUID = originBarcodeUID!
            ..coordinate = EmbeddedVector3.fromVector(vm.Vector3(0, 0, 0))
            ..rotation = EmbeddedVector3.fromVector(vm.Vector3(0, 0, 0))
            ..timestamp = DateTime.now().millisecondsSinceEpoch;

          createNewGrid(
            catalogedGrid: catalogedGrid,
            catalogedCoordinate: catalogedCoordinate,
          );

          Navigator.of(context).pop();
        },
        child: const Text('Create'),
      ),
    );
  }
}
