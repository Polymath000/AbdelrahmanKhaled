import 'package:flutter/material.dart';
import 'package:portofolio/config/app_theme.dart';
import 'package:portofolio/core/services/portfolio_link_launcher.dart';
import 'package:portofolio/feature/portfolio/data/repositories/local_portfolio_repository.dart';
import 'package:portofolio/feature/portfolio/data/services/asset_availability_checker.dart';
import 'package:portofolio/feature/portfolio/data/sources/local_portfolio_data_source.dart';
import 'package:portofolio/feature/portfolio/domain/repositories/portfolio_repository.dart';
import 'package:portofolio/feature/portfolio/domain/usecases/get_portfolio_content.dart';
import 'package:portofolio/feature/portfolio/presentation/views/portfolio_page.dart';

void main() {
  runApp(const PortfolioApp());
}

/// Root application widget for Abdelrahman's portfolio.
class PortfolioApp extends StatelessWidget {
  /// Creates the portfolio application.
  const PortfolioApp({super.key, this.repository, this.linkLauncher});

  final PortfolioRepository? repository;
  final PortfolioLinkLauncher? linkLauncher;

  @override
  Widget build(BuildContext context) {
    final portfolioRepository = repository ?? _buildRepository();

    return MaterialApp(
      title: 'Abdelrahman Khaled',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: PortfolioPage(
        getPortfolioContent: GetPortfolioContent(portfolioRepository),
        linkLauncher: linkLauncher ?? const UrlLauncherService(),
      ),
    );
  }

  PortfolioRepository _buildRepository() {
    return LocalPortfolioRepository(
      dataSource: const LocalPortfolioDataSource(),
      assetChecker: const BundleAssetAvailabilityChecker(),
    );
  }
}
