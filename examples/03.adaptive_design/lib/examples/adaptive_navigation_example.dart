import 'package:flutter/material.dart';

/// Узкий экран — Drawer, широкий — NavigationRail.
class AdaptiveNavigationExample extends StatefulWidget {
  const AdaptiveNavigationExample({super.key});

  @override
  State<AdaptiveNavigationExample> createState() =>
      _AdaptiveNavigationExampleState();
}

class _AdaptiveNavigationExampleState extends State<AdaptiveNavigationExample> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 600;

    if (wide) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: _index,
              onDestinationSelected: (i) => setState(() => _index = i),
              destinations: const [
                NavigationRailDestination(icon: Icon(Icons.home), label: Text('Главная')),
                NavigationRailDestination(icon: Icon(Icons.settings), label: Text('Настройки')),
              ],
            ),
            const VerticalDivider(width: 1),
            Expanded(child: Center(child: Text('Раздел: $_index'))),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Меню')),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Главная'),
              selected: _index == 0,
              onTap: () {
                setState(() => _index = 0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Настройки'),
              selected: _index == 1,
              onTap: () {
                setState(() => _index = 1);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(child: Text('Раздел: $_index')),
    );
  }
}
