import 'package:flutter/material.dart';
import 'package:portofolio/config/app_breakpoints.dart';
import 'package:portofolio/core/constants/app_colors.dart';
import 'package:portofolio/core/services/portfolio_link_launcher.dart';
import 'package:portofolio/feature/portfolio/domain/entities/cv_state.dart';
import 'package:portofolio/feature/portfolio/domain/entities/portfolio_content.dart';
import 'package:portofolio/feature/portfolio/domain/entities/profile.dart';
import 'package:portofolio/feature/portfolio/domain/usecases/get_portfolio_content.dart';
import 'package:portofolio/feature/portfolio/presentation/controllers/portfolio_page_controller.dart';
import 'package:portofolio/feature/portfolio/presentation/controllers/portfolio_page_state.dart';
import 'package:portofolio/feature/portfolio/presentation/models/portfolio_section_id.dart';
import 'package:portofolio/feature/portfolio/presentation/widgets/about_section.dart';
import 'package:portofolio/feature/portfolio/presentation/widgets/ambient_background.dart';
import 'package:portofolio/feature/portfolio/presentation/widgets/contact_section.dart';
import 'package:portofolio/feature/portfolio/presentation/widgets/footer_section.dart';
import 'package:portofolio/feature/portfolio/presentation/widgets/hero_section.dart';
import 'package:portofolio/feature/portfolio/presentation/widgets/portfolio_nav_bar.dart';
import 'package:portofolio/feature/portfolio/presentation/widgets/projects_section.dart';
import 'package:portofolio/feature/portfolio/presentation/widgets/skills_section.dart';

/// One-page portfolio experience for Abdelrahman Khaled.
class PortfolioPage extends StatefulWidget {
  /// Creates the portfolio page.
  const PortfolioPage({
    super.key,
    required this.getPortfolioContent,
    required this.linkLauncher,
  });

  final GetPortfolioContent getPortfolioContent;
  final PortfolioLinkLauncher linkLauncher;

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  late final PortfolioPageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PortfolioPageController(
      getPortfolioContent: widget.getPortfolioContent,
    )..load();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SelectionArea(
        child: ValueListenableBuilder<PortfolioPageState>(
          valueListenable: _controller,
          builder: (context, state, _) {
            return switch (state.status) {
              PortfolioLoadStatus.loading => _buildLoadingState(context),
              PortfolioLoadStatus.error => _buildErrorState(context),
              PortfolioLoadStatus.ready => _buildReadyState(context, state),
            };
          },
        ),
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return const Stack(
      children: [
        Positioned.fill(child: AmbientBackground()),
        Center(child: CircularProgressIndicator(color: AppColors.accent)),
      ],
    );
  }

  Widget _buildErrorState(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Stack(
      children: [
        const Positioned.fill(child: AmbientBackground()),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Something went wrong.', style: textTheme.headlineMedium),
                const SizedBox(height: 12),
                Text(
                  'Please refresh the page and try again.',
                  style: textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReadyState(BuildContext context, PortfolioPageState state) {
    final content = state.content!;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.syncActiveSection();
    });

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final publishedApps = content.featuredProjects.take(1).toList();
        final trainingApps = [
          ...content.featuredProjects.skip(1),
          ...content.archiveProjects,
        ];

        return Stack(
          children: [
            const Positioned.fill(child: AmbientBackground()),
            CustomScrollView(
              controller: _controller.scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: width >= AppBreakpoints.mobile ? 128 : 112,
                  ),
                ),
                SliverToBoxAdapter(
                  child: HeroSection(
                    sectionKey: _controller.sectionKey(PortfolioSectionId.hero),
                    profile: content.profile,
                    links: content.contactLinks,
                    projectCount:
                        content.featuredProjects.length +
                        content.archiveProjects.length,
                    skillCount: _skillCount(content),
                    languageCount: content.languages.length,
                    onContactPressed: _scrollToContact,
                    onCvPressed: _cvActionFor(content.profile),
                    onOpenLink: _openLink,
                  ),
                ),
                SliverToBoxAdapter(
                  child: AboutSection(
                    sectionKey: _controller.sectionKey(
                      PortfolioSectionId.about,
                    ),
                    profile: content.profile,
                    skillCount: _skillCount(content),
                    projectCount:
                        content.featuredProjects.length +
                        content.archiveProjects.length,
                    languageCount: content.languages.length,
                  ),
                ),
                SliverToBoxAdapter(
                  child: SkillsSection(
                    sectionKey: _controller.sectionKey(
                      PortfolioSectionId.skills,
                    ),
                    skillGroups: content.skillGroups,
                    languages: content.languages,
                  ),
                ),
                SliverToBoxAdapter(
                  child: ProjectsSection(
                    sectionKey: _controller.sectionKey(
                      PortfolioSectionId.featuredWork,
                    ),
                    eyebrow: 'Published Apps',
                    title: 'Apps shipped or getting ready to ship.',
                    description:
                        'QuickNotion is the app I am actively preparing for release, and it leads the product-facing side of the portfolio.',
                    projects: publishedApps,
                    onOpenLink: _openLink,
                    revealIndex: 3,
                    isActive:
                        state.activeSection == PortfolioSectionId.featuredWork,
                  ),
                ),
                SliverToBoxAdapter(
                  child: ProjectsSection(
                    sectionKey: _controller.sectionKey(
                      PortfolioSectionId.projectArchive,
                    ),
                    eyebrow: 'Training Apps',
                    title: 'Practice builds and learning projects.',
                    description:
                        'The rest of the apps live here, where I iterate on Flutter, UI polish, and delivery habits.',
                    projects: trainingApps,
                    onOpenLink: _openLink,
                    revealIndex: 4,
                    isActive:
                        state.activeSection ==
                        PortfolioSectionId.projectArchive,
                  ),
                ),
                SliverToBoxAdapter(
                  child: ContactSection(
                    sectionKey: _controller.sectionKey(
                      PortfolioSectionId.contact,
                    ),
                    links: content.contactLinks,
                    onOpenLink: _openLink,
                  ),
                ),
                const SliverToBoxAdapter(child: FooterSection()),
              ],
            ),
            Positioned(
              top: 16,
              left: 0,
              right: 0,
              child: PortfolioNavBar(
                activeSection: state.activeSection,
                onSectionSelected: _controller.scrollTo,
              ),
            ),
          ],
        );
      },
    );
  }

  int _skillCount(PortfolioContent content) {
    return content.skillGroups.fold<int>(0, (sum, group) {
      return sum + group.skills.length;
    });
  }

  VoidCallback? _cvActionFor(Profile profile) {
    if (profile.cvState != CvState.available || profile.cvAssetPath == null) {
      return null;
    }

    return () {
      final resolvedUrl = Uri.base.resolve(profile.cvAssetPath!).toString();
      _openLink(resolvedUrl);
    };
  }

  void _scrollToContact() {
    _controller.scrollTo(PortfolioSectionId.contact);
  }

  Future<void> _openLink(String url) async {
    final opened = await widget.linkLauncher.openExternal(url);

    if (!mounted || opened) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Unable to open the link right now.')),
    );
  }
}
