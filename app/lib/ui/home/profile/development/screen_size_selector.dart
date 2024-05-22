import 'package:emma/infrastructure/window_size_writer.dart';
import 'package:flutter/material.dart';

class ScreenSizeSelector extends StatelessWidget {
  const ScreenSizeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final entries = WindowSizeWriter.sizes.keys
        .map((key) => DropdownMenuEntry(value: key, label: key))
        .toList();

    return DropdownMenu<String>(
      dropdownMenuEntries: entries,
      initialSelection: WindowSizeWriter.current,
      enableFilter: false,
      enableSearch: false,
      onSelected: (key) async {
        if (key != null) {
          await WindowSizeWriter.setSize(key);
        }
      },
    );
  }
}
