import 'package:flutter_test/flutter_test.dart';

import 'package:portofolio/feature/portfolio/data/repositories/local_portfolio_repository.dart';
import 'package:portofolio/feature/portfolio/data/services/asset_availability_checker.dart';
import 'package:portofolio/feature/portfolio/data/sources/local_portfolio_data_source.dart';
import 'package:portofolio/feature/portfolio/domain/entities/cv_state.dart';
import 'package:portofolio/feature/portfolio/domain/entities/project_status.dart';

void main() {
  group('LocalPortfolioRepository', () {
    late LocalPortfolioRepository repository;

    setUp(() {
      repository = LocalPortfolioRepository(
        dataSource: const LocalPortfolioDataSource(),
        assetChecker: const _FakeAssetChecker(false),
      );
    });

    test(
      'returns Abdelrahman profile and the expected content split',
      () async {
        final content = await repository.getContent();

        expect(content.profile.name, 'Abdelrahman Khaled');
        expect(content.profile.role, 'Mobile Developer (Flutter)');
        expect(content.contactLinks, hasLength(4));
        expect(content.skillGroups, hasLength(3));
        expect(content.languages, hasLength(2));
        expect(content.featuredProjects, hasLength(4));
        expect(content.archiveProjects, hasLength(4));
      },
    );

    test('marks QuickNotion and the missing CV as coming soon', () async {
      final content = await repository.getContent();
      final quickNotion = content.featuredProjects.first;

      expect(quickNotion.title, 'QuickNotion');
      expect(quickNotion.status, ProjectStatus.comingSoon);
      expect(quickNotion.repoUrl, isNull);
      expect(content.profile.cvState, CvState.comingSoon);
    });
  });
}

class _FakeAssetChecker implements AssetAvailabilityChecker {
  const _FakeAssetChecker(this._exists);

  final bool _exists;

  @override
  Future<bool> exists(String assetPath) async => _exists;
}
