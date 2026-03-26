import 'package:portofolio/feature/portfolio/data/services/asset_availability_checker.dart';
import 'package:portofolio/feature/portfolio/data/sources/local_portfolio_data_source.dart';
import 'package:portofolio/feature/portfolio/domain/entities/cv_state.dart';
import 'package:portofolio/feature/portfolio/domain/entities/portfolio_content.dart';
import 'package:portofolio/feature/portfolio/domain/repositories/portfolio_repository.dart';

/// Repository implementation backed by local curated content.
class LocalPortfolioRepository implements PortfolioRepository {
  /// Creates a local repository.
  const LocalPortfolioRepository({
    required this.dataSource,
    required this.assetChecker,
  });

  final LocalPortfolioDataSource dataSource;
  final AssetAvailabilityChecker assetChecker;

  @override
  Future<PortfolioContent> getContent() async {
    final model = await dataSource.getContent();
    final cvState = await _resolveCvState(model.profile.cvAssetPath);

    return model.toDomain(cvState: cvState);
  }

  Future<CvState> _resolveCvState(String? assetPath) async {
    if (assetPath == null) {
      return CvState.comingSoon;
    }

    final exists = await assetChecker.exists(assetPath);

    return exists ? CvState.available : CvState.comingSoon;
  }
}
