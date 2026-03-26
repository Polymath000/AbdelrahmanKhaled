import 'package:flutter/material.dart';

import 'package:portofolio/core/constants/app_colors.dart';
import 'package:portofolio/feature/portfolio/domain/entities/project_item.dart';
import 'package:portofolio/feature/portfolio/domain/entities/project_status.dart';

/// Card used by both featured and archive project grids.
class ProjectCard extends StatefulWidget {
  /// Creates a project card.
  const ProjectCard({
    super.key,
    required this.project,
    required this.onOpenLink,
  });

  final ProjectItem project;
  final Future<void> Function(String url) onOpenLink;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  var _hovered = false;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final textTheme = Theme.of(context).textTheme;

    return MouseRegion(
      onEnter: (_) => _toggleHover(true),
      onExit: (_) => _toggleHover(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()
          ..setTranslationRaw(0, _hovered ? -6.0 : 0.0, 0),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: _hovered ? AppColors.accent : AppColors.border,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0x22000000),
              blurRadius: _hovered ? 36 : 24,
              offset: Offset(0, _hovered ? 18 : 12),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ProjectVisual(imageAsset: project.imageAsset),
            const SizedBox(height: 18),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(project.title, style: textTheme.titleLarge),
                ),
                const SizedBox(width: 12),
                _StatusBadge(status: project.status),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              project.summary,
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.secondaryText,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: project.stack
                  .map(
                    (entry) => Chip(
                      label: Text(entry),
                      backgroundColor: AppColors.softOverlay,
                      side: const BorderSide(color: AppColors.border),
                      labelStyle: textTheme.bodySmall?.copyWith(
                        color: AppColors.secondaryText,
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 18),
            Wrap(spacing: 12, runSpacing: 12, children: _buildActions(project)),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildActions(ProjectItem project) {
    final actions = <Widget>[];

    if (project.repoUrl != null) {
      actions.add(
        OutlinedButton(
          onPressed: () => widget.onOpenLink(project.repoUrl!),
          child: const Text('Source'),
        ),
      );
    }

    if (project.liveUrl != null) {
      actions.add(
        FilledButton(
          onPressed: () => widget.onOpenLink(project.liveUrl!),
          child: const Text('Live'),
        ),
      );
    }

    if (actions.isEmpty) {
      actions.add(
        OutlinedButton(
          onPressed: null,
          child: Text(
            project.status == ProjectStatus.comingSoon
                ? 'Coming Soon'
                : 'Private Build',
          ),
        ),
      );
    }

    return actions;
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

class _ProjectVisual extends StatelessWidget {
  const _ProjectVisual({required this.imageAsset});

  final String? imageAsset;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 174,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF18212C), Color(0xFF121923), Color(0xFF0E141B)],
        ),
        border: Border.all(color: AppColors.border),
      ),
      child: Stack(
        children: [
          Positioned(
            left: -28,
            top: -28,
            child: _GlowCircle(
              size: 108,
              color: AppColors.accent.withValues(alpha: 0.18),
            ),
          ),
          Positioned(
            right: -36,
            bottom: -36,
            child: _GlowCircle(
              size: 140,
              color: AppColors.secondary.withValues(alpha: 0.12),
            ),
          ),
          Center(
            child: Container(
              width: 132,
              height: 132,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F9FC),
                borderRadius: BorderRadius.circular(34),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x33000000),
                    blurRadius: 22,
                    offset: Offset(0, 12),
                  ),
                ],
              ),
              child: imageAsset == null
                  ? Icon(
                      Icons.phone_android_rounded,
                      size: 56,
                      color: AppColors.secondaryText,
                    )
                  : Image.asset(
                      imageAsset!,
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.high,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.phone_android_rounded,
                          size: 56,
                          color: AppColors.secondaryText,
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlowCircle extends StatelessWidget {
  const _GlowCircle({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final ProjectStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      ProjectStatus.public => ('Public', AppColors.accent),
      ProjectStatus.private => ('Private', AppColors.warning),
      ProjectStatus.comingSoon => ('Coming Soon', AppColors.secondary),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: color),
      ),
    );
  }
}
