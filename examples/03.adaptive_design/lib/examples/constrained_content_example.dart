import 'package:flutter/material.dart';

/// Контент по центру с maxWidth 600px.
class ConstrainedContentExample extends StatelessWidget {
  const ConstrainedContentExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: const Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Этот текст не растягивается шире 600px. '
            'На широком экране блок остаётся по центру.',
          ),
        ),
      ),
    );
  }
}
