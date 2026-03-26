# Project Context

## Purpose
- Personal one-page Flutter web portfolio for Abdelrahman Khaled.
- Tone: dark-first, premium tech editorial, inspired by `mynrd.co.uk` without copying it.
- Primary goals: showcase Flutter work, skills, and direct contact links.

## Architecture
- `lib/config/`: shared theme and breakpoint configuration.
- `lib/core/`: shared color tokens and external link launcher abstraction.
- `lib/feature/portfolio/domain/`: entities, repository contract, and use case.
- `lib/feature/portfolio/data/`: local content source, content models, repository implementation, and optional asset availability checker.
- `lib/feature/portfolio/presentation/`: page controller, section ids, and all one-page widgets.

## Section Map
- `hero`: name, role, tagline, social quick links, contact CTA, and CV CTA fallback.
- `about`: concise bio, interests, and quick highlights.
- `skills`: grouped technical skills plus language proficiency.
- `featured_work`: QuickNotion, InsightMed, FilmVault, and Nazm.
- `project_archive`: Calculator, Passwordy, Airport MMAA Database, and MindFeed.
- `contact`: email, LinkedIn, GitHub, and YouTube.
- `footer`: closing signature and Flutter web note.

## Content Ownership
- Portfolio content is defined in `LocalPortfolioDataSource`.
- Public project summaries are based on the linked GitHub README content where available.
- `QuickNotion` is intentionally private and represented as a coming-soon flagship project.
- CV download is prepared through `profile.cvAssetPath`, but the current asset is absent, so the UI resolves to `CvState.comingSoon`.

## Assets & Visual Rules
- The current portrait is bundled at `assets/images/myPhoto.jpg` and wired through `ProfileModel.heroImageAsset`.
- Project cards use branded gradient visuals without the old placeholder label.
- The UI still falls back to abstract visuals when optional image assets are missing.
- If a future CV PDF is added, place it at `assets/docs/abdelrahman_khaled_cv.pdf` and register it in `pubspec.yaml`.

## Testing Notes
- Repository tests should verify profile data, featured/archive splits, and the CV fallback state.
- Widget tests should cover hero rendering, mobile/desktop stability, skills/project visibility, and the disabled CV state.
- The app currently depends only on `google_fonts` and `url_launcher`.

## Deployment Notes
- Target: GitHub Pages.
- Build with a repo-specific base href when the GitHub repository exists, for example:
  `flutter build web --base-href /<repo-name>/`
- Publish the generated `build/web` output through GitHub Pages or a `gh-pages` branch.
- `web/index.html` and `web/manifest.json` already use portfolio-specific metadata and dark theme colors.
