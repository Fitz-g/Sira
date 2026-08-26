import 'package:flutter/widgets.dart';

import 'app_colors.dart';

/// Tokens d'espacement Sira — Design System `tokens/spacing.md`.
///
/// L'espacement encode la proximité sémantique : plus deux éléments
/// sont proches, plus ils sont perçus comme liés (loi de Gestalt).
abstract final class AppSpacing {
  /// 0 — continuité visuelle (illustration collée à son titre).
  static const zero = 0.0;

  /// 8 — éléments liés dans une même zone (label → champ, gap entre chips).
  static const sm = 8.0;

  /// 16 — éléments sémantiquement liés (entre deux champs, titre → sous-titre).
  static const md = 16.0;

  /// 24 — sections majeures (header → contenu, entre blocs du dashboard).
  static const lg = 24.0;

  /// 32 — séparation forte (contenu → CTA, avant la barre de navigation).
  static const xl = 32.0;
}

/// Dimensions des conteneurs et rayons de bordure.
abstract final class AppSizes {
  /// Padding horizontal des pages.
  static const paddingPage = 20.0;

  /// Padding interne des cards.
  static const paddingCard = 16.0;

  /// Rayon des cards et des boutons.
  static const radiusCard = 16.0;

  /// Rayon des chips (forme pilule).
  static const radiusChip = 20.0;

  /// Rayon des champs de saisie.
  static const radiusInput = 12.0;

  /// Hauteur minimale d'un bouton primaire.
  static const buttonPrimaryHeight = 56.0;

  /// Hauteur d'un bouton secondaire.
  static const buttonSecondaryHeight = 48.0;

  /// Hauteur d'un champ de saisie.
  static const inputHeight = 52.0;

  /// Hauteur d'un chip sur une ligne (défilement horizontal).
  static const chipHeight = 40.0;

  /// Hauteur d'un chip en grille — accueille deux lignes de texte.
  ///
  /// Uniforme pour tous les chips d'une grille : les libellés longs occupent
  /// deux lignes, les courts restent centrés, et les rangées gardent un
  /// alignement net.
  static const chipHeightGrid = 54.0;

  /// Hauteur de la barre de navigation basse.
  static const navBarHeight = 56.0;

  /// Zone tactile minimale (NFR-A1 : ≥ 44 × 44 pt).
  static const minTouchTarget = 44.0;
}

/// Élévation des surfaces.
abstract final class AppElevation {
  /// Ombre d'une carte posée sur le fond de page.
  ///
  /// Deux couches : une ombre courte qui pose la carte, une plus large et plus
  /// diffuse qui lui donne son volume. C'est ce qui distingue une ombre
  /// crédible d'un halo gris.
  static const card = <BoxShadow>[
    BoxShadow(
      color: AppColors.shadow,
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
    BoxShadow(
      color: AppColors.shadow,
      blurRadius: 12,
      offset: Offset(0, 4),
    ),
  ];
}
