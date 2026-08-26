# Story 2.2: Liste des dépenses filtrable

Status: in-progress

## Story

As a utilisateur,
I want relire mes dépenses par période et par catégorie,
so that je comprenne où part mon argent.

## Acceptance Criteria

1. **Given** j'ouvre la liste de mes dépenses **When** elle s'affiche **Then** les dépenses du mois en cours apparaissent, regroupées par jour **And** le total du mois est affiché en tête
2. **Given** je consulte le sélecteur de mois **When** je touche le chevron précédent ou suivant **Then** la liste et le total se mettent à jour pour ce mois
3. **Given** je filtre par catégorie **When** je choisis une catégorie **Then** seules les dépenses de cette catégorie restent affichées, et le total reflète le filtre
4. **Given** aucune dépense n'existe pour la période choisie **When** la liste s'affiche **Then** un message encourageant remplace la liste, avec une action pour saisir la première (FR51)
5. **Given** la liste contient 10 000 dépenses **When** je la fais défiler **Then** le défilement reste fluide (NFR-SC3)

## Découpage en étapes

Livré et vérifié étape par étape, jamais d'un bloc.

- [x] **Étape 1** — La ligne de dépense : pastille colorée par catégorie, libellé, note, montant
- [x] **Étape 2** — La liste groupée par jour et l'état vide
- [~] **Étape 3** — Le sélecteur de mois et le total ✓ · le filtre par catégorie reste à faire
- [ ] **Étape 4** — Le balayage pour supprimer, avec confirmation
- [ ] **Étape 5** — Le toast d'arrivée depuis la saisie et le lien vers le budget

## Dev Notes

**Les couleurs par catégorie arrivent avec cette story.** Jusqu'ici toutes les
pastilles étaient vertes. Huit teintes distinctes donnent à la liste le rythme
qui lui manque — l'œil distingue une ligne « Transport » d'une ligne
« Alimentation » sans lire le libellé.

**Le rouge des catégories n'est pas le rouge des erreurs.** `Santé` prend un
rose soutenu et non `color-error` : un pictogramme rouge dans une liste ne doit
pas se lire comme une alerte.

**Défilement paresseux obligatoire** (AC 5) : une liste construite d'un bloc
tiendrait mal à 10 000 lignes. `ListView.builder`, jamais un `Column` dans un
`SingleChildScrollView`.

### Project Structure Notes

- Ligne : `lib/features/transactions/presentation/widgets/expense_row.dart`
- Écran : `lib/features/transactions/presentation/expense_list_screen.dart`
- Route à déclarer : `/depenses`
- Couleurs de catégorie : `lib/core/constants/expense_categories.dart`
- Réutiliser `IconPill`, `AppCard`, `PageHeader`, `EmptyState`, `SelectionChips`

### References

- Spécification `02.2-liste-depenses.md` — `OBJ-08-1` à `OBJ-08-6`
- `epics.md` — Epic 2, story 2.2
- FR14 · FR51 · NFR-SC3

## Dev Agent Record

### Agent Model Used

Claude Opus 5

### Debug Log References

### Completion Notes List

**Étape 3, première moitié — la navigation par mois.** Un état de filtrage
distinct porte le mois consulté. Il est volontairement séparé de
`currentMonthExpensesProvider`, que le tableau de bord utilise : parcourir
l'historique depuis la liste ne doit pas changer le total du tableau de bord.

Le chevron avant se désactive au-delà du mois en cours — une dépense ne se
saisit pas dans le futur, et un mois vide par nature n'apprendrait rien.
Désactivé et non masqué : un bouton visiblement inerte vaut mieux qu'un bouton
qui ne répond pas sans dire pourquoi.

Pendant la lecture, le total affiche un tiret et non zéro : « 0 » ferait croire
un instant qu'il n'y a rien.

`MonthSelector` rejoint le Design System. 9 tests, 85 au total.

**Étape 2 — la liste.** Regroupement par journée, chaque jour avec son en-tête
et son total. `Dates.relativeDay` dit « Aujourd'hui » et « Hier » plutôt qu'une
date : un utilisateur qui relit ses dépenses du jour le lit plus vite.
`groupByDay` est une fonction pure, testée seule, sans Flutter ni base.
Construction paresseuse pour tenir à 10 000 lignes (NFR-SC3).

La route `/depenses` est déclarée dès cette étape, et non à la fin comme prévu
initialement : sans elle, les étapes 2 à 4 auraient été invisibles à l'écran.
La carte du mois, sur le tableau de bord, y mène. 9 tests, 76 au total.

**Étape 1 — la ligne de dépense.** Huit teintes distinctes, une par catégorie ;
un test vérifie qu'aucune ne se répète, sans quoi la pastille perdrait son
intérêt. `categoryById` fait retomber un identifiant inconnu sur « Autre » :
une base écrite par une version antérieure ne doit pas casser l'affichage.
Une note faite d'espaces n'ouvre pas de seconde ligne. 6 tests, 67 au total.

### File List
