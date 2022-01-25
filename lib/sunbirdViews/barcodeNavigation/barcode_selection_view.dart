import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcodeScanning/consolidated_database_view.dart';
import 'package:hive/hive.dart';

import 'barcode_navigator_view.dart';

class BarcodeSelectionView extends StatefulWidget {
  const BarcodeSelectionView({Key? key}) : super(key: key);

  @override
  _BarcodeSelectionViewState createState() => _BarcodeSelectionViewState();
}

class _BarcodeSelectionViewState extends State<BarcodeSelectionView> {
  List validQrcodeIDs = [];
  String selectedValue = '';
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Qr Code Selector',
            style: TextStyle(fontSize: 25),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: null,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Valid'),
                        duration: Duration(milliseconds: 50),
                      ),
                    );
                    print(myController.text);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BarcodeNavigatorView(
                                qrcodeID: myController.text)));
                  }
                },
                child: const Icon(
                  Icons.check_rounded,
                ),
              )
            ],
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: myController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.white,
                      )),
                      contentPadding: EdgeInsets.all(5),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.deepOrange,
                      )),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.deepOrange,
                      )),
                      labelText: 'Enter Qrcode ID',
                      labelStyle: TextStyle(color: Colors.deepOrangeAccent)),
                  cursorColor: Colors.orangeAccent,
                  keyboardType: TextInputType.number,
                  keyboardAppearance: Brightness.dark,
                  textAlign: TextAlign.center,
                  validator: (value) {
                    print(validQrcodeIDs);
                    if (isNumeric(value.toString()) != true) {
                      return 'Please enter a valid ID';
                    } else if (validQrcodeIDs.contains(value) != true) {
                      return 'No Such ID';
                    }
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List>(
                future: consolidateData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    List myList = snapshot.data ?? [];
                    return ListView.builder(
                        itemCount: myList.length,
                        itemBuilder: (context, index) {
                          var myText = myList[index]
                              .toString()
                              .replaceAll(RegExp(r'\[|\]'), '')
                              .replaceAll(' ', '')
                              .split(',')
                              .toList();
                          if (index == 0) {
                            return Column(
                              children: <Widget>[
                                displayDataPoint(['UID', 'X', 'Y', 'Fixed']),
                                const SizedBox(
                                  height: 5,
                                ),
                                displayDataPoint(myText),
                              ],
                            );
                          } else {
                            return displayDataPoint(myText);
                          }
                        });
                  }
                },
              ),
            ),
          ],
        ));
  }

  Future<List> consolidateData() async {
    var consolidatedDataBox = await Hive.openBox('consolidatedDataBox');
    Map consolidatedDataMap = consolidatedDataBox.toMap();
    List displayList = [];
    consolidatedDataMap.forEach((key, value) {
      displayList.add([value]);
      validQrcodeIDs.add(key);
      print(key);
    });
    return displayList;
  }
}

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return int.tryParse(s) != null;
}
