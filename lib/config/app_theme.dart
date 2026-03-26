import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:portofolio/core/constants/app_colors.dart';

/// Builds the global theme for the portfolio.
ThemeData buildAppTheme() {
  final bodyTextTheme = GoogleFonts.ibmPlexSansTextTheme();
  final headingTextTheme = GoogleFonts.spaceGroteskTextTheme(bodyTextTheme);

  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.dark(
      surface: AppColors.surface,
      primary: AppColors.accent,
      secondary: AppColors.secondary,
      onPrimary: AppColors.background,
      onSurface: AppColors.primaryText,
      onSecondary: AppColors.primaryText,
      error: Color(0xFFF7768E),
    ),
    textTheme: _buildTextTheme(bodyTextTheme, headingTextTheme),
    dividerColor: AppColors.border,
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
    hoverColor: AppColors.softOverlay,
    iconTheme: const IconThemeData(color: AppColors.primaryText),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.background,
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
        textStyle: headingTextTheme.titleSmall?.copyWith(
          color: AppColors.background,
          fontWeight: FontWeight.w700,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryText,
        side: const BorderSide(color: AppColors.border),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
        textStyle: headingTextTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w700,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.surfaceRaised,
      disabledColor: AppColors.surfaceRaised,
      selectedColor: AppColors.softAccent,
      secondarySelectedColor: AppColors.softAccent,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      side: const BorderSide(color: AppColors.border),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      labelStyle: bodyTextTheme.bodyMedium?.copyWith(
        color: AppColors.primaryText,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

TextTheme _buildTextTheme(TextTheme bodyTextTheme, TextTheme headingTextTheme) {
  return bodyTextTheme.copyWith(
    displayLarge: headingTextTheme.displayLarge?.copyWith(
      color: AppColors.primaryText,
      fontWeight: FontWeight.w700,
      height: 0.95,
    ),
    displayMedium: headingTextTheme.displayMedium?.copyWith(
      color: AppColors.primaryText,
      fontWeight: FontWeight.w700,
      height: 1,
    ),
    headlineLarge: headingTextTheme.headlineLarge?.copyWith(
      color: AppColors.primaryText,
      fontWeight: FontWeight.w700,
    ),
    headlineMedium: headingTextTheme.headlineMedium?.copyWith(
      color: AppColors.primaryText,
      fontWeight: FontWeight.w700,
    ),
    titleLarge: headingTextTheme.titleLarge?.copyWith(
      color: AppColors.primaryText,
      fontWeight: FontWeight.w700,
    ),
    titleMedium: headingTextTheme.titleMedium?.copyWith(
      color: AppColors.primaryText,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: bodyTextTheme.bodyLarge?.copyWith(
      color: AppColors.primaryText,
      height: 1.7,
    ),
    bodyMedium: bodyTextTheme.bodyMedium?.copyWith(
      color: AppColors.secondaryText,
      height: 1.7,
    ),
    bodySmall: bodyTextTheme.bodySmall?.copyWith(
      color: AppColors.mutedText,
      height: 1.6,
    ),
    labelLarge: headingTextTheme.labelLarge?.copyWith(
      color: AppColors.primaryText,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.2,
    ),
  );
}
