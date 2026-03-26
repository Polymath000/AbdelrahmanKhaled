import 'package:portofolio/feature/portfolio/domain/entities/project_status.dart';

/// A project shown in the portfolio.
class ProjectItem {
  /// Creates a project item.
  const ProjectItem({
    required this.title,
    required this.summary,
    required this.stack,
    required this.status,
    this.repoUrl,
    this.liveUrl,
    this.imageAsset,
  });

  final String title;
  final String summary;
  final List<String> stack;
  final ProjectStatus status;
  final String? repoUrl;
  final String? liveUrl;
  final String? imageAsset;
}
