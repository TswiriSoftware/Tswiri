import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/containerAdapter/container_entry_adapter.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/containerSystem/container_selector_view.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/containerSystem/functions/database_functions.dart';
import 'package:flutter_google_ml_kit/widgets/custom_container.dart';
import 'package:flutter_google_ml_kit/widgets/light_container.dart';
import 'package:flutter_google_ml_kit/widgets/orange_container.dart';

class ContainerChildrenView extends StatefulWidget {
  const ContainerChildrenView({Key? key, this.currentContainerUID})
      : super(key: key);
  final String? currentContainerUID;

  @override
  State<ContainerChildrenView> createState() => _ContainerChildrenViewState();
}

class _ContainerChildrenViewState extends State<ContainerChildrenView> {
  Set<String>? children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Children',
          style: TextStyle(fontSize: 25),
        ),
        actions: [
          IconButton(
              onPressed: () {
                //showInfoDialog(context);
              },
              icon: const Icon(Icons.info_outline_rounded))
        ],
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///Scan Children.
            LightContainer(
              child: CustomOutlineContainer(
                outlineColor: Colors.deepOrange,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Scan Children's Barcodes",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      InkWell(
                        onTap: () {},
                        child: const OrangeOutlineContainer(
                          width: 40,
                          height: 40,
                          padding: 0,
                          margin: 0,
                          child: Icon(
                            Icons.qr_code_2_rounded,
                            size: 30,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            ///Select Children.
            LightContainer(
              child: CustomOutlineContainer(
                outlineColor: Colors.deepOrange,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Select Children",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      InkWell(
                        onTap: () async {
                          children = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ContainerSelectorView(
                                multipleSelect: true,
                              ),
                            ),
                          );
                          if (widget.currentContainerUID != null &&
                              children != null) {
                            updateContainerChildren(
                                widget.currentContainerUID!, children!);
                          }
                        },
                        child: const OrangeOutlineContainer(
                          width: 40,
                          height: 40,
                          padding: 0,
                          margin: 0,
                          child: Icon(
                            Icons.select_all_rounded,
                            size: 30,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            //Children view
            LightContainer(
              child: CustomOutlineContainer(
                outlineColor: Colors.deepOrange,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Children',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      LightContainer(
                        child: SizedBox(
                          height: 500,
                          child: FutureBuilder<List<ContainerEntryOLD>>(
                            future: getChildren(),
                            builder: ((context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  itemCount: snapshot.data?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        log('message');
                                      },
                                      child: Text('data'),
                                    );
                                  },
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<List<ContainerEntryOLD>> getChildren() async {
    return [];
  }
}
