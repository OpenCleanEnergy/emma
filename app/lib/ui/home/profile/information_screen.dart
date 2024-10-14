import 'package:flutter/material.dart';
import 'package:openems/ui/app_icons.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutScreen extends StatelessWidget {
  static const title = "Informationen";

  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      ListTile(
        title: const Text("Impressum"),
        trailing: const Icon(AppIcons.open_in_new),
        onTap: () =>
            launchUrlString("https://opencleanenergy.org/legal-notice/"),
      ),
      ListTile(
        title: const Text("Datenschutz"),
        trailing: const Icon(AppIcons.open_in_new),
        onTap: () =>
            launchUrlString("https://opencleanenergy.org/privacy-policy/"),
      ),
      Column(
        children: [
          const ListTile(title: Text("Bildquellen:")),
          ListTile(
            title: const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text("IconKitchen"),
            ),
            trailing: const Icon(AppIcons.open_in_new),
            onTap: () => launchUrlString("https://icon.kitchen"),
          ),
          ListTile(
            title: const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text("Uicons by Flaticon"),
            ),
            trailing: const Icon(AppIcons.open_in_new),
            onTap: () => launchUrlString("https://www.flaticon.com/uicons"),
          )
        ],
      )
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
      body: ListView(
        children: [
          ...ListTile.divideTiles(context: context, tiles: items),
        ],
      ),
    );
  }
}
