/// Shared viewport breakpoints for the portfolio layout.
abstract final class AppBreakpoints {
  static const double mobile = 768;
  static const double desktop = 1200;

  static bool isDesktop(double width) => width >= desktop;

  static bool isTablet(double width) {
    return width >= mobile && width < desktop;
  }

  static double pagePadding(double width) {
    if (isDesktop(width)) {
      return 40;
    }

    if (isTablet(width)) {
      return 28;
    }

    return 20;
  }

  static double maxContentWidth(double width) {
    if (isDesktop(width)) {
      return 1240;
    }

    if (isTablet(width)) {
      return 960;
    }

    return 680;
  }
}
