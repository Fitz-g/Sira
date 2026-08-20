import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Échelle typographique Sira — Design System `tokens/typography.md`.
///
/// 9 tokens de 14 px à 56 px. Chaque token porte sa taille, sa graisse
/// et sa hauteur de ligne par défaut ; la couleur reste surchargeable.
abstract final class AppTypography {
  /// Inter — embarquée dans `assets/fonts/`, déclarée dans `pubspec.yaml`.
  ///
  /// Nommée explicitement dans chaque style plutôt que laissée à l'héritage :
  /// un widget monté hors `MaterialApp` (un test, un aperçu) doit rendre le
  /// même texte qu'en production.
  static const family = 'Inter';

  static const _heading = 1.2; // hauteur de ligne des titres
  static const _body = 1.5; // hauteur de ligne du corps de texte

  /// 56 px / 900 — chiffre héroïque (score santé, montant en saisie).
  static const heading4xl = TextStyle(
    fontFamily: family,
    fontSize: 56,
    fontWeight: FontWeight.w900,
    height: _heading,
    color: AppColors.onSurface,
  );

  /// 44 px / 900 — chiffre clé (mensualité de simulation).
  static const heading3xl = TextStyle(
    fontFamily: family,
    fontSize: 44,
    fontWeight: FontWeight.w900,
    height: _heading,
    color: AppColors.onSurface,
  );

  /// 36 px / 900 — valeur mise en avant (headline splash, cours, prix).
  static const heading2xl = TextStyle(
    fontFamily: family,
    fontSize: 36,
    fontWeight: FontWeight.w900,
    height: _heading,
    color: AppColors.onSurface,
  );

  /// 30 px / 700 — titre de page en début de flux (inscription, onboarding).
  static const headingXl = TextStyle(
    fontFamily: family,
    fontSize: 30,
    fontWeight: FontWeight.w700,
    height: _heading,
    color: AppColors.onSurface,
  );

  /// 24 px / 700 — titre de page principal (dashboard, détail).
  static const headingLg = TextStyle(
    fontFamily: family,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: _heading,
    color: AppColors.onSurface,
  );

  /// 20 px / 600 — titre de page standard.
  static const headingMd = TextStyle(
    fontFamily: family,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: _heading,
    color: AppColors.onSurface,
  );

  /// 18 px / 700 — texte de CTA, valeurs métriques.
  static const headingSm = TextStyle(
    fontFamily: family,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    height: _heading,
    color: AppColors.onSurface,
  );

  /// 16 px / 400 — corps de texte, boutons secondaires, insights.
  static const headingXs = TextStyle(
    fontFamily: family,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: _body,
    color: AppColors.onSurface,
  );

  /// 14 px / 400 — labels, légendes, onglets de navigation.
  static const headingXxs = TextStyle(
    fontFamily: family,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: _body,
    color: AppColors.onSurfaceSecondary,
  );

  /// Passe un style en chiffres à chasse fixe.
  ///
  /// Sans cela, un « 1 » est plus étroit qu'un « 8 » et deux montants
  /// superposés ne s'alignent pas — défaut visible dès qu'une colonne de
  /// sommes se lit de haut en bas.
  static TextStyle tabular(TextStyle style) => style.copyWith(
        fontFeatures: const [FontFeature.tabularFigures()],
      );
}
