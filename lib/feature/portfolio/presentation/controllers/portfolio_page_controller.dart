import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:portofolio/feature/portfolio/domain/usecases/get_portfolio_content.dart';
import 'package:portofolio/feature/portfolio/presentation/controllers/portfolio_page_state.dart';
import 'package:portofolio/feature/portfolio/presentation/models/portfolio_section_id.dart';

/// Coordinates loading and scroll-aware state for the portfolio page.
class PortfolioPageController extends ValueNotifier<PortfolioPageState> {
  /// Creates a page controller.
  PortfolioPageController({
    required GetPortfolioContent getPortfolioContent,
    ScrollController? scrollController,
  }) : _getPortfolioContent = getPortfolioContent,
       scrollController = scrollController ?? ScrollController(),
       super(const PortfolioPageState()) {
    this.scrollController.addListener(_handleScroll);
  }

  final GetPortfolioContent _getPortfolioContent;
  final ScrollController scrollController;
  final Map<PortfolioSectionId, GlobalKey> _sectionKeys = {
    for (final section in PortfolioSectionId.values) section: GlobalKey(),
  };

  /// Returns the global key for a section.
  GlobalKey sectionKey(PortfolioSectionId section) {
    return _sectionKeys[section]!;
  }

  /// Loads the content rendered by the page.
  Future<void> load() async {
    try {
      final content = await _getPortfolioContent();

      value = value.copyWith(
        status: PortfolioLoadStatus.ready,
        content: content,
        errorMessage: null,
      );

      _scheduleSync();
    } catch (error) {
      value = value.copyWith(
        status: PortfolioLoadStatus.error,
        errorMessage: 'Unable to load the portfolio content.',
      );
    }
  }

  /// Scrolls smoothly to the requested section.
  Future<void> scrollTo(PortfolioSectionId section) async {
    final context = sectionKey(section).currentContext;

    if (context == null) {
      return;
    }

    await Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
      alignment: 0.04,
    );
  }

  /// Recomputes the currently active section from the rendered layout.
  void syncActiveSection() {
    final resolved = _resolveActiveSection();

    if (resolved == value.activeSection) {
      return;
    }

    value = value.copyWith(activeSection: resolved);
  }

  void _handleScroll() {
    syncActiveSection();
  }

  PortfolioSectionId _resolveActiveSection() {
    final offsets = <PortfolioSectionId, double>{};

    for (final entry in _sectionKeys.entries) {
      final context = entry.value.currentContext;
      final renderBox = context?.findRenderObject() as RenderBox?;

      if (renderBox == null || !renderBox.hasSize) {
        continue;
      }

      offsets[entry.key] = renderBox.localToGlobal(Offset.zero).dy;
    }

    if (offsets.isEmpty) {
      return value.activeSection;
    }

    final triggerLine = scrollController.hasClients
        ? math.max(420.0, scrollController.position.viewportDimension * 0.68)
        : 420.0;

    final pastHeader = offsets.entries.where(
      (entry) => entry.value <= triggerLine,
    );

    if (pastHeader.isNotEmpty) {
      return pastHeader.reduce((left, right) {
        return left.value > right.value ? left : right;
      }).key;
    }

    return offsets.entries.reduce((left, right) {
      return left.value < right.value ? left : right;
    }).key;
  }

  void _scheduleSync() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      syncActiveSection();
    });
  }

  @override
  void dispose() {
    scrollController.removeListener(_handleScroll);
    scrollController.dispose();
    super.dispose();
  }
}
