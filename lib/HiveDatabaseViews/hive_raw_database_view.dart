import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/widgets/alert_dialog_widget.dart';
import 'package:hive/hive.dart';

class HiveDatabaseView extends StatefulWidget {
  const HiveDatabaseView({Key? key}) : super(key: key);

  @override
  _HiveDatabaseViewState createState() => _HiveDatabaseViewState();
}

class _HiveDatabaseViewState extends State<HiveDatabaseView> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive Database'),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              heroTag: null,
              onPressed: () async {
                await Hive.box('rawDataBox').clear();
                setState(() {
                  loadData();
                });
                showMyAboutDialog(context, "Deleted Hive Database");
              },
              child: const Icon(Icons.delete),
            ),
            FloatingActionButton(
              heroTag: null,
              onPressed: () {
                setState(() {});
              },
              child: const Icon(Icons.refresh),
            ),
          ],
        ),
      ),
      body: FutureBuilder<List>(
        future: loadData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          } else {
            List myList = snapshot.data ?? [];
            return ListView.builder(
                itemCount: myList.length,
                itemBuilder: (context, index) {
                  var text = myList[index].toString();
                  return Text(text);
                });
          }
        },
      ),
    );
  }

  Future<List> loadData() async {
    List list = [];
    var box = await Hive.openBox('rawDataBox');
    var data = box.toMap();
    data.forEach((key, value) {
      list.add([value]);
    });
    return list;
  }
}
