import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:portofolio/core/services/portfolio_link_launcher.dart';
import 'package:portofolio/feature/portfolio/data/repositories/local_portfolio_repository.dart';
import 'package:portofolio/feature/portfolio/data/services/asset_availability_checker.dart';
import 'package:portofolio/feature/portfolio/data/sources/local_portfolio_data_source.dart';
import 'package:portofolio/feature/portfolio/presentation/widgets/hero_section.dart';
import 'package:portofolio/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  group('PortfolioPage', () {
    testWidgets('renders hero content and CTA group', (tester) async {
      await _pumpPortfolio(tester);

      expect(find.text('Abdelrahman Khaled'), findsWidgets);
      expect(find.text('Mobile Developer (Flutter)'), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(HeroSection),
          matching: find.text('Contact'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(HeroSection),
          matching: find.text('Download CV · Coming Soon'),
        ),
        findsOneWidget,
      );
    });

    testWidgets('renders desktop and mobile layouts without overflow', (
      tester,
    ) async {
      await _pumpPortfolio(tester, size: const Size(1440, 2200));
      expect(tester.takeException(), isNull);

      await _pumpPortfolio(tester, size: const Size(390, 2200));
      expect(tester.takeException(), isNull);
    });

    testWidgets('shows the expected skills and projects', (tester) async {
      await _pumpPortfolio(tester);

      expect(find.text('Flutter'), findsWidgets);
      expect(find.text('Firebase'), findsWidgets);
      await tester.scrollUntilVisible(
        find.text('QuickNotion'),
        500,
        scrollable: find.byType(Scrollable),
      );
      expect(find.text('QuickNotion'), findsOneWidget);
      await tester.scrollUntilVisible(
        find.text('MindFeed'),
        500,
        scrollable: find.byType(Scrollable),
      );
      expect(find.text('MindFeed'), findsOneWidget);
    });

    testWidgets('keeps the CV button disabled when the asset is missing', (
      tester,
    ) async {
      await _pumpPortfolio(tester);

      final button = tester.widget<OutlinedButton>(
        find.widgetWithText(OutlinedButton, 'Download CV · Coming Soon'),
      );

      expect(button.onPressed, isNull);
    });
  });
}

Future<void> _pumpPortfolio(
  WidgetTester tester, {
  Size size = const Size(1400, 2200),
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    PortfolioApp(
      repository: LocalPortfolioRepository(
        dataSource: const LocalPortfolioDataSource(),
        assetChecker: const _FakeAssetChecker(false),
      ),
      linkLauncher: const _FakeLinkLauncher(),
    ),
  );

  await tester.pump();
  await tester.pump(const Duration(seconds: 2));
}

class _FakeAssetChecker implements AssetAvailabilityChecker {
  const _FakeAssetChecker(this._exists);

  final bool _exists;

  @override
  Future<bool> exists(String assetPath) async => _exists;
}

class _FakeLinkLauncher implements PortfolioLinkLauncher {
  const _FakeLinkLauncher();

  @override
  Future<bool> openExternal(String url) async => true;
}
