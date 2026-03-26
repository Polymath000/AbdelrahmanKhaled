import 'package:portofolio/feature/portfolio/domain/entities/portfolio_content.dart';
import 'package:portofolio/feature/portfolio/domain/repositories/portfolio_repository.dart';

/// Loads the portfolio content for the landing page.
class GetPortfolioContent {
  /// Creates the use case.
  const GetPortfolioContent(this._repository);

  final PortfolioRepository _repository;

  /// Executes the content loading flow.
  Future<PortfolioContent> call() {
    return _repository.getContent();
  }
}
