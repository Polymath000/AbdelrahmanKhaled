import 'package:flutter/material.dart';

import 'package:portofolio/config/app_breakpoints.dart';
import 'package:portofolio/feature/portfolio/domain/entities/project_item.dart';
import 'package:portofolio/feature/portfolio/presentation/widgets/portfolio_section.dart';
import 'package:portofolio/feature/portfolio/presentation/widgets/project_card.dart';

/// Shared projects section used for published and training apps.
class ProjectsSection extends StatelessWidget {
  /// Creates a projects section.
  const ProjectsSection({
    super.key,
    required this.sectionKey,
    required this.eyebrow,
    required this.title,
    required this.description,
    required this.projects,
    required this.onOpenLink,
    required this.revealIndex,
    required this.isActive,
  });

  final GlobalKey sectionKey;
  final String eyebrow;
  final String title;
  final String description;
  final List<ProjectItem> projects;
  final Future<void> Function(String url) onOpenLink;
  final int revealIndex;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return PortfolioSection(
      sectionKey: sectionKey,
      eyebrow: eyebrow,
      title: title,
      description: description,
      revealIndex: revealIndex,
      child: _ProjectsLayout(
        projects: projects,
        onOpenLink: onOpenLink,
        isActive: isActive,
      ),
    );
  }
}

class _ProjectsLayout extends StatefulWidget {
  const _ProjectsLayout({
    required this.projects,
    required this.onOpenLink,
    required this.isActive,
  });

  final List<ProjectItem> projects;
  final Future<void> Function(String url) onOpenLink;
  final bool isActive;

  @override
  State<_ProjectsLayout> createState() => _ProjectsLayoutState();
}

class _ProjectsLayoutState extends State<_ProjectsLayout>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 560),
  );

  @override
  void initState() {
    super.initState();
    if (widget.isActive) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && widget.isActive) {
          _controller.forward(from: 0);
        }
      });
    }
  }

  @override
  void didUpdateWidget(covariant _ProjectsLayout oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isActive && !oldWidget.isActive) {
      _controller.forward(from: 0);
    } else if (!widget.isActive && oldWidget.isActive) {
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final columns = _columnCount(width);
        final cardWidth = _cardWidth(width, columns);
        final total = widget.projects.length;

        return Wrap(
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          spacing: 20,
          runSpacing: 20,
          children: widget.projects.asMap().entries.map((entry) {
            final index = entry.key;
            final project = entry.value;

            return _AnimatedProjectCard(
              index: index,
              total: total,
              controller: _controller,
              width: cardWidth,
              child: ProjectCard(
                project: project,
                onOpenLink: widget.onOpenLink,
              ),
            );
          }).toList(),
        );
      },
    );
  }

  int _columnCount(double width) {
    if (width >= AppBreakpoints.mobile) {
      return 3;
    }

    return 1;
  }

  double _cardWidth(double width, int columns) {
    if (columns == 1) {
      return width < 420 ? width : 320;
    }

    final calculated = (width - ((columns - 1) * 20)) / columns;
    return calculated > 320 ? 320 : calculated;
  }
}

class _AnimatedProjectCard extends StatelessWidget {
  const _AnimatedProjectCard({
    required this.index,
    required this.total,
    required this.controller,
    required this.width,
    required this.child,
  });

  final int index;
  final int total;
  final AnimationController controller;
  final double width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final start = total <= 1 ? 0.0 : (index / total) * 0.28;
    final end = (start + 0.52).clamp(0.0, 1.0).toDouble();
    final animation = CurvedAnimation(
      parent: controller,
      curve: Interval(start, end, curve: Curves.easeOutCubic),
    );

    return AnimatedBuilder(
      animation: animation,
      child: SizedBox(width: width, child: child),
      builder: (context, child) {
        final value = animation.value;

        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
    );
  }
}
