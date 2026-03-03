import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.description,
    required this.showViewMore,
    required this.onViewMore,
  });

  final String title;
  final String? description;
  final bool showViewMore;
  final VoidCallback onViewMore;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: textTheme.titleMedium),
              if (description != null) ...[
                const SizedBox(height: 2),
                Text(
                  description!,
                  style: textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (showViewMore)
          TextButton(
            onPressed: onViewMore,
            child: const Text('Ver más'),
          ),
      ],
    );
  }
}


