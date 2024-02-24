import 'package:flutter/material.dart';
import 'package:tswiri/routes.dart';

class ScannerFormField extends FormField {
  ScannerFormField({
    super.key,
    super.validator,
    super.autovalidateMode,
    super.initialValue,
    super.onSaved,
    void Function(String?)? onChanged,
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

              final hasValue = state.value != null;

              final Widget iconButton;
              if (hasValue) {
                iconButton = IconButton(
                  onPressed: () {
                    state.didChange(null);
                    onSaved?.call(null);
                    onChanged?.call(null);
                  },
                  icon: const Icon(Icons.clear),
                );
              } else {
                iconButton = OutlinedButton.icon(
                  onPressed: () async {
                    final barcodeUUID = await Navigator.of(context).pushNamed(
                      Routes.barcodeSelector,
                    );

                    if (barcodeUUID != null && barcodeUUID is String) {
                      state.didChange(barcodeUUID);
                      onSaved?.call(barcodeUUID);
                      onChanged?.call(barcodeUUID);
                    }
                  },
                  icon: const Icon(Icons.qr_code_scanner),
                  label: const Text('Scan'),
                );
              }

              return InputDecorator(
                decoration: inputDecoration,
                isFocused: focusNode?.hasFocus ?? false,
                isEmpty: state.value == null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      hasValue ? state.value.toString() : '',
                      style: theme.textTheme.titleMedium,
                    ),
                    iconButton,
                  ],
                ),
              );
            });
          },
        );
}
