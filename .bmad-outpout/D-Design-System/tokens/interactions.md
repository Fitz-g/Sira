# Tokens d'Interaction

**Design System ID :** `tokens-interactions`
**Extrait de :** 24 spécifications de pages (Phase 4)
**Date :** 2026-05-01

---

## Animations de Feedback

| Token | Propriétés | Usage | Specs |
|-------|-----------|-------|-------|
| `press-feedback` | opacity: 0.85, scale: 0.98, durée: 150ms | Feedback tactile sur tous les boutons et éléments tappables | Universel |
| `disabled-state` | opacity: 0.4 | CTA désactivé tant que le formulaire n'est pas valide | 01.2, 01.3, 01.4, 01.5, 02.1, 03.1, 04.2, 05.2, 08.1 |
| `toast-appear` | slide-up + fade-in, auto-dismiss 2s | Confirmation après action réussie | 02.2, 04.2, 08.1, 09.2, 09.3 |
| `skeleton-pulse` | Pulsation fond gris clair | Placeholder pendant chargement des données | 01.6, 02.2, 03.2, 04.3 |
| `slide-reveal` | slide-down depuis l'élément parent | Champ conditionnel qui apparaît (toggle → champ) | 01.4 |
| `form-shake` | Secousse horizontale légère | Soumission formulaire invalide | 01.2, 02.1 |

---

## Transitions de Navigation

| Token | Type | Usage |
|-------|------|-------|
| `nav-push` | Push standard (droite → gauche) | Navigation forward entre pages |
| `nav-pop` | Pop standard (gauche → droite) | Retour en arrière |
| `nav-modal` | Slide-up depuis le bas | Pages modales (saisie dépense, ajout dette) |

---

## Gestes Tactiles

| Geste | Comportement | Composants | Specs |
|-------|-------------|------------|-------|
| **Tap** | Action principale du composant | Tous les éléments interactifs | Universel |
| **Tap + haptic** | Vibration légère + ripple sur CTA | Boutons primaires importants | 01.1, 01.2, 01.3, 01.5, 02.1 |
| **Swipe left** | Révèle bouton supprimer (rouge) | ListItem dans les listes | 02.2, 04.1, 05.1 |
| **Swipe left + tap delete** | Dialog de confirmation → suppression | Suppression d'un élément | 02.2, 04.1, 05.1 |
| **Horizontal scroll** | Navigation dans les chips / timeline | Chips catégories, timeline remboursement | 02.1, 06.1, 04.3 |

---

## Patterns de Formulaire

| Pattern | Comportement | Specs |
|---------|-------------|-------|
| **Validation progressive** | CTA disabled → enabled quand tous les champs requis sont remplis | 9 specs formulaires |
| **Calcul dynamique** | Card résultat se met à jour en temps réel pendant la saisie | 03.1, 05.2, 08.1 |
| **Focus → bordure primary** | Bordure du champ passe en `color-primary` au focus | Tous les inputs |
| **Erreur → bordure rouge + message** | Bordure en `color-error`, message d'erreur sous le champ | Tous les inputs |
| **Chip sélection exclusive** | Tap sélectionne un chip, désélectionne le précédent | 01.3, 01.5, 02.1, 03.1, 08.1 |

---

## Composants Interactifs Spéciaux

### Toggle Switch
| État | Apparence |
|------|-----------|
| Off | Fond gris, curseur à gauche |
| On | Fond `color-primary`, curseur à droite |
| Transition | 200ms ease |

### Month Selector (Chevrons)
| Action | Comportement |
|--------|-------------|
| Tap chevron gauche | Mois précédent, contenu se met à jour |
| Tap chevron droite | Mois suivant, contenu se met à jour |
| Format | "Mois Année" (ex: "Avril 2026") |

---

## Implémentation React Native

```typescript
export const animations = {
  pressFeedback: {
    opacity: 0.85,
    scale: 0.98,
    duration: 150,
  },
  disabledOpacity: 0.4,
  toastDuration: 2000,
  toggleDuration: 200,
} as const;

export const transitions = {
  push: 'slide_from_right',
  pop: 'slide_from_left',
  modal: 'slide_from_bottom',
} as const;
```

---

_Extrait du Design System — App Finance UEMOA_
