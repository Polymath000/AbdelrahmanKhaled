import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:portofolio/config/app_breakpoints.dart';
import 'package:portofolio/core/constants/app_colors.dart';
import 'package:portofolio/feature/portfolio/presentation/models/portfolio_section_id.dart';

/// Sticky top navigation for the one-page portfolio.
class PortfolioNavBar extends StatelessWidget {
  /// Creates the navigation bar.
  const PortfolioNavBar({
    super.key,
    required this.activeSection,
    required this.onSectionSelected,
  });

  final PortfolioSectionId activeSection;
  final Future<void> Function(PortfolioSectionId section) onSectionSelected;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = AppBreakpoints.isDesktop(width);
    final horizontalInset = AppBreakpoints.pagePadding(width);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalInset),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: isDesktop ? 1180 : 680),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xB8141A22),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.border),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x22000000),
                      blurRadius: 32,
                      offset: Offset(0, 18),
                    ),
                  ],
                ),
                child: isDesktop
                    ? _buildDesktop(context)
                    : _buildMobile(context),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktop(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Abdelrahman Khaled', style: textTheme.titleMedium),
            Text('Flutter mobile developer', style: textTheme.bodySmall),
          ],
        ),
        const Spacer(),
        Wrap(
          spacing: 8,
          children: PortfolioSectionId.values.map(_buildNavButton).toList(),
        ),
      ],
    );
  }

  Widget _buildMobile(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('AK', style: textTheme.titleMedium),
            Text(
              activeSection.navLabel,
              style: textTheme.bodySmall?.copyWith(color: AppColors.accent),
            ),
          ],
        ),
        const Spacer(),
        PopupMenuButton<PortfolioSectionId>(
          color: AppColors.surfaceRaised,
          surfaceTintColor: Colors.transparent,
          icon: const Icon(Icons.menu_rounded),
          onSelected: _selectSection,
          itemBuilder: (context) {
            return PortfolioSectionId.values.map((section) {
              return PopupMenuItem<PortfolioSectionId>(
                value: section,
                child: Text(section.navLabel),
              );
            }).toList();
          },
        ),
      ],
    );
  }

  Widget _buildNavButton(PortfolioSectionId section) {
    final isActive = activeSection == section;

    return TextButton(
      onPressed: () => _selectSection(section),
      style: TextButton.styleFrom(
        foregroundColor: isActive
            ? AppColors.background
            : AppColors.primaryText,
        backgroundColor: isActive ? AppColors.accent : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Text(section.navLabel),
    );
  }

  void _selectSection(PortfolioSectionId section) {
    onSectionSelected(section);
  }
}
