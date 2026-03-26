import 'package:flutter/material.dart';

import 'package:portofolio/config/app_breakpoints.dart';
import 'package:portofolio/core/constants/app_colors.dart';
import 'package:portofolio/feature/portfolio/domain/entities/contact_link.dart';
import 'package:portofolio/feature/portfolio/presentation/widgets/portfolio_section.dart';

/// Contact section with direct outbound actions.
class ContactSection extends StatelessWidget {
  /// Creates the contact section.
  const ContactSection({
    super.key,
    required this.sectionKey,
    required this.links,
    required this.onOpenLink,
  });

  final GlobalKey sectionKey;
  final List<ContactLink> links;
  final Future<void> Function(String url) onOpenLink;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = AppBreakpoints.isDesktop(width);

    return PortfolioSection(
      sectionKey: sectionKey,
      eyebrow: 'Contact',
      title: 'Let’s build something useful together.',
      description:
          'If you are hiring, collaborating, or just want to talk Flutter, these are the fastest ways to reach me.',
      revealIndex: 5,
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        children: links.map((link) {
          return _ContactCard(
            link: link,
            width: isDesktop ? (width - 160) / 2 : double.infinity,
            onOpenLink: onOpenLink,
          );
        }).toList(),
      ),
    );
  }
}

class _ContactCard extends StatefulWidget {
  const _ContactCard({
    required this.link,
    required this.width,
    required this.onOpenLink,
  });

  final ContactLink link;
  final double width;
  final Future<void> Function(String url) onOpenLink;

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  var _hovered = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: widget.width == double.infinity ? 0 : widget.width,
        maxWidth: widget.width,
      ),
      child: MouseRegion(
        onEnter: (_) => _toggleHover(true),
        onExit: (_) => _toggleHover(false),
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: () => widget.onOpenLink(widget.link.url),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: _hovered ? AppColors.accent : AppColors.border,
              ),
            ),
            child: Row(
              children: [
                _IconBubble(kind: widget.link.kind),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.link.title, style: textTheme.titleLarge),
                      const SizedBox(height: 6),
                      Text(widget.link.value, style: textTheme.bodyMedium),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                const Icon(Icons.north_east_rounded),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _toggleHover(bool hovered) {
    if (_hovered == hovered) {
      return;
    }

    setState(() {
      _hovered = hovered;
    });
  }
}

class _IconBubble extends StatelessWidget {
  const _IconBubble({required this.kind});

  final ContactLinkKind kind;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.softAccent,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Icon(switch (kind) {
        ContactLinkKind.email => Icons.mail_outline_rounded,
        ContactLinkKind.linkedIn => Icons.work_outline_rounded,
        ContactLinkKind.github => Icons.code_rounded,
        ContactLinkKind.youtube => Icons.play_circle_outline_rounded,
      }, color: AppColors.accent),
    );
  }
}
