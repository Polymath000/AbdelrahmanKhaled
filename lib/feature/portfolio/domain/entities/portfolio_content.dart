import 'package:portofolio/feature/portfolio/domain/entities/contact_link.dart';
import 'package:portofolio/feature/portfolio/domain/entities/language_skill.dart';
import 'package:portofolio/feature/portfolio/domain/entities/profile.dart';
import 'package:portofolio/feature/portfolio/domain/entities/project_item.dart';
import 'package:portofolio/feature/portfolio/domain/entities/skill_group.dart';

/// Full content payload rendered by the portfolio page.
class PortfolioContent {
  /// Creates a portfolio content payload.
  const PortfolioContent({
    required this.profile,
    required this.skillGroups,
    required this.languages,
    required this.featuredProjects,
    required this.archiveProjects,
    required this.contactLinks,
  });

  final Profile profile;
  final List<SkillGroup> skillGroups;
  final List<LanguageSkill> languages;
  final List<ProjectItem> featuredProjects;
  final List<ProjectItem> archiveProjects;
  final List<ContactLink> contactLinks;

  /// Returns a copy with a new profile instance.
  PortfolioContent copyWithProfile(Profile nextProfile) {
    return PortfolioContent(
      profile: nextProfile,
      skillGroups: skillGroups,
      languages: languages,
      featuredProjects: featuredProjects,
      archiveProjects: archiveProjects,
      contactLinks: contactLinks,
    );
  }
}
