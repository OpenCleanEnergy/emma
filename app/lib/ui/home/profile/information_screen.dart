import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutScreen extends StatelessWidget {
  static const title = "Informationen";

  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      ListTile(
        title: const Text("Impressum"),
        trailing: const Icon(Icons.open_in_new),
        onTap: () =>
            launchUrlString("https://opencleanenergy.org/legal-notice/"),
      ),
      ListTile(
        title: const Text("Datenschutz"),
        trailing: const Icon(Icons.open_in_new),
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
            trailing: const Icon(Icons.open_in_new),
            onTap: () => launchUrlString("https://icon.kitchen"),
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
