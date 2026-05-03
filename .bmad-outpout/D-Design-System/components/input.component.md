# Input

**Design System ID :** `input`
**Type :** Composant de formulaire
**Usages :** TextInput (6 specs), NumberInput (6 specs)

---

## Variantes

| Variante | Clavier | Suffix | Specs |
|----------|---------|--------|-------|
| `text` | Alphanumérique | — | 01.2, 02.1, 04.2, 05.2, 06.1, 08.1 |
| `email` | Email (@ visible) | — | 01.2 |
| `password` | Standard | Toggle œil | 01.2 |
| `number` | Numérique | "FCFA" | 01.4, 02.1, 03.1, 04.2, 05.2, 08.1 |

---

## Spécifications visuelles

| Propriété | Valeur | Token |
|-----------|--------|-------|
| Hauteur | 52px | — |
| Fond | Gris clair | `color-neutral-100` |
| Rayon | 8px | `radius-input` |
| Bordure default | 1px | `color-border` |
| Bordure focus | 2px | `color-primary` |
| Bordure error | 2px | `color-error` |
| Bordure valid | 2px | `color-success` |
| Label (au-dessus) | 14px / 500 | `heading-xxs` + `weight-medium` |
| Texte saisi | 16px / 400 | `heading-xs` + `weight-regular` |
| Placeholder | 16px / 400 | `heading-xs` + `color-neutral-500` |
| Message erreur (dessous) | 14px / 400 | `heading-xxs` + `color-error` |

---

## États

| État | Bordure | Label | Feedback |
|------|---------|-------|---------|
| Default | `color-border` (1px) | `color-on-surface-secondary` | — |
| Focus | `color-primary` (2px) | `color-primary` | Clavier s'ouvre |
| Filled | `color-border` (1px) | `color-on-surface-secondary` | — |
| Error | `color-error` (2px) | `color-error` | Message sous le champ |
| Valid | `color-success` (2px) | `color-on-surface-secondary` | — |

---

## Props

| Prop | Type | Description |
|------|------|-------------|
| `variant` | `'text'` \| `'email'` \| `'password'` \| `'number'` | Type d'input |
| `label` | string | Label affiché au-dessus |
| `placeholder` | string | Texte indicatif |
| `value` | string | Valeur contrôlée |
| `onChangeText` | `(v: string) => void` | Callback changement |
| `error` | string | Message d'erreur (active l'état Error) |
| `suffix` | string | Texte à droite (ex: "FCFA") |
| `maxLength` | number | Limite de caractères |
| `optional` | boolean | Affiche "(optionnel)" dans le label |

---

## Comportements spécifiques

**variant: number**
- Clavier numérique affiché d'emblée
- Suffix "FCFA" affiché à droite de la valeur
- Valeur stockée comme number, affichée avec séparateur de milliers (ex: "125 000")
- Valeur 0 affichée comme "0", pas comme vide

**variant: password**
- Icône œil à droite : tap toggle visibilité
- `secureTextEntry` activé par défaut

**Validation progressive (on blur)**
- La validation se déclenche quand l'utilisateur quitte le champ
- Pas de validation pendant la frappe (sauf formats stricts : email)

---

## Espacement

| Entre | Token |
|-------|-------|
| Label → champ | `space-sm` (8px) |
| Champ → message erreur | `space-sm` (8px) |
| Entre deux champs | `space-md` (16px) |

---

_Composant Design System — App Finance UEMOA_
