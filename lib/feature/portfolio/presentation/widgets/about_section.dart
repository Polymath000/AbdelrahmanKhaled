import 'package:flutter/material.dart';

import 'package:portofolio/config/app_breakpoints.dart';
import 'package:portofolio/core/constants/app_colors.dart';
import 'package:portofolio/feature/portfolio/domain/entities/profile.dart';
import 'package:portofolio/feature/portfolio/presentation/widgets/portfolio_section.dart';

/// About section with profile summary and quick highlights.
class AboutSection extends StatelessWidget {
  /// Creates the about section.
  const AboutSection({
    super.key,
    required this.sectionKey,
    required this.profile,
    required this.skillCount,
    required this.projectCount,
    required this.languageCount,
  });

  final GlobalKey sectionKey;
  final Profile profile;
  final int skillCount;
  final int projectCount;
  final int languageCount;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = AppBreakpoints.isDesktop(width);

    return PortfolioSection(
      sectionKey: sectionKey,
      eyebrow: 'About',
      title: 'A builder who enjoys shipping clear, practical products.',
      description:
          'This portfolio focuses on honest work samples, clean structure, and a product-minded approach to Flutter development.',
      revealIndex: 1,
      child: isDesktop ? _buildDesktop(context) : _buildMobile(context),
    );
  }

  Widget _buildDesktop(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 11, child: _AboutCopy(profile: profile)),
        const SizedBox(width: 24),
        Expanded(
          flex: 9,
          child: _AboutHighlights(
            skillCount: skillCount,
            projectCount: projectCount,
            languageCount: languageCount,
          ),
        ),
      ],
    );
  }

  Widget _buildMobile(BuildContext context) {
    return Column(
      children: [
        _AboutCopy(profile: profile),
        const SizedBox(height: 24),
        _AboutHighlights(
          skillCount: skillCount,
          projectCount: projectCount,
          languageCount: languageCount,
        ),
      ],
    );
  }
}

class _AboutCopy extends StatelessWidget {
  const _AboutCopy({required this.profile});

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(28),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            profile.bio,
            style: textTheme.bodyLarge?.copyWith(color: AppColors.primaryText),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: profile.interests.map((interest) {
              return IgnorePointer(
                child: Chip(
                  label: Text(interest),
                  backgroundColor: AppColors.softOverlay,
                  labelStyle: textTheme.bodyMedium?.copyWith(
                    color: AppColors.secondaryText,
                  ),
                  side: const BorderSide(color: AppColors.border),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _AboutHighlights extends StatelessWidget {
  const _AboutHighlights({
    required this.skillCount,
    required this.projectCount,
    required this.languageCount,
  });

  final int skillCount;
  final int projectCount;
  final int languageCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _HighlightTile(
          title: 'Projects',
          value: '$projectCount',
          description:
              'Public builds and a private flagship release in progress.',
        ),
        const SizedBox(height: 16),
        _HighlightTile(
          title: 'Core Skills',
          value: '$skillCount',
          description:
              'Flutter-first engineering supported by systems and tooling knowledge.',
        ),
        const SizedBox(height: 16),
        _HighlightTile(
          title: 'Languages',
          value: '$languageCount',
          description:
              'Arabic native communication with strong working English.',
        ),
      ],
    );
  }
}

class _HighlightTile extends StatelessWidget {
  const _HighlightTile({
    required this.title,
    required this.value,
    required this.description,
  });

  final String title;
  final String value;
  final String description;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: textTheme.headlineMedium?.copyWith(color: AppColors.accent),
          ),
          const SizedBox(height: 8),
          Text(title, style: textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(description, style: textTheme.bodyMedium),
        ],
      ),
    );
  }
}

BoxDecoration _cardDecoration() {
  return BoxDecoration(
    color: AppColors.surface,
    borderRadius: BorderRadius.circular(28),
    border: Border.all(color: AppColors.border),
  );
}
