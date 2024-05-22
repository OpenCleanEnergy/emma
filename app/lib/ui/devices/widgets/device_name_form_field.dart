import 'package:flutter/material.dart';

class DeviceNameFormField extends StatelessWidget {
  final TextEditingController _controller;
  final bool _autoFocus;

  const DeviceNameFormField({
    super.key,
    required TextEditingController controller,
    bool autoFocus = false,
  })  : _controller = controller,
        _autoFocus = autoFocus;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      autofocus: _autoFocus,
      decoration: const InputDecoration(labelText: "Gerätename"),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Bitte gib einen Namen ein.';
        }
        return null;
      },
    );
  }
}
