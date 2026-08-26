# Card

**Design System ID :** `card`
**Type :** Composant de contenu
**Usages :** 10+ specs

---

## Objectif

Conteneur visuel pour grouper des informations liées. Utilisé pour les résumés de métriques, les aperçus dynamiques, les insights IA, et les items de liste.

---

## Variantes

| Variante | Objectif | Specs typiques |
|----------|----------|----------------|
| **metric** | Affiche 2-4 métriques clés en colonnes | Dashboard (01.6), Budget (02.3), Plan remboursement (04.3), Investissements (07.2) |
| **info** | Message ou recommandation avec icône et texte | Insight IA (01.6), Résumé dettes (04.1), Message motivation (04.3) |
| **preview** | Aperçu dynamique calculé en temps réel | Simulateur (03.1), Créer objectif (05.2), Espace entrepreneur (08.1) |
| **list-item** | Item cliquable dans une liste | Liste dettes (04.1), Liste objectifs (05.1), Liste investissements (07.1) |
| **recap** | Résumé de paramètres en lignes | Résultat simulation (03.2), Résumé abonnement (09.3) |

---

## Spécifications visuelles communes

| Propriété | Valeur | Token |
|-----------|--------|-------|
| Fond | Blanc / surface card | `color-surface-card` |
| Rayon de bordure | 12px | `radius-card` |
| Padding interne | 16px | `padding-card` |
| Bordure | 1px solid | `color-neutral-300` |
| Ombre | Aucune (flat design) | — |
| Largeur | 100% du conteneur | — |

---

## Variante : metric

Affiche des métriques en colonnes égales.

```
┌─────────────────────────────────────┐
│  Label 1     │  Label 2    │  Label 3  │
│  Valeur 1    │  Valeur 2   │  Valeur 3 │
└─────────────────────────────────────┘
```

| Propriété | Valeur |
|-----------|--------|
| Layout | Flex row, colonnes égales |
| Label | `heading-xxs` (14px), poids 400, `color-on-surface-secondary` |
| Valeur | `heading-sm` (18px), poids 700, `color-on-surface` |
| Colonnes | 2 à 4 selon le contenu |
| Séparateur | Ligne verticale optionnelle `color-neutral-300` |

**Exemples :**
- Dashboard (01.6) : Revenus / Dépenses / Solde estimé (3 colonnes)
- Plan remboursement (04.3) : Total / Mensualité / Durée (3 colonnes)
- Détail investissement (07.2) : Quantité / PRU / Valeur / P&L (4 colonnes)

---

## Variante : info

Message informatif avec accroche visuelle.

```
┌─────────────────────────────────────┐
│  🔶│  Texte de l'insight ou du       │
│    │  message sur 1-2 lignes         │
└─────────────────────────────────────┘
```

| Propriété | Valeur |
|-----------|--------|
| Layout | Flex row : bord gauche coloré (4px) + icône + texte |
| Bord gauche | 4px `color-primary` |
| Fond | Légèrement teinté `color-primary-light` |
| Icône | Ampoule, info, coeur... (contextuel) |
| Texte | `heading-xs` (16px), poids 400, `color-on-surface` |

**Exemples :**
- Dashboard (01.6) : Card insight IA
- Liste dettes (04.1) : "Chaque dette cartographiée est un pas vers la liberté."
- Plan remboursement (04.3) : Message de motivation

---

## Variante : preview

Résultat dynamique calculé en temps réel à partir des inputs.

```
┌─────────────────────────────────────┐
│  Label descriptif                    │
│  ══════════════════════════          │
│  Valeur calculée grande              │
│  Sous-label explicatif               │
└─────────────────────────────────────┘
```

| Propriété | Valeur |
|-----------|--------|
| Label | `heading-xxs` (14px), poids 400 |
| Valeur | `heading-lg` (24px), poids 700, `color-primary` |
| Sous-label | `heading-xxs` (14px), poids 400, `color-on-surface-secondary` |
| Animation | Valeur se met à jour avec transition fade (200ms) |
| État initial | "—" si données insuffisantes |

**Exemples :**
- Simulateur (03.1) : Aperçu rapide "X FCFA / mois"
- Créer objectif (05.2) : Mensualité calculée
- Espace entrepreneur (08.1) : Aperçu bilan séparé

---

## Variante : list-item

Card cliquable représentant un élément dans une liste.

```
┌─────────────────────────────────────┐
│  Icône │  Titre             Montant │
│        │  Sous-titre        Chevron │
│        │  [Progress bar]            │
└─────────────────────────────────────┘
```

| Propriété | Valeur |
|-----------|--------|
| Layout | Flex row : icône + contenu + valeur/chevron |
| Titre | `heading-sm` (18px), poids 600, `color-on-surface` |
| Sous-titre | `heading-xxs` (14px), poids 400, `color-on-surface-secondary` |
| Montant | `heading-sm` (18px), poids 700, aligné droite |
| Chevron | `›` en `color-neutral-500` |
| Progress bar | Optionnelle, sous le titre |
| Swipe gauche | Révèle bouton supprimer (rouge) — si swipeable |

**États :**
| État | Apparence |
|------|-----------|
| Default | Fond `color-surface-card` |
| Pressed | `press-feedback` (opacity 0.85, scale 0.98) |
| Swiped | Bouton supprimer rouge visible à droite |

**Exemples :**
- Liste dettes (04.1) : Créancier + montant + mensualité + barre progression
- Liste objectifs (05.1) : Nom objectif + montant cible + progression
- Liste investissements (07.1) : Sigle + nom + cours + P&L

---

## Variante : recap

Résumé de paramètres en lignes label/valeur.

```
┌─────────────────────────────────────┐
│  Label 1 ................. Valeur 1 │
│  Label 2 ................. Valeur 2 │
│  Label 3 ................. Valeur 3 │
└─────────────────────────────────────┘
```

| Propriété | Valeur |
|-----------|--------|
| Layout | Liste de rows flex : label à gauche, valeur à droite |
| Label | `heading-xxs` (14px), poids 400, `color-on-surface-secondary` |
| Valeur | `heading-xs` (16px), poids 600, `color-on-surface` |
| Séparateur | Ligne horizontale `color-neutral-100` entre les rows |

**Exemples :**
- Résultat simulation (03.2) : Objectif / Durée / Montant cible
- Abonnement (09.3) : Détails du plan

---

## Props communes

| Prop | Type | Requis | Description |
|------|------|--------|-------------|
| `variant` | `'metric'` \| `'info'` \| `'preview'` \| `'list-item'` \| `'recap'` | Oui | Type de card |
| `onPress` | `() => void` | Non | Rend la card cliquable (list-item, info) |
| `children` | ReactNode | Oui | Contenu de la card |

---

## Espacement

| Contexte | Token |
|----------|-------|
| Entre deux cards dans une liste | `space-sm` (8px) |
| Entre une card et la section suivante | `space-lg` (24px) |
| Padding interne de la card | `padding-card` (16px) |
| Entre label et valeur (metric) | `space-sm` (8px) vertical |

---

## Accessibilité

- Cards cliquables (list-item) : `accessibilityRole="button"`
- Cards informatives : `accessibilityRole="summary"`
- Métriques : chaque paire label/valeur groupée pour les lecteurs d'écran

---

_Composant Design System — App Finance UEMOA_


---

## Révision du 2026-08-21 — l'ombre remplace la bordure

La card n'a plus de bordure. Elle est blanche, posée sur un fond de page gris,
et porte une ombre à deux couches : une courte qui la pose, une large et diffuse
qui lui donne son volume.

Une seule couche d'ombre produit un halo gris ; deux produisent une élévation
crédible.

La variante `info` conserve son fond teinté et son liseré gauche, sans ombre :
elle appartient au flux du texte, elle ne flotte pas.

Rayon porté de 12 à 16 px.
