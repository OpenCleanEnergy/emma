import 'package:flutter/material.dart';
import 'package:openems/ui/icons/app_icons.dart';
import 'package:openems/ui/shared/app_bar_action_button.dart';

class DevicesOnboarding extends StatelessWidget {
  const DevicesOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    final iconSize = Theme.of(context).iconTheme.size;
    assert(iconSize != null, "Icon size must not be null");

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Jetzt Geräte hinzufügen.",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(width: iconSize! / 2),
          const Icon(AppIcons.arrow_up),
          // The app bar action button has a padding
          // and the icon in the app bar action button has a padding of 8.0
          const SizedBox(width: AppBarActionButton.padding + 8.0),
        ],
      ),
    );
  }
}
