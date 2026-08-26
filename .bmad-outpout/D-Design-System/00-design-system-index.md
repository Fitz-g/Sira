# Design System — App Finance UEMOA

**Date de création :** 2026-05-01
**Source :** 24 spécifications de pages (Phase 4 — Specify)
**Méthode :** Whiteport Design Studio (WDS)

---

## Tokens

| Fichier | Contenu | Statut |
|---------|---------|--------|
| [Typography](tokens/typography.md) | 9 tokens taille, 6 tokens poids, associations sémantiques | Extrait |
| [Spacing](tokens/spacing.md) | 5 tokens espacement, conteneurs, safe areas | Extrait |
| [Colors](tokens/colors.md) | 14 rôles de couleur, palette sémantique, mapping composants | Extrait (valeurs hex en Phase Visual) |
| [Interactions](tokens/interactions.md) | Animations, transitions, gestes, patterns formulaires | Extrait |

---

## Iconographie

**Jeu retenu : Lucide** — `lucide_icons_flutter`, trait uniforme de 2 px, licence ISC.

Aucun emoji dans l'interface. Les emojis dépendent de la police système : leur rendu change d'un appareil à l'autre, leur style ne s'accorde à aucune charte, et ils ne prennent pas la couleur du thème. Un jeu d'icônes vectoriel règle les trois.

Phosphor avait été essayé d'abord : il étend `IconData`, devenue une classe `final` dans Flutter 3.47, et ne compile plus. À vérifier avant d'envisager un retour.

| Usage | Icône |
|-------|-------|
| Retour, fermer | `chevronLeft`, `x` |
| Ajouter | `plus` |
| Validation, erreur, information | `circleCheck`, `circleX`, `info` |
| Mot de passe | `eye`, `eyeOff` |
| Score de santé | `gauge` |
| Catégories de dépenses | `utensils`, `bus`, `house`, `pill`, `partyPopper`, `users`, `piggyBank`, `package` |
| Objectifs | `chartColumn`, `creditCard`, `target`, `trendingUp`, `lightbulb` |
| Simulation | `plane`, `shoppingCart`, `piggyBank`, `trendingUp`, `target` |

---

## Composants

| Fichier | Type | Usages | Statut |
|---------|------|--------|--------|
| [PageHeader](components/page-header.component.md) | Layout | 24 specs | Extrait |
| [PrimaryButton](components/primary-button.component.md) | Action | 15+ specs | Extrait |
| [Card](components/card.component.md) | Contenu (5 variantes) | 10+ specs | Extrait |
| [Input](components/input.component.md) | Formulaire (text, email, password, number) | 12 specs | Extrait |
| [SecondaryButton + TextLink](components/secondary-actions.component.md) | Actions secondaire & tertiaire | 11 specs | Extrait |
| [SelectionChips](components/selection-chips.component.md) | Sélection exclusive (grid / scroll) | 7 specs | Extrait |
| [EmptyState](components/empty-state.component.md) | État vide avec CTA | 5 specs | Extrait |
| [Toast](components/toast.component.md) | Confirmation non-bloquante | 5 specs | Extrait |

### Correspondance avec le code

Les composants sont implémentés dans `lib/shared/widgets/` (Flutter/Dart) :

| Spécification | Fichier |
|---------------|---------|
| PageHeader | `page_header.dart` |
| PrimaryButton | `primary_button.dart` |
| SecondaryButton | `secondary_button.dart` |
| TextLink | `text_link.dart` |
| Input | `app_input.dart` |
| SelectionChips | `selection_chips.dart` |
| Card + MetricRow + RecapRow | `app_card.dart` |
| EmptyState | `empty_state.dart` |
| Toast | `app_toast.dart` |
| *(feedback tactile partagé)* | `pressable_scale.dart` |
| StepProgressBar | Progression d'un parcours en étapes | 3 specs | Extrait — `step_progress_bar.dart` |
| LabeledSwitch | Interrupteur avec libellé, ligne entière tappable | 3 specs | Extrait — `labeled_switch.dart` |
| SelectionCardGrid | Cards à sélection exclusive, grille 2 colonnes | 1 spec | Extrait — `selection_card_grid.dart` |
| DurationSlider | Sélecteur de durée, libellé mois/années automatique | 1 spec | Extrait — `duration_slider.dart` |
| — | LineChart | 2 specs | À définir au fil du code |
| — | MonthSelector | 2 specs | À définir au fil du code |
| — | DynamicPreviewCard | 3 specs | → Variante de Card (preview) |
| — | ListItem (swipeable) | 4 specs | → Variante de Card (list-item) |
| — | DatePicker | 2 specs | À définir au fil du code |
| — | Avatar | 2 specs | À définir au fil du code |
| — | SkeletonLoader | 4 specs | À définir au fil du code |
| [IconPill](../../lib/shared/widgets/icon_pill.dart) | Pictogramme en pastille teintée | transverse | Extrait — `icon_pill.dart` |

---

## Composants Uniques (pas dans le Design System)

Ces composants n'apparaissent qu'une seule fois — ils restent inline dans leur spec.

| Composant | Spec | Raison |
|-----------|------|--------|
| GaugeScore | 01.6 | Spécifique au dashboard |
| ChatInterface | 06.1 | Spécifique à l'assistant IA |
| ComparisonTable | 09.3 | Spécifique à l'abonnement |
| Timeline | 04.3 | Spécifique au plan remboursement |
| IntegrationRow | 09.2 | Spécifique aux paramètres |
| NumericDisplay | 02.1 | Spécifique à la saisie dépense |
| Divider "ou" | 01.2 | Spécifique à l'inscription |
| Badge | 09.3 | Spécifique à l'abonnement |

---

## Navigation Bar

Définie dans la spec 01.6 (Dashboard), appliquée sur toutes les pages post-onboarding.

| Onglet | Label FR | Label EN | Route |
|--------|----------|----------|-------|
| Accueil | Accueil | Home | `/accueil` |
| Dépenses | Dépenses | Expenses | `/depenses` |
| Objectifs | Objectifs | Goals | `/objectifs` |
| Assistant | Assistant | Assistant | `/assistant` |
| Profil | Profil | Profile | `/profil` |

**Pages SANS navigation bar :** Onboarding (01.1-01.5), modales (02.1, 04.2, 05.2), flux simulation (03.1, 03.2)

---

## Statistiques

- **148** Object IDs à travers 24 specs
- **9** tokens typographiques
- **5** tokens d'espacement
- **14** rôles de couleur
- **6** patterns d'interaction récurrents
- **8** composants Tier 1+2 extraits (PageHeader, PrimaryButton, Card, Input, SecondaryButton, TextLink, SelectionChips, EmptyState, Toast)
- **7** composants Tier 3 à définir au fil du code
- **8** composants uniques (inline)

---

_Généré avec le framework Whiteport Design Studio (WDS)_
