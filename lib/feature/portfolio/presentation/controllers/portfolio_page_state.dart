import 'package:portofolio/feature/portfolio/domain/entities/portfolio_content.dart';
import 'package:portofolio/feature/portfolio/presentation/models/portfolio_section_id.dart';

/// Load lifecycle of the portfolio page.
enum PortfolioLoadStatus { loading, ready, error }

/// Presentation state consumed by the portfolio page.
class PortfolioPageState {
  /// Creates a page state.
  const PortfolioPageState({
    this.status = PortfolioLoadStatus.loading,
    this.activeSection = PortfolioSectionId.hero,
    this.content,
    this.errorMessage,
  });

  final PortfolioLoadStatus status;
  final PortfolioSectionId activeSection;
  final PortfolioContent? content;
  final String? errorMessage;

  /// Creates a modified copy of the current state.
  PortfolioPageState copyWith({
    PortfolioLoadStatus? status,
    PortfolioSectionId? activeSection,
    PortfolioContent? content,
    String? errorMessage,
  }) {
    return PortfolioPageState(
      status: status ?? this.status,
      activeSection: activeSection ?? this.activeSection,
      content: content ?? this.content,
      errorMessage: errorMessage,
    );
  }
}
