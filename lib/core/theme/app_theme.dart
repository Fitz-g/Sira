import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_typography.dart';

/// Thème Material dérivé des tokens du Design System.
///
/// Les widgets du dossier `shared/widgets/` s'appuient directement sur
/// [AppColors] / [AppTypography] ; ce thème couvre les widgets Material
/// natifs (dialogs, pickers, sélection de texte…) pour rester cohérent.
abstract final class AppTheme {
  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    ).copyWith(
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
      error: AppColors.error,
    );

    return ThemeData(
      useMaterial3: true,
      fontFamily: AppTypography.family,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.surfacePage,
      textTheme: const TextTheme(
        displayLarge: AppTypography.heading4xl,
        displayMedium: AppTypography.heading3xl,
        displaySmall: AppTypography.heading2xl,
        headlineLarge: AppTypography.headingXl,
        headlineMedium: AppTypography.headingLg,
        headlineSmall: AppTypography.headingMd,
        titleMedium: AppTypography.headingSm,
        bodyLarge: AppTypography.headingXs,
        bodyMedium: AppTypography.headingXxs,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surfacePage,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: AppTypography.headingMd,
        iconTheme: IconThemeData(color: AppColors.onSurface),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.neutral300,
        thickness: 1,
        space: 1,
      ),
      cardTheme: CardThemeData(
        color: AppColors.surfaceCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusCard),
        ),
      ),
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
    );
  }
}
