import 'package:portofolio/feature/portfolio/domain/entities/portfolio_content.dart';

/// Source of portfolio content for presentation.
abstract class PortfolioRepository {
  /// Returns the complete portfolio payload.
  Future<PortfolioContent> getContent();
}
