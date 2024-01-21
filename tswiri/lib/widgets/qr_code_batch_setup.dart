import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:tswiri/enumerations.dart';

class QRCodeBatchSetup extends StatefulWidget {
  final int numberOfBarcodes;
  final Function(int numberOfBarcodes) onNumberOfBarcodesChanged;

  final BarcodeSize initialBarcodeSize;
  final Function(Size barcodeSize) onBarcodeSizeChanged;

  const QRCodeBatchSetup({
    super.key,
    required this.numberOfBarcodes,
    required this.onNumberOfBarcodesChanged,
    required this.initialBarcodeSize,
    required this.onBarcodeSizeChanged,
  });

  @override
  State<QRCodeBatchSetup> createState() => _QRCodeBatchSetupState();
}

class _QRCodeBatchSetupState extends State<QRCodeBatchSetup> {
  bool isEditing = false;
  int get numberOfBarcodes => widget.numberOfBarcodes;

  Set<BarcodeSize> get selection => {widget.initialBarcodeSize};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Number of barcodes:',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Card(
              clipBehavior: Clip.antiAlias,
              elevation: 10,
              child: InkWell(
                onTap: () {
                  setState(() {
                    isEditing = true;
                  });
                },
                child: isEditing
                    ? SizedBox(
                        width: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            autofocus: true,
                            keyboardType: TextInputType.number,
                            initialValue: numberOfBarcodes.toString(),
                            onFieldSubmitted: (value) {
                              widget.onNumberOfBarcodesChanged(int.tryParse(value) ?? numberOfBarcodes);
                              setState(() {
                                isEditing = false;
                              });
                            },
                          ),
                        ),
                      )
                    : NumberPicker(
                        value: numberOfBarcodes,
                        minValue: 1,
                        maxValue: 1000,
                        onChanged: (newValue) {
                          widget.onNumberOfBarcodesChanged(newValue);
                        },
                        selectedTextStyle: theme.textTheme.headlineMedium?.copyWith(
                          color: theme.colorScheme.secondary,
                        ),
                      ),
              ),
            )
          ],
        ),
        const Divider(),
        Text(
          'Barcode Size: ',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        SegmentedButton(
          segments: [
            for (final size in BarcodeSize.values)
              ButtonSegment(
                label: Text(size.label),
                value: size,
              ),
          ],
          selected: selection,
          onSelectionChanged: (newSelection) {
            widget.onBarcodeSizeChanged(newSelection.first.size);
          },
          multiSelectionEnabled: false,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.height),
              title: Text('${selection.first.size.height} mm'),
            ),
            ListTile(
              leading: const RotatedBox(quarterTurns: 1, child: Icon(Icons.height)),
              title: Text('${selection.first.size.width} mm'),
            ),
          ],
        )
      ],
    );
  }
}
