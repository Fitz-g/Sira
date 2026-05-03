# PrimaryButton

**Design System ID :** `primary-button`
**Type :** Composant d'action
**Usages :** 15+ specs

---

## Objectif

Bouton d'action principal (CTA). Pleine largeur, proéminent, déclenche l'action primaire de la page. Un seul PrimaryButton par page.

---

## Spécifications visuelles

| Propriété | Valeur | Token |
|-----------|--------|-------|
| Largeur | 100% du conteneur (- padding page) | — |
| Hauteur minimum | 56px | — |
| Rayon de bordure | 12px | `radius-card` |
| Fond | Couleur principale brand | `color-primary` |
| Texte | Blanc | `color-on-primary` |
| Taille texte | 18px | `heading-sm` |
| Poids texte | 700 | `weight-bold` |
| Padding horizontal | 24px | — |
| Alignement texte | Centré | — |

---

## Props

| Prop | Type | Requis | Description |
|------|------|--------|-------------|
| `label` | string | Oui | Texte du bouton |
| `onPress` | `() => void` | Oui | Action au tap |
| `disabled` | boolean | Non (défaut: false) | Désactive le bouton |
| `loading` | boolean | Non (défaut: false) | Affiche un spinner |
| `haptic` | boolean | Non (défaut: false) | Feedback haptique au tap |

---

## États

| État | Apparence | Interactif |
|------|-----------|------------|
| **Default** | Fond `color-primary`, texte blanc | Oui |
| **Pressed** | Opacity 0.85, scale(0.98), transition 150ms | Oui |
| **Disabled** | Opacity 0.4 sur tout le bouton | Non |
| **Loading** | Spinner blanc centré, label masqué | Non |

### Diagramme d'états

```
                ┌──────────┐
                │ Disabled │ ← formulaire incomplet
                └────┬─────┘
                     │ formulaire valide
                     ▼
                ┌──────────┐
           ┌───→│ Default  │←──┐
           │    └────┬─────┘   │
           │         │ touch   │ release
           │         ▼         │
           │    ┌──────────┐   │
           │    │ Pressed  │───┘
           │    └────┬─────┘
           │         │ onPress()
           │         ▼
           │    ┌──────────┐
           │    │ Loading  │
           │    └────┬─────┘
           │         │ success/error
           └─────────┘
```

---

## Interactions

| Événement | Comportement |
|-----------|-------------|
| Touch down | Transition vers état Pressed (150ms) |
| Touch up | Exécute `onPress`, retour à Default ou Loading |
| Touch up (avec `haptic: true`) | Feedback haptique léger + ripple animation |
| Tap en état Disabled | Aucune réponse (pas de feedback visuel) |
| Tap en état Loading | Aucune réponse |

---

## Validation progressive

Le PrimaryButton s'active automatiquement lorsque le formulaire associé est valide :

| Contexte | Condition d'activation | Spec |
|----------|----------------------|------|
| Inscription | 3 champs remplis (nom, email, mdp) | 01.2 |
| Onboarding E1 | Au moins 1 chip sélectionné par groupe | 01.3 |
| Saisie dépense | Montant > 0 | 02.1 |
| Simulateur | Type + montant + durée remplis | 03.1 |
| Ajouter dette | Créancier + montant remplis | 04.2 |
| Créer objectif | Nom + montant + date remplis | 05.2 |
| Espace entrepreneur | Nom activité rempli | 08.1 |

---

## Position

| Contexte | Positionnement |
|----------|---------------|
| Page avec formulaire | Sticky bottom, au-dessus du safe area | 
| Page de résultat | Dans le flux, après le contenu |
| Page avec nav bar | Au-dessus de la nav bar |

Espacement avant le bouton : `space-xl` (32px) — séparation nette entre contenu et action.

---

## Contenu observé dans les specs

| Spec | Label FR | Label EN |
|------|----------|----------|
| 01.1 Splash | "C'est parti →" | "Let's go →" |
| 01.2 Inscription | "Créer mon compte →" | "Create my account →" |
| 01.3-01.4 Onboarding | "Continuer" | "Continue" |
| 01.5 Onboarding E3 | "Voir mon tableau de bord" | "See my dashboard" |
| 02.1 Saisie dépense | "Enregistrer" | "Save" |
| 03.1 Simulateur | "Voir ma projection" | "See my projection" |
| 03.2 Résultat | "Créer cet objectif" | "Create this goal" |
| 04.1 Liste dettes | "Voir mon plan →" | "See my plan →" |
| 04.2 Ajouter dette | "Ajouter cette dette" | "Add this debt" |
| 05.2 Créer objectif | "Créer mon objectif" | "Create my goal" |
| 05.3 Détail objectif | "Ajouter un versement" | "Add a payment" |
| 08.1 Espace entrepreneur | "Créer mon espace" | "Create my space" |
| 09.3 Abonnement | "Passer à Premium" | "Upgrade to Premium" |

**Pattern observé :** Le label est toujours à la première personne ("mon", "ma"), actif, et souvent suivi de "→".

---

## Accessibilité

- `accessibilityRole="button"`
- `accessibilityState={{ disabled, busy: loading }}`
- En état Loading : `accessibilityLabel="Chargement en cours"`

---

_Composant Design System — App Finance UEMOA_
