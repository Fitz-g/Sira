# Story 1.9: Tableau de bord initial personnalisé

Status: review

## Story

As a utilisateur qui vient de terminer l'onboarding,
I want voir immédiatement une vue qui me ressemble,
so that je constate que l'application a compris ma situation.

## Acceptance Criteria

1. **Given** je viens de terminer l'onboarding **When** mon tableau de bord s'affiche **Then** il me salue par mon prénom **And** il affiche un résumé de ma situation déclarée, trois actions rapides et un conseil tiré de mes réponses
2. **Given** je n'ai encore saisi aucune dépense **When** je consulte mon tableau de bord **Then** l'emplacement du score de santé financière annonce qu'il apparaîtra avec mes premières dépenses **And** aucun chiffre inventé n'est affiché à sa place
3. **Given** le tableau de bord se charge sur un réseau 3G **When** je mesure le délai **Then** les données apparaissent en moins de 3 secondes (NFR-P2)
4. **Given** les trois actions rapides sont affichées **When** je les consulte **Then** elles mènent respectivement à la saisie d'une dépense, aux objectifs et au simulateur
5. **Given** je n'ai encore saisi aucune dépense **When** je consulte le résumé du mois **Then** un message encourageant remplace les chiffres, avec une action pour démarrer (FR51)
6. **Given** les données sont en cours de chargement **When** l'écran s'affiche **Then** des squelettes occupent la place des cartes, jamais un écran blanc

## Tasks / Subtasks

- [x] Remplacer le tableau de bord provisoire par sa forme spécifiée (AC: 1)
  - [ ] En-tête `PageHeader` variante `primary` avec salutation nominative — **le prénom n'existe pas tant que la story 1.2 n'est pas faite**
  - [x] Card résumé de la situation déclarée à l'onboarding
  - [x] Card conseil, variante `info`, dérivée de l'objectif choisi
- [x] Emplacement réservé du score de santé financière (AC: 2)
  - [x] Message annonçant son apparition, sans chiffre ni jauge factice
- [x] Trois actions rapides au tiers de largeur (AC: 4)
  - [x] Libellés courts : Dépense, Objectif, Simuler
  - [x] Le bouton Simuler ouvre enfin le simulateur — première entrée réelle
  - [x] Dépense et Objectif mènent vers leurs états vides tant que les epics 2 et 5 n'existent pas
- [x] État vide du résumé du mois (AC: 5)
  - [x] Ton encourageant conforme à UX-DR1 — carte dédiée plutôt que `EmptyState`, qui occupe tout l'écran et ne convient pas à une section
- [ ] Squelettes de chargement (AC: 6) — **sans objet pour l'instant** : les données sont en mémoire, aucun chargement asynchrone à couvrir. À traiter avec la story 1.8, qui introduit la persistance
- [x] Tests de widget couvrant la salutation, l'emplacement du score, les trois actions et l'état vide

## Dev Notes

Le tableau de bord actuel (`lib/features/dashboard/presentation/dashboard_screen.dart`)
est un provisoire écrit pour vérifier que l'onboarding aboutissait. Il restitue
le brouillon collecté sous forme de `RecapRow`. Cette story le remplace.

Le score de santé financière **n'est pas** de son ressort : il arrive avec la
story 2.7, quand les dépenses existeront. Cette story se contente de lui réserver
sa place et de dire qu'il viendra. Ne pas afficher de jauge grisée ni de valeur
par défaut — un chiffre financier faux vaut moins que pas de chiffre.

Le bouton « Simuler » est la correction apportée à la spécification 01.6 le
2026-08-20 : le scénario 03 supposait cette entrée, la spécification de l'écran
ne la portait pas, et le simulateur était donc inatteignable. Cette story le
rend joignable.

Les données proviennent pour l'instant du `onboardingProvider`, en mémoire. La
persistance est l'objet de la story 1.8 ; ne pas l'anticiper ici.

### Project Structure Notes

- Écran : `lib/features/dashboard/presentation/dashboard_screen.dart`
- Widgets propres au domaine : `lib/features/dashboard/presentation/widgets/`
- Route : `Routes.dashboard` — `/accueil`, déjà déclarée
- Réutiliser `PageHeader`, `AppCard`, `MetricRow`, `SecondaryButton`, `EmptyState`
- Aucun nouveau composant partagé attendu ; si un besoin apparaît, il rejoint
  `lib/shared/widgets/` et le Design System

### References

- Spécification `01.6-dashboard.md` — sections S1 à S6, `OBJ-06-1` à `OBJ-06-8`
- `epics.md` — Epic 1, story 1.9
- Design System — `components/card.component.md`, `components/empty-state.component.md`
- FR10, FR51 · NFR-P2 · UX-DR1

## Dev Agent Record

### Agent Model Used

Claude Opus 5

### Debug Log References

`flutter analyze` : aucun problème. `flutter test` : 39 tests au vert.

### Completion Notes List

- Le tableau de bord provisoire est remplacé. Sept tests de widget le couvrent.
- **Trois critères ne sont pas pleinement satisfaits, et c'est assumé :**
  - AC 1 — la salutation reste générique. Le prénom vient de l'inscription
    (story 1.2), qui n'est pas construite.
  - AC 3 — le délai de chargement sur 3G n'est pas mesurable : aucune donnée ne
    transite par le réseau à ce stade.
  - AC 6 — aucun squelette de chargement : il n'y a rien d'asynchrone à couvrir.
    À traiter avec la story 1.8, qui introduit la persistance.
  Ces trois points relèvent de stories ultérieures, pas d'un travail bâclé ici.
- **Deux troncatures corrigées après examen du rendu réel**, invisibles à
  l'analyse statique :
  - les trois actions rapides affichaient « Dép… », « Obje… », « Sim… » ;
    l'icône et un texte de 16 px ne tiennent pas dans un tiers de largeur. Elles
    passent en disposition verticale, pictogramme au-dessus du libellé.
  - la fourchette de revenus était tronquée dans une colonne de `MetricRow`.
    La situation déclarée passe en lignes pleine largeur (`RecapRow`).
- **Barre de navigation non construite — décision à prendre.** La spécification
  01.6 prévoit cinq onglets, dont « Assistant ». Or l'assistant financier vient
  d'être écarté du MVP. La barre ne peut donc pas être posée telle quelle : sa
  composition doit être arbitrée avant d'être implémentée. Elle relève de la
  structure d'ensemble de l'application, pas de cet écran seul.
- Les actions « Dépense » et « Objectif » signalent ce qui vient plutôt que de
  mener à un écran vide, tant que les epics 2 et 5 n'existent pas.

### File List

- `lib/features/dashboard/presentation/dashboard_screen.dart` (remplacé)
- `lib/features/dashboard/presentation/widgets/score_placeholder.dart` (créé)
- `lib/features/dashboard/presentation/widgets/goal_advice.dart` (créé)
- `test/widget/dashboard_screen_test.dart` (créé)
