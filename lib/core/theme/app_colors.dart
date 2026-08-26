import 'package:flutter/material.dart';

/// Palette Sira — Design System `tokens/colors.md`.
///
/// Couleur principale : vert profond `#166534`.
/// Contraste sur blanc 7.4:1 (WCAG AAA).
abstract final class AppColors {
  // --- Couleur principale ---
  /// Boutons CTA, chips actifs, bordures focus, onglet actif.
  static const primary = Color(0xFF166534);

  /// Fonds légèrement teintés — cards insight IA, chips sélectionnés, toasts.
  static const primaryLight = Color(0xFFF0FDF4);

  /// État pressed des éléments primaires.
  static const primaryDark = Color(0xFF14532D);

  /// Texte et icônes sur fond primary.
  static const onPrimary = Color(0xFFFFFFFF);

  // --- Statuts sémantiques ---
  /// Champ valide, service connecté, plus-value, budget sous 80 %, score 71-100.
  static const success = Color(0xFF16A34A);

  /// Budget entre 80 et 100 %, score 41-70.
  static const warning = Color(0xFFD97706);

  /// Erreur de saisie, suppression, moins-value, budget dépassé, score 0-40.
  static const error = Color(0xFFDC2626);

  // --- Surfaces ---
  /// Fond des pages — gris très clair.
  ///
  /// C'est lui qui fait exister les cartes : blanches sur gris, elles se
  /// détachent d'elles-mêmes, sans avoir besoin d'une bordure pour marquer
  /// leur limite. Tout ce qui est contenu ou interactif reste blanc.
  static const surfacePage = Color(0xFFF5F6F8);

  /// Blanc — cartes, champs de saisie, chips au repos.
  static const surface = Color(0xFFFFFFFF);

  /// Fond des cards.
  static const surfaceCard = Color(0xFFFFFFFF);

  /// Ombre portée des cartes. Très diffuse et très peu opaque : elle doit se
  /// deviner, pas se voir.
  static const shadow = Color(0x14101828);

  // --- Échelle de neutres ---
  /// Fond des champs de saisie, chips non sélectionnés, skeletons.
  static const neutral100 = Color(0xFFF5F5F5);

  /// Bordures de cards, bordures de champs au repos, séparateurs.
  static const neutral300 = Color(0xFFD4D4D4);

  /// Placeholders, icônes inactives, onglets inactifs.
  static const neutral500 = Color(0xFF737373);

  /// Labels, légendes, sous-titres.
  static const neutral700 = Color(0xFF404040);

  /// Titres, valeurs, corps de texte.
  static const neutral900 = Color(0xFF171717);

  // --- Alias sémantiques de texte ---
  static const onSurface = neutral900;
  static const onSurfaceSecondary = neutral700;
  static const border = neutral300;
  static const borderFocus = primary;

  /// Couleur de l'arc du score de santé financière selon la valeur (0-100).
  static Color scoreColor(int score) {
    if (score <= 40) return error;
    if (score <= 70) return warning;
    return success;
  }

  /// Couleur d'une barre de budget selon le taux de consommation (0.0 - 1.x).
  static Color budgetColor(double ratio) {
    if (ratio > 1.0) return error;
    if (ratio >= 0.8) return warning;
    return success;
  }
}
