import 'package:openems/infrastructure/window_size_writer.dart';
import 'package:flutter/material.dart';
import 'package:openems/ui/icons/app_icons.dart';

class ScreenSizeSelector extends StatefulWidget {
  const ScreenSizeSelector({super.key});

  @override
  State<ScreenSizeSelector> createState() => _ScreenSizeSelectorState();
}

class _ScreenSizeSelectorState extends State<ScreenSizeSelector> {
  @override
  Widget build(BuildContext context) {
    final entries = WindowSizeWriter.sizes.keys
        .map((key) => DropdownMenuEntry(value: key, label: key))
        .toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DropdownMenu<String>(
          dropdownMenuEntries: entries,
          initialSelection: WindowSizeWriter.current,
          enableFilter: false,
          enableSearch: false,
          onSelected: (key) => WindowSizeWriter.setSize(key),
        ),
        IconButton(
          onPressed: () => WindowSizeWriter.toggleOrientation(),
          icon: const Icon(AppIcons.rotate_right),
        )
      ],
    );
  }
}
