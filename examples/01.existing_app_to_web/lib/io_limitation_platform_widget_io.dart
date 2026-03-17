import 'dart:io' show Platform;

import 'package:flutter/material.dart';

/// Виджет для платформ с dart:io. Прямой импорт этого файла на web сломает сборку.
class IoLimitationPlatformWidget extends StatelessWidget {
  const IoLimitationPlatformWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(
        context,
      ).colorScheme.primaryContainer.withValues(alpha: 0.3),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Platform.operatingSystem,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'dart:io доступен. Виджет из io_limitation_platform_widget_io.dart',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
