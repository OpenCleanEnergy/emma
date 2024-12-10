import 'package:flutter/material.dart';
import 'package:openems/ui/icons/app_icons.dart';

class HomeOnboarding extends StatelessWidget {
  const HomeOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    final iconSize = Theme.of(context).iconTheme.size;
    assert(iconSize != null, "Icon size must not be null");
    return Stack(
      children: [
        Center(
          child: Text(
            "Keine Daten vorhanden.\nFüge jetzt Geräte hinzu.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Positioned(
          bottom: 8,
          left: 0,
          right: 0,
          child: Row(
            children: [
              const Spacer(flex: 1),
              Expanded(
                flex: 5,
                child: Row(
                  children: [
                    Transform.translate(
                      offset: Offset(iconSize! / -2, 0),
                      child: const Icon(AppIcons.arrow_down),
                    ),
                    Text(
                      "Jetzt Geräte hinzufügen.",
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
