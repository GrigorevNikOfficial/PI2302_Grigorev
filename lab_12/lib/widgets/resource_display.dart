import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class ResourceDisplay extends StatelessWidget {
  const ResourceDisplay({
    super.key,
    required this.title,
    required this.lines,
    this.footer,
  });

  final String title;
  final List<String> lines;
  final String? footer;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: AppColors.displayCard,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.displayBorder, width: 2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            for (final line in lines)
              Text(
                line,
                style: textTheme.bodyLarge?.copyWith(color: Colors.black),
              ),
            if (footer != null) ...[
              const SizedBox(height: 10),
              Text(
                footer!,
                style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
