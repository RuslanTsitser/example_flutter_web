import 'package:flutter/material.dart';

/// Адаптивная сетка: 1 колонка на узком экране, 2–3 на широком.
class ResponsiveGridExample extends StatelessWidget {
  const ResponsiveGridExample({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final count = constraints.maxWidth < 600 ? 1 : (constraints.maxWidth < 900 ? 2 : 3);
        return GridView.count(
          padding: const EdgeInsets.all(16),
          crossAxisCount: count,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: [
            _Card('1', Icons.star),
            _Card('2', Icons.favorite),
            _Card('3', Icons.bookmark),
            _Card('4', Icons.place),
          ],
        );
      },
    );
  }
}

class _Card extends StatelessWidget {
  const _Card(this.title, this.icon);

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 32),
            const SizedBox(height: 4),
            Text(title),
          ],
        ),
      ),
    );
  }
}
