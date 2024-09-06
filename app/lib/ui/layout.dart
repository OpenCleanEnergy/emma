import 'package:emma/ui/analytics/analytics_screen.dart';
import 'package:emma/ui/app_icons.dart';
import 'package:emma/ui/devices/devices_screen.dart';
import 'package:emma/ui/home/home_screen.dart';
import 'package:emma/ui/home/profile/profile_screen.dart';
import 'package:flutter/material.dart';

// from
// - https://dev.to/nicks101/state-persistence-techniques-for-the-flutter-bottom-navigation-bar-3ikc
// - https://blog.canopas.com/how-to-maintain-the-state-of-bottomnavigationbar-across-tabs-528b3699f78b
class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    const pages = [
      DevicesScreen(),
      HomeScreen(),
      ProfileScreen(),
      AnalyticsScreen(),
    ];

    const destinations = [
      NavigationDestination(
          icon: Icon(AppIcons.power_outlined),
          selectedIcon: Icon(AppIcons.power),
          label: "Geräte"),
      NavigationDestination(
          icon: Icon(AppIcons.home_outlined),
          selectedIcon: Icon(AppIcons.home),
          label: "Zuhause"),
      NavigationDestination(
          icon: Icon(AppIcons.person_outlined),
          selectedIcon: Icon(AppIcons.person),
          label: "Profil"),
      NavigationDestination(
          icon: Icon(AppIcons.pie_chart_outlined),
          selectedIcon: Icon(AppIcons.pie_chart),
          label: "Analysen"),
    ];

    return Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: pages,
        ),
        bottomNavigationBar: NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onDestinationSelected,
            destinations: destinations));
  }

  void _onDestinationSelected(int selectedIndex) {
    if (_selectedIndex != selectedIndex) {
      setState(() {
        _selectedIndex = selectedIndex;
      });
    }
  }
}
