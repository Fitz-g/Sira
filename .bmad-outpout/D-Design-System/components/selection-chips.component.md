# SelectionChips

**Design System ID :** `selection-chips`
**Type :** Composant de sélection
**Usages :** 7 specs

---

## Objectif

Sélection exclusive parmi un ensemble d'options. Remplace les radio buttons sur mobile — plus tactile, plus visuel.

---

## Layouts

| Layout | Quand | Specs |
|--------|-------|-------|
| `grid-2col` | Options avec labels longs, 4-6 options | Onboarding E1 revenus/situation (01.3), Onboarding E3 objectifs (01.5) |
| `scroll-h` | Beaucoup d'options (8+) ou une seule ligne | Catégories dépense (02.1), Suggestions IA (06.1), Type activité (08.1) |

---

## Spécifications visuelles

### Chip — état Default

| Propriété | Valeur | Token |
|-----------|--------|-------|
| Fond | `color-neutral-100` | — |
| Bordure | 1px `color-neutral-300` | — |
| Rayon | 20px (pill) | `radius-chip` |
| Texte | 14px / 500 | `heading-xxs` + `weight-medium` |
| Couleur texte | `color-on-surface-secondary` | — |
| Padding | 8px 16px | — |
| Hauteur | 36px | — |

### Chip — état Selected

| Propriété | Valeur | Token |
|-----------|--------|-------|
| Fond | `color-primary-light` | — |
| Bordure | 1.5px `color-primary` | — |
| Texte | `color-primary` | — |

### Chip — état Pressed

`press-feedback` (opacity 0.85, scale 0.98, 150ms)

---

## Comportement

- **Sélection exclusive** : tap sur un chip sélectionne celui-ci et désélectionne le précédent
- **Icône optionnelle** : pictogramme Lucide à gauche du libellé
- **Défilement** : en mode `scroll-h`, le groupe est scrollable horizontalement sans indicateur visible

---

## Props

| Prop | Type | Description |
|------|------|-------------|
| `options` | `{ id: string, label: string, icon?: IconData }[]` | Liste des options |
| `selected` | string | ID de l'option sélectionnée |
| `onChange` | `(id: string) => void` | Callback sélection |
| `layout` | `'grid-2col'` \| `'scroll-h'` | Mode d'affichage |

---

## Espacement

| Contexte | Token |
|----------|-------|
| Gap entre chips (grid) | `space-sm` (8px) |
| Gap entre chips (scroll) | `space-sm` (8px) |
| Section chips → section suivante | `space-lg` (24px) |

---

_Composant Design System — App Finance UEMOA_
