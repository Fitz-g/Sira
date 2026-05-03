# PageHeader

**Design System ID :** `page-header`
**Type :** Composant de layout
**Usages :** 24/24 specs

---

## Objectif

Barre d'en-tête de page. Présente le titre et une action contextuelle optionnelle (retour, fermer, ajouter, éditer).

---

## Variantes

| Variante | Taille titre | Poids | Action | Specs typiques |
|----------|-------------|-------|--------|----------------|
| **hero** | `heading-xl` (30px) | 700 | Aucune | Inscription (01.2), Onboarding E1-E3 (01.3-01.5) |
| **primary** | `heading-lg` (24px) | 700 | Optionnelle | Dashboard (01.6), Détail objectif (05.3), Espace entrepreneur (08.1) |
| **standard** | `heading-md` (20px) | 600 | Optionnelle | Majorité des pages post-onboarding (14 specs) |

---

## Structure

```
┌──────────────────────────────────────┐
│  [Action gauche]   Titre   [Action droite]  │
└──────────────────────────────────────┘
```

| Slot | Contenu | Optionnel |
|------|---------|-----------|
| Action gauche | Bouton retour (chevron ←) ou fermer (X) | Oui |
| Titre | Texte h1, aligné gauche ou centré selon variante | Non |
| Action droite | Bouton "+" (ajouter) ou "Modifier" ou icône | Oui |

---

## Props

| Prop | Type | Requis | Description |
|------|------|--------|-------------|
| `title` | string | Oui | Texte du titre |
| `variant` | `'hero'` \| `'primary'` \| `'standard'` | Non (défaut: `'standard'`) | Taille et poids du titre |
| `leftAction` | `'back'` \| `'close'` \| `none` | Non | Action gauche |
| `rightAction` | `{ icon: string, onPress: () => void }` | Non | Action droite (icône + handler) |
| `titleAlign` | `'left'` \| `'center'` | Non (défaut: `'left'`) | Alignement du titre |

---

## Apparence par variante

### hero
| Propriété | Valeur |
|-----------|--------|
| Tag | `h1` |
| Token | `heading-xl` (30px) |
| Poids | 700 (`weight-bold`) |
| Alignement | Centré |
| Action gauche | Aucune (page d'entrée de flux) |
| Action droite | Aucune |
| Padding horizontal | `padding-page` (20px) |

### primary
| Propriété | Valeur |
|-----------|--------|
| Tag | `h1` |
| Token | `heading-lg` (24px) |
| Poids | 700 (`weight-bold`) |
| Alignement | Gauche |
| Action gauche | Optionnelle (retour) |
| Action droite | Optionnelle |
| Padding horizontal | `padding-page` (20px) |

### standard
| Propriété | Valeur |
|-----------|--------|
| Tag | `h1` |
| Token | `heading-md` (20px) |
| Poids | 600 (`weight-semibold`) |
| Alignement | Gauche |
| Action gauche | Optionnelle (retour ou X) |
| Action droite | Optionnelle (+ ou modifier) |
| Padding horizontal | `padding-page` (20px) |

---

## Actions contextuelles observées

| Action | Icône | Comportement | Specs |
|--------|-------|-------------|-------|
| Retour | `←` chevron | `nav-pop` vers page précédente | 04.2, 05.2, 07.2, 08.1, 09.2 |
| Fermer | `X` | Dismiss modale | 02.1 (saisie dépense) |
| Ajouter | `+` | Navigation vers formulaire ajout | 02.2, 04.1, 05.1, 07.1 |
| Modifier | icône crayon | Passe en mode édition | 05.3 (détail objectif) |

---

## États

| État | Apparence |
|------|-----------|
| Default | Titre visible, actions disponibles |
| Scrolled | Ombre portée légère (elevation) si scroll détecté |

### États des boutons d'action
| État | Apparence |
|------|-----------|
| Default | Icône en `color-on-surface` |
| Pressed | `press-feedback` (opacity 0.85, scale 0.98, 150ms) |

---

## Espacement

| Entre | Token |
|-------|-------|
| Bord gauche → titre (sans action) | `padding-page` (20px) |
| Bord gauche → icône retour | `padding-page` (20px) |
| Icône retour → titre | `space-sm` (8px) |
| Titre → icône droite | `space-sm` (8px) |
| Header → contenu page (dessous) | `space-lg` (24px) |

---

## Accessibilité

- Action gauche : `accessibilityLabel="Retour"` ou `"Fermer"`
- Action droite : label descriptif (`"Ajouter"`, `"Modifier"`)
- Titre : rôle `header`, niveau `h1`

---

## Exemples d'utilisation dans les specs

```yaml
# 02.1 Saisie Dépense
PageHeader:
  variant: standard
  title: "Nouvelle dépense"
  leftAction: close
  titleAlign: left

# 04.1 Liste Dettes
PageHeader:
  variant: standard
  title: "Mes dettes"
  rightAction: { icon: "+", onPress: navigateToAddDebt }

# 01.2 Inscription
PageHeader:
  variant: hero
  title: "Créer un compte"
  titleAlign: center

# 01.6 Dashboard
PageHeader:
  variant: primary
  title: "Bonjour Kofi 👋"
```

---

_Composant Design System — App Finance UEMOA_
