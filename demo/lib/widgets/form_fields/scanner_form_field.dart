import 'package:flutter/material.dart';
import 'package:tswiri/views/ml_kit/barcode_selector_view.dart';

class ScannerFormField<T> extends FormField<T> {
  ScannerFormField({
    super.key,
    super.validator,
    super.autovalidateMode,
    super.initialValue,
    super.onSaved,
    FocusNode? focusNode,
    InputDecoration decoration = const InputDecoration(),
  }) : super(
          builder: (state) {
            return Builder(builder: (context) {
              final theme = Theme.of(context);

              final inputDecoration = decoration
                  .copyWith(
                    errorText: state.errorText,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  )
                  .applyDefaults(theme.inputDecorationTheme);

              return InputDecorator(
                decoration: inputDecoration,
                isFocused: focusNode?.hasFocus ?? false,
                isEmpty: state.value == null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    state.value != null
                        ? Text(
                            state.value.toString(),
                            style: theme.textTheme.titleMedium,
                          )
                        : const SizedBox(),
                    OutlinedButton.icon(
                      onPressed: () async {
                        await Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const BarcodeSelectorView()));

                        // final scannedBarcode = await scanBarcode();

                        // state.didChange(value);
                      },
                      icon: const Icon(Icons.qr_code_scanner),
                      label: const Text('Scan'),
                    ),
                  ],
                ),
              );
            });
          },
        );
}
