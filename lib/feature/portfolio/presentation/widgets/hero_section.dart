import 'package:flutter/material.dart';

import 'package:portofolio/config/app_breakpoints.dart';
import 'package:portofolio/core/constants/app_colors.dart';
import 'package:portofolio/feature/portfolio/domain/entities/contact_link.dart';
import 'package:portofolio/feature/portfolio/domain/entities/cv_state.dart';
import 'package:portofolio/feature/portfolio/domain/entities/profile.dart';
import 'package:portofolio/feature/portfolio/presentation/widgets/section_reveal.dart';

/// Hero section with the primary positioning and CTAs.
class HeroSection extends StatelessWidget {
  /// Creates the hero section.
  const HeroSection({
    super.key,
    required this.sectionKey,
    required this.profile,
    required this.links,
    required this.projectCount,
    required this.skillCount,
    required this.languageCount,
    required this.onContactPressed,
    required this.onCvPressed,
    required this.onOpenLink,
  });

  final GlobalKey sectionKey;
  final Profile profile;
  final List<ContactLink> links;
  final int projectCount;
  final int skillCount;
  final int languageCount;
  final VoidCallback onContactPressed;
  final VoidCallback? onCvPressed;
  final Future<void> Function(String url) onOpenLink;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = AppBreakpoints.isDesktop(width);
    final padding = AppBreakpoints.pagePadding(width);
    final maxWidth = AppBreakpoints.maxContentWidth(width);

    return SectionReveal(
      index: 0,
      child: Padding(
        key: sectionKey,
        padding: EdgeInsets.fromLTRB(padding, 0, padding, 96),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: isDesktop ? _buildDesktop(context) : _buildMobile(context),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktop(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 10,
          child: _HeroCopy(
            profile: profile,
            links: links,
            projectCount: projectCount,
            skillCount: skillCount,
            languageCount: languageCount,
            onContactPressed: onContactPressed,
            onCvPressed: onCvPressed,
            onOpenLink: onOpenLink,
          ),
        ),
        const SizedBox(width: 40),
        Expanded(
          flex: 11,
          child: FractionallySizedBox(
            alignment: Alignment.centerRight,
            widthFactor: 0.60,
            child: _HeroVisualCard(profile: profile),
          ),
        ),
      ],
    );
  }

  Widget _buildMobile(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _HeroCopy(
          profile: profile,
          links: links,
          projectCount: projectCount,
          skillCount: skillCount,
          languageCount: languageCount,
          onContactPressed: onContactPressed,
          onCvPressed: onCvPressed,
          onOpenLink: onOpenLink,
        ),
        const SizedBox(height: 28),
        Center(
          child: FractionallySizedBox(
            widthFactor: 0.70,
            child: _HeroVisualCard(profile: profile),
          ),
        ),
      ],
    );
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy({
    required this.profile,
    required this.links,
    required this.projectCount,
    required this.skillCount,
    required this.languageCount,
    required this.onContactPressed,
    required this.onCvPressed,
    required this.onOpenLink,
  });

  final Profile profile;
  final List<ContactLink> links;
  final int projectCount;
  final int skillCount;
  final int languageCount;
  final VoidCallback onContactPressed;
  final VoidCallback? onCvPressed;
  final Future<void> Function(String url) onOpenLink;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final socialLinks = links.where(
      (link) => link.kind != ContactLinkKind.email,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.softAccent,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: AppColors.border),
          ),
          child: Text(
            'Flutter developer crafting product-focused mobile experiences',
            style: textTheme.labelLarge?.copyWith(
              color: AppColors.accent,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 28),
        Text(
          profile.role,
          style: textTheme.titleLarge?.copyWith(color: AppColors.accent),
        ),
        const SizedBox(height: 14),
        Text(
          profile.name,
          style: textTheme.displayLarge?.copyWith(
            fontSize: MediaQuery.sizeOf(context).width >= AppBreakpoints.mobile
                ? 84
                : 58,
          ),
        ),
        const SizedBox(height: 18),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: Text(
            profile.tagline,
            style: textTheme.bodyLarge?.copyWith(
              fontSize: 18,
              color: AppColors.secondaryText,
            ),
          ),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: [
            FilledButton.icon(
              onPressed: onContactPressed,
              icon: const Icon(Icons.send_rounded),
              label: const Text('Contact'),
            ),
            OutlinedButton.icon(
              onPressed: onCvPressed,
              icon: Icon(
                profile.cvState == CvState.available
                    ? Icons.download_rounded
                    : Icons.schedule_rounded,
              ),
              label: Text(
                profile.cvState == CvState.available
                    ? 'Download CV'
                    : 'Download CV · Coming Soon',
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: socialLinks.map((link) {
            return OutlinedButton(
              onPressed: () => onOpenLink(link.url),
              child: Text(link.title),
            );
          }).toList(),
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _MetricPill(label: 'Projects', value: '$projectCount'),
            _MetricPill(label: 'Core Skills', value: '$skillCount'),
            _MetricPill(label: 'Languages', value: '$languageCount'),
          ],
        ),
      ],
    );
  }
}

class _MetricPill extends StatelessWidget {
  const _MetricPill({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: textTheme.titleLarge?.copyWith(color: AppColors.primaryText),
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroVisualCard extends StatelessWidget {
  const _HeroVisualCard({required this.profile});

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    final imageAsset = profile.heroImageAsset;

    return AspectRatio(
      aspectRatio: 0.82,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: AppColors.border),
          boxShadow: const [
            BoxShadow(
              color: Color(0x22000000),
              blurRadius: 32,
              offset: Offset(0, 18),
            ),
            BoxShadow(
              color: Color(0x1139E1C3),
              blurRadius: 80,
              spreadRadius: -12,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(31),
          child: SizedBox.expand(
            child: imageAsset == null
                ? _buildFallbackVisual(context)
                : Image.asset(
                    imageAsset,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildFallbackVisual(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A2330), Color(0xFF10161F), Color(0xFF16232B)],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.person_rounded,
          size: 96,
          color: AppColors.primaryText.withValues(alpha: 0.88),
        ),
      ),
    );
  }
}
