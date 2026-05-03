# Tokens Typographiques

**Design System ID :** `tokens-typography`
**Extrait de :** 24 spécifications de pages (Phase 4)
**Date :** 2026-05-01

---

## Échelle Typographique

9 tokens, échelle cohérente de 14px à 56px.

| Token | Taille | Rôle sémantique | Usages |
|-------|--------|-----------------|--------|
| `heading-4xl` | 56px | Chiffre clé héroïque | Score santé (01.6), montant dépense (02.1) |
| `heading-3xl` | 44px | Chiffre clé secondaire | Montant mensuel simulation (03.2) |
| `heading-2xl` | 36px | Valeur mise en avant | Splash headline (01.1), cours actuel (07.2), prix abonnement (09.3) |
| `heading-xl` | 30px | Titre page (onboarding/inscription) | Inscription (01.2), Onboarding E1-E3 (01.3-01.5) |
| `heading-lg` | 24px | Titre page (principal) | Dashboard (01.6), Détail objectif (05.3), Espace entrepreneur (08.1), Profil (09.1) |
| `heading-md` | 20px | Titre page (standard) | Majorité des pages post-onboarding (14 specs) |
| `heading-sm` | 18px | Texte CTA / valeurs métriques | Boutons primaires, valeurs dans les cards (15 specs) |
| `heading-xs` | 16px | Texte secondaire / boutons secondaires | Boutons secondaires, textes insight, labels (11 specs) |
| `heading-xxs` | 14px | Labels, légendes, captions | Labels formulaires, légendes navigation, chips (10 specs) |

---

## Poids (Font Weight)

| Token | Valeur | Usage |
|-------|--------|-------|
| `weight-black` | 900 | Chiffres clés héroïques (heading-4xl, heading-3xl, heading-2xl) |
| `weight-bold` | 700 | Titres de page, salutations, valeurs métriques |
| `weight-semibold` | 600 | Titres de page (heading-md), boutons secondaires |
| `weight-medium` | 500 | Chips sélection, labels actifs |
| `weight-regular` | 400 | Corps de texte, labels, légendes, paragraphes |
| `weight-light` | 300 | Sous-titres discrets |

---

## Associations Token ↔ Poids

| Contexte sémantique | Token taille | Poids | Exemple |
|---------------------|-------------|-------|---------|
| Chiffre héroïque | `heading-4xl` | 900 | Score santé financière |
| Chiffre clé | `heading-3xl` | 900 | Montant mensuel simulation |
| Valeur mise en avant | `heading-2xl` | 900 | Headline splash, prix |
| Titre page (grand) | `heading-xl` | 700 | "Crée ton compte" |
| Titre page (moyen) | `heading-lg` | 700 | "Bonjour Kofi" |
| Titre page (standard) | `heading-md` | 600 | "Mes dépenses" |
| CTA primaire | `heading-sm` | 700 | "C'est parti" |
| Valeur métrique | `heading-sm` | 700 | "125 000 FCFA" |
| CTA secondaire | `heading-xs` | 600 | "Voir mon budget" |
| Texte insight/corps | `heading-xs` | 400 | Texte card IA |
| Label formulaire | `heading-xxs` | 400 | "Revenus mensuels" |
| Chip sélection | `heading-xxs` | 500 | "Salarié" |
| Label navigation | `heading-xxs` | 400 | "Accueil" |

---

## Police

| Propriété | Valeur | Rationale |
|-----------|--------|-----------|
| Famille primaire | À définir (Phase Visual) | Recommandation : Inter, Nunito, ou Poppins — lisibles, open-source, bonne couverture accents français |
| Famille fallback | `system-ui, sans-serif` | Performance native |
| Line-height (titres) | 1.2 | Standard compact pour headings |
| Line-height (corps) | 1.5 | Lisibilité pour paragraphes |
| Letter-spacing | 0 | Défaut — ajuster par token si nécessaire |

---

## Implémentation React Native

```typescript
export const typography = {
  'heading-4xl': { fontSize: 56, lineHeight: 67 },
  'heading-3xl': { fontSize: 44, lineHeight: 53 },
  'heading-2xl': { fontSize: 36, lineHeight: 43 },
  'heading-xl':  { fontSize: 30, lineHeight: 36 },
  'heading-lg':  { fontSize: 24, lineHeight: 29 },
  'heading-md':  { fontSize: 20, lineHeight: 24 },
  'heading-sm':  { fontSize: 18, lineHeight: 22 },
  'heading-xs':  { fontSize: 16, lineHeight: 19 },
  'heading-xxs': { fontSize: 14, lineHeight: 17 },
} as const;

export const fontWeight = {
  'weight-black':    '900',
  'weight-bold':     '700',
  'weight-semibold': '600',
  'weight-medium':   '500',
  'weight-regular':  '400',
  'weight-light':    '300',
} as const;
```

---

_Extrait du Design System — App Finance UEMOA_
