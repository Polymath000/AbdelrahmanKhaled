import 'package:flutter/material.dart';

import 'package:portofolio/config/app_breakpoints.dart';
import 'package:portofolio/core/constants/app_colors.dart';
import 'package:portofolio/feature/portfolio/presentation/widgets/section_reveal.dart';

/// Shared shell for content sections in the one-page layout.
class PortfolioSection extends StatelessWidget {
  /// Creates a section shell.
  const PortfolioSection({
    super.key,
    required this.sectionKey,
    required this.eyebrow,
    required this.title,
    required this.description,
    required this.child,
    required this.revealIndex,
  });

  final GlobalKey sectionKey;
  final String eyebrow;
  final String title;
  final String description;
  final Widget child;
  final int revealIndex;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final padding = AppBreakpoints.pagePadding(width);
    final maxWidth = AppBreakpoints.maxContentWidth(width);
    final textTheme = Theme.of(context).textTheme;

    return SectionReveal(
      index: revealIndex,
      child: Padding(
        key: sectionKey,
        padding: EdgeInsets.fromLTRB(padding, 0, padding, 96),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(width: 48, height: 1, color: AppColors.accent),
                    const SizedBox(width: 12),
                    Text(
                      eyebrow.toUpperCase(),
                      style: textTheme.labelLarge?.copyWith(
                        color: AppColors.accent,
                        letterSpacing: 1.6,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Text(title, style: textTheme.headlineLarge),
                const SizedBox(height: 14),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 720),
                  child: Text(
                    description,
                    style: textTheme.bodyLarge?.copyWith(
                      color: AppColors.secondaryText,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
