import 'package:flutter/material.dart';

/// Пример: LayoutBuilder и OrientationBuilder.
/// LayoutBuilder — по ограничениям (узко/широко), OrientationBuilder — портрет/ландшафт.
class LayoutOrientationExample extends StatelessWidget {
  const LayoutOrientationExample({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final narrow = constraints.maxWidth < 600;
        return OrientationBuilder(
          builder: (context, orientation) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _InfoChip(
                      label: narrow ? 'Узко (< 600px)' : 'Широко (≥ 600px)',
                      icon: narrow ? Icons.straighten : Icons.aspect_ratio,
                    ),
                    const SizedBox(height: 16),
                    _InfoChip(
                      label: orientation == Orientation.portrait
                          ? 'Портрет'
                          : 'Ландшафт',
                      icon: orientation == Orientation.portrait
                          ? Icons.stay_current_portrait
                          : Icons.stay_current_landscape,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, color: Theme.of(context).colorScheme.onSurfaceVariant),
      label: Text(label),
    );
  }
}
