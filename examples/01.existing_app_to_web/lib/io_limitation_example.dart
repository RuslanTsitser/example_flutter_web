import 'package:flutter/material.dart';

import 'io_limitation_platform_widget.dart';

/// Экран показывает виджет, подставленный через условный импорт.
/// На web — stub, на платформах с dart:io — виджет из файла с Platform.
class IoLimitationExample extends StatelessWidget {
  const IoLimitationExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ограничение I/O на Web'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Условный импорт виджета:',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          const IoLimitationPlatformWidget(),
        ],
      ),
    );
  }
}
