import 'package:flutter/material.dart';
import 'package:fluxwalls/views/categories/categories_screen.dart';
import 'package:fluxwalls/views/discover/discover_screen.dart';
import 'package:fluxwalls/views/downloads/downloads_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  // List of screens for the navigation
  final List<Widget> _screens = [
    DiscoverScreen(),
    const CategoriesScreen(),
    const DownloadsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack preserves the state of all child widgets
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: const Color(0xFF13ecda).withOpacity(0.2),
          labelTextStyle: WidgetStateProperty.all(
            Theme.of(context).textTheme.titleSmall,
          ),
        ),
        child: NavigationBar(
          backgroundColor: const Color(0xFF102220).withOpacity(0.95),
          selectedIndex: _selectedIndex,
          onDestinationSelected: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home, color: Color(0xFF13ecda)),
              label: 'Discover',
            ),
            NavigationDestination(
              icon: Icon(Icons.grid_view_outlined),
              selectedIcon: Icon(Icons.grid_view, color: Color(0xFF13ecda)),
              label: 'Categories',
            ),
            NavigationDestination(
              icon: Icon(Icons.download_for_offline_outlined),
              selectedIcon: Icon(
                Icons.download_for_offline,
                color: Color(0xFF13ecda),
              ),
              label: 'Downloads',
            ),
          ],
        ),
      ),
    );
  }
}
