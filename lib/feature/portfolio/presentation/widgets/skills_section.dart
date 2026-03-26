import 'package:flutter/material.dart';

import 'package:portofolio/config/app_breakpoints.dart';
import 'package:portofolio/core/constants/app_colors.dart';
import 'package:portofolio/feature/portfolio/domain/entities/language_skill.dart';
import 'package:portofolio/feature/portfolio/domain/entities/skill_group.dart';
import 'package:portofolio/feature/portfolio/presentation/widgets/portfolio_section.dart';

/// Skills section with grouped chips and language proficiency.
class SkillsSection extends StatelessWidget {
  /// Creates the skills section.
  const SkillsSection({
    super.key,
    required this.sectionKey,
    required this.skillGroups,
    required this.languages,
  });

  final GlobalKey sectionKey;
  final List<SkillGroup> skillGroups;
  final List<LanguageSkill> languages;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = AppBreakpoints.isDesktop(width);

    return PortfolioSection(
      sectionKey: sectionKey,
      eyebrow: 'Skills',
      title: 'Tools and strengths I reach for most.',
      description:
          'A balanced stack across Flutter product work, systems fluency, and practical design collaboration.',
      revealIndex: 2,
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        children: [
          ...skillGroups.map((group) {
            return _SkillCard(
              title: group.title,
              entries: group.skills,
              width: isDesktop ? (width - 140) / 3 : width,
            );
          }),
          _SkillCard(
            title: 'Languages',
            entries: languages
                .map((item) => '${item.name} (${item.level})')
                .toList(),
            width: isDesktop ? (width - 140) / 3 : width,
          ),
        ],
      ),
    );
  }
}

class _SkillCard extends StatelessWidget {
  const _SkillCard({
    required this.title,
    required this.entries,
    required this.width,
  });

  final String title;
  final List<String> entries;
  final double width;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: width == double.infinity ? 0 : width,
        maxWidth: width,
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: textTheme.titleLarge),
            const SizedBox(height: 18),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: entries
                  .map(
                    (entry) => IgnorePointer(
                      child: Chip(
                        label: Text(entry),
                        backgroundColor: AppColors.softOverlay,
                        labelStyle: textTheme.bodyMedium?.copyWith(
                          color: AppColors.secondaryText,
                        ),
                        side: const BorderSide(color: AppColors.border),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
