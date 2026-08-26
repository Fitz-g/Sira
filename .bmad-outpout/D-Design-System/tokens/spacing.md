# Tokens d'Espacement

**Design System ID :** `tokens-spacing`
**Extrait de :** 24 spécifications de pages (Phase 4)
**Date :** 2026-05-01

---

## Échelle d'Espacement

5 tokens sémantiques extraits des specs. L'espacement est relationnel : il exprime la proximité sémantique entre éléments.

| Token | Valeur | Rôle sémantique | Quand l'utiliser |
|-------|--------|-----------------|------------------|
| `space-zero` | 0px | Continuité visuelle | Illustration → headline quand ils forment une unité |
| `space-sm` | 8px | Éléments liés dans la même zone | Grid gap entre chips, entre boutons côte à côte, label → champ |
| `space-md` | 16px | Éléments sémantiquement liés | Label de section → son groupe, séparateur → formulaire |
| `space-lg` | 24px | Sections majeures | Header → contenu, entre sections du dashboard, respiration |
| `space-xl` | 32px | Séparation forte | Contenu → CTA, section → navigation bar, safe area |

---

## Principes d'Application

### Loi de proximité (Gestalt)

Plus deux éléments sont proches, plus ils semblent liés. L'espacement encode la structure sémantique :

```
┌────────────────────────────┐
│  Titre section              │
│  ↕ space-sm (8px)           │  ← liés : titre décrit le contenu
│  Contenu de la section      │
│                             │
│  ↕ space-lg (24px)          │  ← séparés : nouvelle section
│                             │
│  Titre section suivante     │
│  ↕ space-sm (8px)           │
│  Contenu                    │
│                             │
│  ↕ space-xl (32px)          │  ← fort : avant le CTA
│                             │
│  [ Bouton CTA ]             │
└────────────────────────────┘
```

### Règles extraites des specs

| Contexte | Token | Rationale |
|----------|-------|-----------|
| Label → son champ de formulaire | `space-sm` | Visuellement couplés |
| Entre champs d'un même formulaire | `space-md` | Liés mais distincts |
| Illustration → headline (splash) | `space-zero` | Unité visuelle |
| Header → premier contenu | `space-lg` | Respiration après le titre |
| Entre sections dashboard | `space-lg` | Sections liées mais indépendantes |
| Dernière section → CTA | `space-xl` | Séparation nette avant l'action |
| Contenu → bottom nav bar | `space-xl` | Safe area + séparation |
| Grid gap entre chips (2 colonnes) | `space-sm` | Items d'un même ensemble |
| Entre boutons actions rapides | `space-sm` | Actions au même niveau |

---

## Espacement des Conteneurs

| Token | Valeur | Usage |
|-------|--------|-------|
| `padding-page` | 20px | Padding horizontal des pages |
| `padding-card` | 16px | Padding interne des cards |
| `radius-card` | 16px | Rayon des cards et des boutons |
| `radius-chip` | 20px | Rayon de bordure des chips (pill) |
| `radius-input` | 12px | Rayon des champs de saisie |

---

## Safe Areas

| Zone | Valeur | Usage |
|------|--------|-------|
| `safe-area-top` | Status bar height (dynamique) | Espace au-dessus du header |
| `safe-area-bottom` | Home indicator height (dynamique) | Espace sous la navigation bar |
| `nav-bar-height` | 56px | Hauteur de la bottom tab bar |

---

## Implémentation Flutter

`lib/core/theme/app_spacing.dart`

```dart
abstract final class AppSpacing {
  static const zero = 0.0;
  static const sm   = 8.0;
  static const md   = 16.0;
  static const lg   = 24.0;
  static const xl   = 32.0;
}

abstract final class AppSizes {
  static const paddingPage = 20.0;
  static const paddingCard = 16.0;
  static const radiusCard  = 16.0;
  static const radiusChip  = 20.0;
  static const radiusInput = 12.0;
  static const navBarHeight = 56.0;
  static const minTouchTarget = 44.0; // NFR-A1
}
```

---

_Extrait du Design System — App Finance UEMOA_
