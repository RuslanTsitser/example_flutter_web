import 'package:flutter/material.dart';
import 'examples/adaptive_navigation_example.dart';
import 'examples/constrained_content_example.dart';
import 'examples/layout_orientation_example.dart';
import 'examples/responsive_grid_example.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Адаптивный дизайн (Web)',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const _HomePage(),
      routes: <String, WidgetBuilder>{
        '/grid': (_) => Scaffold(
              appBar: AppBar(title: const Text('Адаптивная сетка')),
              body: const ResponsiveGridExample(),
            ),
        '/constrained': (_) => Scaffold(
              appBar: AppBar(title: const Text('Ограниченный контент')),
              body: const ConstrainedContentExample(),
            ),
        '/navigation': (_) => const AdaptiveNavigationExample(),
        '/layout': (_) => Scaffold(
              appBar: AppBar(title: const Text('LayoutBuilder и OrientationBuilder')),
              body: const LayoutOrientationExample(),
            ),
      },
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Адаптивный дизайн для Web'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Измените размер окна браузера.'),
          const SizedBox(height: 16),
          _ExampleCard(title: 'LayoutBuilder + OrientationBuilder', description: 'Узко/широко и портрет/ландшафт', icon: Icons.build, route: '/layout'),
          _ExampleCard(title: 'Адаптивная сетка', description: '1–3 колонки по ширине', icon: Icons.grid_view, route: '/grid'),
          _ExampleCard(title: 'Ограниченный контент', description: 'maxWidth 600px по центру', icon: Icons.text_fields, route: '/constrained'),
          _ExampleCard(title: 'Адаптивная навигация', description: 'Drawer или NavigationRail', icon: Icons.menu, route: '/navigation'),
        ],
      ),
    );
  }
}

class _ExampleCard extends StatelessWidget {
  const _ExampleCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.route,
  });

  final String title;
  final String description;
  final IconData icon;
  final String route;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(title),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () => Navigator.of(context).pushNamed(route),
      ),
    );
  }
}
