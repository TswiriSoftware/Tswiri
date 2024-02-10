import 'package:flutter/material.dart';
import 'package:tswiri/enumerations.dart';

class QRCodeBatchSetup extends StatefulWidget {
  final int numberOfBarcodes;
  final Function(int numberOfBarcodes) onNumberOfBarcodesChanged;

  final BarcodeSize initialBarcodeSize;
  final Function(Size barcodeSize) onBarcodeSizeChanged;

  final Function() onGenerate;

  const QRCodeBatchSetup({
    super.key,
    required this.numberOfBarcodes,
    required this.onNumberOfBarcodesChanged,
    required this.initialBarcodeSize,
    required this.onBarcodeSizeChanged,
    required this.onGenerate,
  });

  @override
  State<QRCodeBatchSetup> createState() => _QRCodeBatchSetupState();
}

class _QRCodeBatchSetupState extends State<QRCodeBatchSetup> {
  late Set<BarcodeSize> selection = {widget.initialBarcodeSize};
  late Size size = widget.initialBarcodeSize.size;
  bool get isCustomSizeSelected => selection.first == BarcodeSize.custom;
  Size get barcodeSize => isCustomSizeSelected ? size : selection.first.size;
  int get numberOfBarcodes => widget.numberOfBarcodes;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Barcode Size',
            style: theme.textTheme.titleMedium,
          ),
          SegmentedButton(
            segments: [
              for (final size in BarcodeSize.values)
                ButtonSegment(
                  label: Text(size.label),
                  value: size,
                  tooltip: size.description,
                ),
            ],
            selected: selection,
            onSelectionChanged: (newSelection) {
              selection = newSelection;
              size = selection.first.size;
              widget.onBarcodeSizeChanged(size);
            },
            multiSelectionEnabled: false,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Tooltip(
                    message: 'Height',
                    child: Icon(Icons.height),
                  ),
                  title: isCustomSizeSelected
                      ? TextFormField(
                          initialValue: size.width.toString(),
                          decoration: const InputDecoration(
                            labelText: 'Height',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 8,
                            ),
                            suffix: Text('mm'),
                          ),
                          onChanged: (value) {
                            size = Size(
                              double.tryParse(value) ?? size.width,
                              size.height,
                            );
                            widget.onBarcodeSizeChanged(size);
                          },
                        )
                      : Text('${size.height} mm'),
                ),
                ListTile(
                  leading: const RotatedBox(
                    quarterTurns: 1,
                    child: Tooltip(
                      message: 'Width',
                      child: Icon(Icons.height),
                    ),
                  ),
                  title: isCustomSizeSelected
                      ? TextFormField(
                          initialValue: size.height.toString(),
                          decoration: const InputDecoration(
                            labelText: 'Width',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 8,
                            ),
                            suffix: Text('mm'),
                          ),
                          onChanged: (value) {
                            size = Size(
                              size.width,
                              double.tryParse(value) ?? size.height,
                            );
                            widget.onBarcodeSizeChanged(size);
                          },
                        )
                      : Text('${size.height} mm'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 16.0,
            ),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Number of barcodes',
                border: OutlineInputBorder(),
              ),
              initialValue: numberOfBarcodes.toString(),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                widget.onNumberOfBarcodesChanged(
                  int.tryParse(value) ?? numberOfBarcodes,
                );
              },
            ),
          ),
          FilledButton.tonal(
            onPressed: widget.onGenerate,
            child: const Text('Generate'),
          ),
        ],
      ),
    );
  }
}
