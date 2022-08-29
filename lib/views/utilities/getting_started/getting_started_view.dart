import 'package:flutter/material.dart';
import 'package:sunbird/views/containers/new_container_view/new_container_view.dart';
import 'package:sunbird/views/utilities/generator/generator_view.dart';
import 'package:sunbird/views/utilities/getting_started/widgets/sub_title_text.dart';
import 'package:sunbird_base/colors/colors.dart';

import 'widgets/body_text_widget.dart';

class GettingStartedView extends StatefulWidget {
  const GettingStartedView({Key? key}) : super(key: key);

  @override
  State<GettingStartedView> createState() => _GettingStartedViewState();
}

bool hasGeneratedQRCodes = false;
bool hasPlacedBarcodes = false;
bool hasCreatedContainers = false;
bool hasScannedGrid = false;
bool hasNavigated = false;

class _GettingStartedViewState extends State<GettingStartedView> {
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
      title: Text(
        'Getting Started',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      centerTitle: true,
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ///Barcodes.
          CustomExpansionTile(
            heading: '1. Barcodes',
            hasDone: hasGeneratedQRCodes,
            children: [
              const BodyText(
                text: 'i. QR Codes and Barcodes are interchangeble.',
              ),
              const BodyText(
                text: 'ii. Size your Qr Codes appropriately.',
              ),
              const BodyText(
                text: 'iii. Bigger QR Codes are better in most cases.',
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/tutorial_images/page_with_barcodes.png',
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.width / 2,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/tutorial_images/box_with_barcode.png',
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.width / 2,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GeneratorView(),
                          ),
                        );

                        setState(() {
                          hasGeneratedQRCodes = true;
                        });
                      },
                      child: Text(
                        'go',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),

          ///Place the barcodes.
          CustomExpansionTile(
            heading: '2. Barcode Placement',
            hasDone: hasPlacedBarcodes,
            children: [
              const BodyText(
                text: 'i. Stick your barcodes to boxes.',
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/tutorial_images/shelf_white.png',
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.width / 2,
                  ),
                ),
              ),
              const BodyText(
                text: 'ii. Add a barcode for the shelf !',
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/tutorial_images/shelf_with_barcode_white.png',
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.width / 2,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          hasPlacedBarcodes = true;
                        });
                      },
                      child: Text(
                        'done',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),

          ///Start Creating Containers.
          CustomExpansionTile(
            heading: '3. Create Some Containers',
            hasDone: hasCreatedContainers,
            children: [
              const BodyText(
                text:
                    'i. When creating containers you can add Photos/Tags, to the container. (This is used to find the containers later)',
              ),
              const BodyText(
                text: 'ii. Create a shelf.',
              ),
              const BodyText(
                text: 'iii. Add Boxes as children to that shelf.',
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/tutorial_images/container_struckture.png',
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.width / 2,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NewContainerView(),
                          ),
                        );

                        setState(() {
                          hasCreatedContainers = true;
                        });
                      },
                      child: Text(
                        'go',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),

          ///Scan a grid.
          CustomExpansionTile(
            heading: '4. Scan a Grid.',
            hasDone: hasScannedGrid,
            children: [
              const BodyText(
                text: 'i. Navigate to the shelf you just created.',
              ),
              const BodyText(
                text: 'ii. Expand the grid tile.',
              ),
              const BodyText(
                text: 'iii. Proceed to the grid view.',
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/tutorial_images/shelf_with_barcode_white_scan.png',
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.width / 2,
                  ),
                ),
              ),
              const BodyText(
                text:
                    'iii. Now scan all the barcodes. Make sure you scan at least 2 barcodes at once.',
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/tutorial_images/barcode_scanning.png',
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.width / 2,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          hasScannedGrid = true;
                        });
                      },
                      child: Text(
                        'done',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),

          ///Finding something.
          CustomExpansionTile(
            heading: '5. Find something.',
            hasDone: hasNavigated,
            children: [
              const BodyText(
                text: 'i. Navigate to the search screen.',
              ),
              const BodyText(
                text:
                    'ii. Search for something. (Filters can be applied to narrow down the search.).',
              ),
              const BodyText(
                text: 'iii. Click on Find.',
              ),
              const BodyText(
                text:
                    'iv. The navigator will guide you towards the selected item.',
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/tutorial_images/navigation.png',
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.width / 2,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          hasNavigated = true;
                        });
                      },
                      child: Text(
                        'done',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CustomExpansionTile extends StatelessWidget {
  const CustomExpansionTile({
    Key? key,
    required this.heading,
    required this.children,
    required this.hasDone,
  }) : super(key: key);

  final String heading;
  final bool hasDone;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        initiallyExpanded: !hasDone,
        title: Row(
          children: [
            SubTitleText(
              subTitle: heading,
            ),
            hasDone
                ? const Icon(
                    Icons.check_sharp,
                    color: sunbirdOrange,
                  )
                : const SizedBox.shrink(),
          ],
        ),
        children: children,
      ),
    );
  }
}
