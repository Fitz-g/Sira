# SecondaryButton & TextLink

**Design System ID :** `secondary-button`, `text-link`
**Type :** Composants d'action secondaire
**Usages :** SecondaryButton (6 specs), TextLink (5 specs)

---

## SecondaryButton

Action secondaire visible, moins prioritaire que le PrimaryButton. Peut coexister avec lui sur la même page.

### Spécifications visuelles

| Propriété | Valeur | Token |
|-----------|--------|-------|
| Hauteur | 48px | — |
| Largeur | Variable (pleine ou demi-largeur) | — |
| Fond | Transparent | — |
| Bordure | 1.5px `color-primary` | `color-primary` |
| Rayon | 12px | `radius-card` |
| Texte | `color-primary` | `color-primary` |
| Taille texte | 16px / 600 | `heading-xs` + `weight-semibold` |

### États

| État | Apparence |
|------|-----------|
| Default | Bordure + texte `color-primary` |
| Pressed | `press-feedback` (opacity 0.85, scale 0.98, 150ms) |
| Disabled | Opacity 0.4 |

### Exemples dans les specs

| Spec | Label FR | Contexte |
|------|----------|---------|
| 01.6 Dashboard | "Ajouter" / "Mon objectif" | 2 boutons côte à côte (demi-largeur) |
| 02.2 Liste dépenses | "Voir mon budget" | En bas de liste |
| 02.3 Budget mensuel | "Ajuster mon budget" | Action secondaire |
| 04.3 Plan remboursement | CTA Premium | Upsell discret |
| 09.1 Profil | Navigation profil | Liens avec bordure |

---

## TextLink

Lien texte pur, action tertiaire. Utilisé sous les CTAs ou pour les sorties de flux.

### Spécifications visuelles

| Propriété | Valeur | Token |
|-----------|--------|-------|
| Texte | 14px / 400 | `heading-xxs` + `weight-regular` |
| Couleur | `color-on-surface-secondary` | Neutre — ne concurrence pas le CTA |
| Alignement | Centré | — |
| Soulignement | Aucun (default) | — |

### États

| État | Apparence |
|------|-----------|
| Default | Texte neutre, pas de soulignement |
| Pressed | Soulignement temporaire (150ms) |

### Exemples dans les specs

| Spec | Label FR | Position |
|------|----------|---------|
| 01.1 Splash | "J'ai déjà un compte" | Sous le CTA |
| 01.2 Inscription | "J'ai déjà un compte" | Sous le CTA |
| 01.4 Onboarding | "Passer cette étape" | Sous le CTA |
| 03.2 Résultat simulation | "Modifier les paramètres" | Sous le CTA |
| 09.2 Paramètres | "Exporter mes données" | Dans une section paramètres |

---

## Règle de hiérarchie

Sur une même page :

```
PrimaryButton     → UNE seule action principale
SecondaryButton   → Action alternative ou complémentaire
TextLink          → Sortie de flux ou action tertiaire
```

Le TextLink ne doit jamais avoir une couleur `color-primary` — il resterait neutre pour ne pas créer de compétition visuelle avec le PrimaryButton.

---

_Composant Design System — App Finance UEMOA_
