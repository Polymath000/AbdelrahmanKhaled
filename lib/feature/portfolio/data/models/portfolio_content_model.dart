import 'package:portofolio/feature/portfolio/domain/entities/contact_link.dart';
import 'package:portofolio/feature/portfolio/domain/entities/cv_state.dart';
import 'package:portofolio/feature/portfolio/domain/entities/language_skill.dart';
import 'package:portofolio/feature/portfolio/domain/entities/portfolio_content.dart';
import 'package:portofolio/feature/portfolio/domain/entities/profile.dart';
import 'package:portofolio/feature/portfolio/domain/entities/project_item.dart';
import 'package:portofolio/feature/portfolio/domain/entities/project_status.dart';
import 'package:portofolio/feature/portfolio/domain/entities/skill_group.dart';

/// Local model representation of the portfolio payload.
class PortfolioContentModel {
  /// Creates a content model.
  const PortfolioContentModel({
    required this.profile,
    required this.skillGroups,
    required this.languages,
    required this.featuredProjects,
    required this.archiveProjects,
    required this.contactLinks,
  });

  final ProfileModel profile;
  final List<SkillGroupModel> skillGroups;
  final List<LanguageSkillModel> languages;
  final List<ProjectItemModel> featuredProjects;
  final List<ProjectItemModel> archiveProjects;
  final List<ContactLinkModel> contactLinks;

  /// Maps the model into a domain entity.
  PortfolioContent toDomain({required CvState cvState}) {
    return PortfolioContent(
      profile: profile.toDomain(cvState: cvState),
      skillGroups: skillGroups.map((item) => item.toDomain()).toList(),
      languages: languages.map((item) => item.toDomain()).toList(),
      featuredProjects: featuredProjects
          .map((item) => item.toDomain())
          .toList(),
      archiveProjects: archiveProjects.map((item) => item.toDomain()).toList(),
      contactLinks: contactLinks.map((item) => item.toDomain()).toList(),
    );
  }
}

/// Local model for profile content.
class ProfileModel {
  /// Creates a profile model.
  const ProfileModel({
    required this.name,
    required this.role,
    required this.tagline,
    required this.bio,
    required this.interests,
    this.heroImageAsset,
    this.cvAssetPath,
  });

  final String name;
  final String role;
  final String tagline;
  final String bio;
  final List<String> interests;
  final String? heroImageAsset;
  final String? cvAssetPath;

  /// Maps the model into a domain entity.
  Profile toDomain({required CvState cvState}) {
    return Profile(
      name: name,
      role: role,
      tagline: tagline,
      bio: bio,
      interests: interests,
      heroImageAsset: heroImageAsset,
      cvAssetPath: cvAssetPath,
      cvState: cvState,
    );
  }
}

/// Local model for skill groups.
class SkillGroupModel {
  /// Creates a skill group model.
  const SkillGroupModel({required this.title, required this.skills});

  final String title;
  final List<String> skills;

  /// Maps the model into a domain entity.
  SkillGroup toDomain() {
    return SkillGroup(title: title, skills: skills);
  }
}

/// Local model for language entries.
class LanguageSkillModel {
  /// Creates a language model.
  const LanguageSkillModel({required this.name, required this.level});

  final String name;
  final String level;

  /// Maps the model into a domain entity.
  LanguageSkill toDomain() {
    return LanguageSkill(name: name, level: level);
  }
}

/// Local model for project entries.
class ProjectItemModel {
  /// Creates a project model.
  const ProjectItemModel({
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

  /// Maps the model into a domain entity.
  ProjectItem toDomain() {
    return ProjectItem(
      title: title,
      summary: summary,
      stack: stack,
      status: status,
      repoUrl: repoUrl,
      liveUrl: liveUrl,
      imageAsset: imageAsset,
    );
  }
}

/// Local model for contact actions.
class ContactLinkModel {
  /// Creates a contact link model.
  const ContactLinkModel({
    required this.title,
    required this.value,
    required this.url,
    required this.kind,
  });

  final String title;
  final String value;
  final String url;
  final ContactLinkKind kind;

  /// Maps the model into a domain entity.
  ContactLink toDomain() {
    return ContactLink(title: title, value: value, url: url, kind: kind);
  }
}
