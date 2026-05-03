# Toast

**Design System ID :** `toast`
**Type :** Composant de notification contextuelle
**Usages :** 5 specs

---

## Objectif

Confirmation légère et non-bloquante après une action réussie. Apparaît automatiquement, disparaît seul.

---

## Spécifications visuelles

| Propriété | Valeur | Token |
|-----------|--------|-------|
| Position | Bas de l'écran, au-dessus de la nav bar | — |
| Largeur | Pleine largeur - 32px de marges | — |
| Fond | `color-primary-light` | — |
| Bordure gauche | 4px `color-primary` | — |
| Rayon | 8px | `radius-input` |
| Texte | 14px / 500 | `heading-xxs` + `weight-medium` |
| Couleur texte | `color-primary` | — |
| Padding | 12px 16px | — |
| Icône | ✓ (check) à gauche | — |

---

## Comportement

| Phase | Durée | Animation |
|-------|-------|-----------|
| Apparition | 200ms | Slide-up depuis le bas + fade-in |
| Affichage | 2000ms | Statique |
| Disparition | 200ms | Fade-out |
| **Total** | **2400ms** | — |

- Non-bloquant : l'utilisateur peut interagir pendant l'affichage
- Si un second toast est déclenché pendant l'affichage du premier : le premier est remplacé immédiatement

---

## Props

| Prop | Type | Description |
|------|------|-------------|
| `message` | string | Texte du toast |
| `type` | `'success'` \| `'error'` \| `'info'` | Style (défaut: `'success'`) |
| `duration` | number | Durée d'affichage en ms (défaut: 2000) |

### Variante `error`
| Propriété | Valeur |
|-----------|--------|
| Fond | `color-error` @ 10% |
| Bordure gauche | `color-error` |
| Texte | `color-error` |
| Icône | ✕ |

---

## Exemples dans les specs

| Spec | Message FR | Type |
|------|------------|------|
| 02.2 Liste dépenses | "Dépense ajoutée ✓" | success |
| 04.2 Ajouter dette | "Dette ajoutée" | success |
| 08.1 Espace entrepreneur | "Espace créé ✓" | success |
| 09.2 Paramètres | "Wave connecté ✓" | success |
| 09.3 Abonnement | "Abonnement activé ✓" | success |

---

_Composant Design System — App Finance UEMOA_
