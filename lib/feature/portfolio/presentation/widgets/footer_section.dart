import 'package:flutter/material.dart';

import 'package:portofolio/config/app_breakpoints.dart';
import 'package:portofolio/core/constants/app_colors.dart';

/// Closing footer for the portfolio page.
class FooterSection extends StatelessWidget {
  /// Creates the footer.
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final padding = AppBreakpoints.pagePadding(width);
    final maxWidth = AppBreakpoints.maxContentWidth(width);
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.fromLTRB(padding, 0, padding, 48),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Abdelrahman Khaled · Built with Flutter for the web.',
                    style: textTheme.bodyMedium,
                  ),
                ),
                Text('2026', style: textTheme.bodySmall),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
