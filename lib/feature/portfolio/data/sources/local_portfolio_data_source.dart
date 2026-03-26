import 'package:portofolio/feature/portfolio/data/models/portfolio_content_model.dart';
import 'package:portofolio/feature/portfolio/domain/entities/contact_link.dart';
import 'package:portofolio/feature/portfolio/domain/entities/project_status.dart';

/// Local source of curated portfolio content.
class LocalPortfolioDataSource {
  /// Creates the local content source.
  const LocalPortfolioDataSource();

  /// Returns the local content payload.
  Future<PortfolioContentModel> getContent() async {
    return const PortfolioContentModel(
      profile: ProfileModel(
        name: 'Abdelrahman Khaled',
        role: 'Mobile Developer (Flutter)',
        tagline:
            'I build thoughtful Flutter products with clean structure, strong UX, and a love for shipping ideas well.',
        bio:
            'I am Abdelrahman Khaled, a Flutter-focused mobile developer who loves programming, tech in general, and reading. I enjoy turning ideas into polished apps that feel clear, fast, and reliable.',
        interests: ['Programming', 'Tech', 'Reading'],
        heroImageAsset: 'assets/images/myPhoto.jpg',
        cvAssetPath: 'assets/docs/abdelrahman_khaled_cv.pdf',
      ),
      skillGroups: [
        SkillGroupModel(
          title: 'Mobile Stack',
          skills: ['Flutter', 'Dart', 'Firebase'],
        ),
        SkillGroupModel(
          title: 'Systems & Engineering',
          skills: ['Linux', 'Python', 'C++', 'Git', 'Docker', 'Bash'],
        ),
        SkillGroupModel(title: 'Product & Design', skills: ['Qt', 'Figma']),
      ],
      languages: [
        LanguageSkillModel(name: 'Arabic', level: 'Native'),
        LanguageSkillModel(name: 'English', level: 'Good'),
      ],
      featuredProjects: [
        ProjectItemModel(
          title: 'QuickNotion',
          summary:
              'A private Flutter app for capturing ideas quickly and syncing them to Notion through OAuth, database search, and property-aware page creation.',
          stack: ['Flutter', 'Dart', 'Notion API', 'Bloc/Cubit', 'GetIt'],
          status: ProjectStatus.comingSoon,
          imageAsset: 'assets/images/QuickNotio.png',
        ),
        ProjectItemModel(
          title: 'InsightMed',
          summary:
              'A medical workflow app for appointments, clinician notes, and AI-assisted chest X-ray reviews with role-aware flows.',
          stack: ['Flutter', 'Dart', 'flutter_bloc', 'Dio', 'GetIt'],
          status: ProjectStatus.public,
          repoUrl: 'https://github.com/Polymath000/InsightMed',
          imageAsset: 'assets/images/InsghtMed.png',
        ),
        ProjectItemModel(
          title: 'FilmVault',
          summary:
              'A movie browsing app with adaptive theming, localization, Arabic support, and upgrade alerts.',
          stack: ['Flutter', 'Dart', 'Localization', 'Theming'],
          status: ProjectStatus.public,
          repoUrl: 'https://github.com/Polymath000/FilmVault',
          imageAsset: 'assets/images/FilmValut.png',
        ),
        ProjectItemModel(
          title: 'Nazm',
          summary:
              'A minimalist offline-first productivity app with tasks, calendar views, Firebase sync, and polished onboarding.',
          stack: ['Flutter', 'Dart', 'Firebase', 'Hive', 'Bloc/Cubit'],
          status: ProjectStatus.public,
          repoUrl: 'https://github.com/Polymath000/Nazm',
          imageAsset: 'assets/images/nazm.png',
        ),
      ],
      archiveProjects: [
        ProjectItemModel(
          title: 'Calculator',
          summary:
              'A modern calculator focused on clean UI, responsive layout, and fast everyday arithmetic.',
          stack: ['Flutter', 'Dart'],
          status: ProjectStatus.public,
          repoUrl: 'https://github.com/Polymath000/Calculator',
          imageAsset: 'assets/images/calculator.png',
        ),
        ProjectItemModel(
          title: 'Passwordy',
          summary:
              'A secure password generator with customizable rules and one-tap clipboard-friendly output.',
          stack: ['Flutter', 'Dart', 'Security UX'],
          status: ProjectStatus.public,
          repoUrl: 'https://github.com/Polymath000/Passwordy',
          imageAsset: 'assets/images/Passwordy.png',
        ),
        ProjectItemModel(
          title: 'Airport MMAA Database',
          summary:
              'A team database project focused on modeling airport operations, bookings, facilities, and related workflows.',
          stack: ['Database Design', 'Data Modeling', 'Team Collaboration'],
          status: ProjectStatus.public,
          repoUrl:
              'https://github.com/abdelrhmannaser845/Airport_datarbase_MMAA',
        ),
        ProjectItemModel(
          title: 'MindFeed',
          summary:
              'A UI-focused reading experience that showcases clean architecture, onboarding, search, collections, and settings flows.',
          stack: ['Flutter', 'Dart', 'BLoC', 'GetIt', 'Dio'],
          status: ProjectStatus.public,
          repoUrl: 'https://github.com/Polymath000/MindFeed',
          imageAsset: 'assets/images/MindFeed.png',
        ),
      ],
      contactLinks: [
        ContactLinkModel(
          title: 'Email',
          value: 'abdalrahmankhaled642004@gmail.com',
          url: 'mailto:abdalrahmankhaled642004@gmail.com',
          kind: ContactLinkKind.email,
        ),
        ContactLinkModel(
          title: 'LinkedIn',
          value: 'linkedin.com/in/polymath00',
          url: 'https://www.linkedin.com/in/polymath00/',
          kind: ContactLinkKind.linkedIn,
        ),
        ContactLinkModel(
          title: 'GitHub',
          value: 'github.com/Polymath000',
          url: 'https://github.com/Polymath000',
          kind: ContactLinkKind.github,
        ),
        ContactLinkModel(
          title: 'YouTube',
          value: '@UCVJuwkj9DZFaq9Ia6j5C5EA',
          url: 'https://www.youtube.com/channel/UCVJuwkj9DZFaq9Ia6j5C5EA',
          kind: ContactLinkKind.youtube,
        ),
      ],
    );
  }
}
