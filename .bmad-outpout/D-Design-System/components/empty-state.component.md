# EmptyState

**Design System ID :** `empty-state`
**Type :** Composant d'état vide
**Usages :** 5 specs

---

## Objectif

Remplace une liste vide par un message encourageant et une action pour démarrer. Jamais une page blanche.

---

## Structure

```
┌─────────────────────────────┐
│                             │
│       [Illustration]        │  ← SVG léger, style cohérent
│                             │
│         Titre               │  ← heading-sm, bold
│       Sous-titre            │  ← heading-xxs, regular
│                             │
│      [ Bouton CTA ]         │  ← PrimaryButton ou SecondaryButton
│                             │
└─────────────────────────────┘
```

---

## Spécifications visuelles

| Propriété | Valeur | Token |
|-----------|--------|-------|
| Illustration | 120px × 120px, SVG | — |
| Titre | 18px / 700 | `heading-sm` + `weight-bold` |
| Couleur titre | `color-on-surface` | — |
| Sous-titre | 14px / 400 | `heading-xxs` + `weight-regular` |
| Couleur sous-titre | `color-on-surface-secondary` | — |
| Alignement | Centré | — |
| Position dans la page | Centré verticalement dans la zone liste | — |

---

## Props

| Prop | Type | Description |
|------|------|-------------|
| `illustration` | string | Nom du SVG (depuis l'asset library) |
| `title` | string | Titre de l'état vide |
| `subtitle` | string | Texte d'explication |
| `ctaLabel` | string | Label du bouton d'action |
| `onCtaPress` | `() => void` | Handler du CTA |
| `ctaVariant` | `'primary'` \| `'secondary'` | Type de bouton (défaut: `'primary'`) |

---

## Contenu observé dans les specs

| Page | Titre FR | Sous-titre FR | CTA |
|------|----------|---------------|-----|
| 01.6 Dashboard (0 dépenses) | "Pas encore de dépenses ce mois" | "Beau début ! Ajoute ta première dépense." | "Ajouter une dépense" |
| 02.2 Liste dépenses | "Aucune dépense ce mois" | "Commence à noter tes dépenses." | "Ajouter" |
| 04.1 Liste dettes | "Aucune dette cartographiée" | "Commence par ajouter la première." | "Ajouter une dette" |
| 05.1 Liste objectifs | "Aucun objectif en cours" | "Crée ton premier objectif d'épargne." | "Créer un objectif" |
| 07.1 Liste investissements | "Aucun investissement suivi" | "Ajoute ton premier titre BRVM." | "Ajouter un investissement" |

**Pattern du ton :** Jamais "Aucun X trouvé." — toujours une phrase encourageante qui célèbre le point de départ.

---

## Espacement

| Entre | Token |
|-------|-------|
| Illustration → titre | `space-md` (16px) |
| Titre → sous-titre | `space-sm` (8px) |
| Sous-titre → CTA | `space-xl` (32px) |

---

_Composant Design System — App Finance UEMOA_
