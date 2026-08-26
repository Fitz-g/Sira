# Tokens de Couleurs

**Design System ID :** `tokens-colors`
**Extrait de :** 24 spécifications de pages (Phase 4)
**Date :** 2026-05-01

---

## Palette Sémantique

6 rôles de couleur identifiés à travers les 24 specs. Les valeurs exactes (hex) seront définies en Phase Visual [W]. Ce fichier définit les **rôles** et leurs usages.

### Couleurs Fonctionnelles

| Token | Rôle | Usages clés |
|-------|------|-------------|
| `color-primary` | Identité brand, actions principales | CTA, chips sélectionnés, progress bars, toggle on, nav active, focus borders, arc score vert |
| `color-primary-light` | Fond teinté subtil | Card insight IA, bande contexte profil, fond chips sélectionnés |
| `color-on-primary` | Texte sur primary | Texte bouton CTA, icône sur fond primary |
| `color-surface-page` | Fond des pages — gris très clair `#F5F6F8` | Background de toutes les pages |
| `color-surface` | Blanc | Cards, champs de saisie, chips au repos |
| `color-surface-card` | Fond des cards — blanc | Background des cards informationnelles |
| `color-shadow` | Ombre portée `#101828` à 8 % | Élévation des cards |
| `color-on-surface` | Texte principal | Titres, corps de texte, valeurs |
| `color-on-surface-secondary` | Texte secondaire | Labels, légendes, placeholders, nav inactive |
| `color-border` | Bordures par défaut | Bordures champs de saisie, séparateurs, dividers |
| `color-border-focus` | Bordure champ en focus | Bordure active des inputs (= color-primary) |

### Couleurs Sémantiques (Statuts)

| Token | Rôle | Usages clés |
|-------|------|-------------|
| `color-success` | Positif, validé, connecté | Champ valide, statut "connecté" (09.2), P&L positif (07.x), budget <80%, score 71-100 |
| `color-warning` | Attention, limite proche | Budget 80-100% (02.3), score 41-70 (01.6) |
| `color-error` | Négatif, erreur, danger | Erreur champ, bouton supprimer, P&L négatif, budget >100%, score 0-40, déconnexion (09.1) |

### Couleurs Neutres

| Token | Rôle | Usages clés |
|-------|------|-------------|
| `color-neutral-100` | Fond neutre clair | Fond chips non sélectionnés, fond inputs, skeleton loaders |
| `color-neutral-300` | Bordures légères | Bordures cards, bordures boutons secondaires, dividers |
| `color-neutral-500` | Texte tertiaire | Placeholders, icônes inactives |
| `color-neutral-700` | Texte secondaire | Labels, légendes, sous-titres |
| `color-neutral-900` | Texte principal | Titres, valeurs, corps de texte |

---

## Application par Composant

| Composant | Fond | Texte | Bordure | Accent |
|-----------|------|-------|---------|--------|
| **PrimaryButton** | `color-primary` | `color-on-primary` | — | — |
| **PrimaryButton (disabled)** | `color-primary` @ 40% | `color-on-primary` | — | — |
| **SecondaryButton** | transparent | `color-primary` | `color-primary` | — |
| **TextInput (default)** | `color-neutral-100` | `color-on-surface` | `color-border` | — |
| **TextInput (focus)** | `color-neutral-100` | `color-on-surface` | `color-primary` | — |
| **TextInput (error)** | `color-neutral-100` | `color-on-surface` | `color-error` | `color-error` (message) |
| **TextInput (valid)** | `color-neutral-100` | `color-on-surface` | `color-success` | — |
| **Chip (default)** | `color-neutral-100` | `color-neutral-700` | — | — |
| **Chip (selected)** | `color-primary-light` | `color-primary` | `color-primary` | — |
| **Card** | `color-surface-card` | `color-on-surface` | `color-neutral-300` | — |
| **Toast** | `color-primary-light` | `color-primary` | — | — |
| **Nav bar (active)** | — | `color-primary` | — | `color-primary` |
| **Nav bar (inactive)** | — | `color-neutral-500` | — | — |
| **Score 0-40** | — | — | — | `color-error` |
| **Score 41-70** | — | — | — | `color-warning` |
| **Score 71-100** | — | — | — | `color-success` |
| **Budget <80%** | — | — | — | `color-success` |
| **Budget 80-100%** | — | — | — | `color-warning` |
| **Budget >100%** | — | — | — | `color-error` |

---

## Modes Clair / Sombre

Le mode sombre n'est pas prioritaire au MVP. L'architecture des tokens le prépare :

| Token | Clair | Sombre (futur) |
|-------|-------|----------------|
| `color-surface` | blanc | gris-900 |
| `color-surface-card` | blanc | gris-800 |
| `color-on-surface` | gris-900 | blanc |
| `color-on-surface-secondary` | gris-700 | gris-400 |
| `color-border` | gris-300 | gris-600 |
| `color-neutral-100` | gris-100 | gris-800 |

Les couleurs sémantiques (`primary`, `success`, `warning`, `error`) restent identiques dans les deux modes.

---

## Implémentation Flutter

`lib/core/theme/app_colors.dart` — valeurs arrêtées le 2026-05-03.

```dart
abstract final class AppColors {
  static const primary      = Color(0xFF166534); // vert profond, 7.4:1 sur blanc
  static const primaryLight = Color(0xFFF0FDF4);
  static const primaryDark  = Color(0xFF14532D);
  static const onPrimary    = Color(0xFFFFFFFF);

  static const success = Color(0xFF16A34A);
  static const warning = Color(0xFFD97706);
  static const error   = Color(0xFFDC2626);

  static const surface     = Color(0xFFFFFFFF);
  static const surfaceCard = Color(0xFFFFFFFF);

  static const neutral100 = Color(0xFFF5F5F5);
  static const neutral300 = Color(0xFFD4D4D4);
  static const neutral500 = Color(0xFF737373);
  static const neutral700 = Color(0xFF404040);
  static const neutral900 = Color(0xFF171717);
}
```

Deux fonctions dérivent la couleur d'un statut : `AppColors.scoreColor(int)`
pour le score de santé financière, `AppColors.budgetColor(double)` pour le taux
de consommation d'une enveloppe budgétaire.

---

_Extrait du Design System — App Finance UEMOA_


---

## Révision du 2026-08-21 — profondeur par contraste

Jusqu'ici : cartes blanches sur fond blanc, séparées par un filet gris d'un
pixel. Résultat plat, qui évoquait le formulaire administratif plus que le
produit.

**Ce qui change :** le fond de page devient gris très clair, les cartes restent
blanches et portent une ombre douce. La bordure disparaît — ce sont le contraste
et l'ombre qui délimitent la carte, pas un trait.

**Conséquence obligatoire :** tout ce qui était en `color-neutral-100` et posé
directement sur la page — chips au repos, champs de saisie — passe au **blanc**.
Un gris clair sur un fond gris clair devient invisible.

La règle tient en une phrase : **le fond de page est gris, tout ce qui porte du
contenu ou reçoit une interaction est blanc.**

La teinte de marque est inchangée. Le changement de perception vient de la
structure, pas de la couleur.
