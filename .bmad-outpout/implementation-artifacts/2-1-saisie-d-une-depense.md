# Story 2.1: Saisie d'une dépense

Status: review

## Story

As a utilisateur pressé, debout dans la rue,
I want noter une dépense en moins de 15 secondes,
so that l'habitude tienne au-delà de trois jours.

## Acceptance Criteria

1. **Given** j'ouvre la saisie d'une dépense **When** l'écran s'affiche **Then** le clavier numérique est déjà ouvert et le curseur dans le champ du montant
2. **Given** je saisis un montant **When** je tape les chiffres **Then** le montant s'affiche formaté avec ses séparateurs de milliers, suivi de FCFA
3. **Given** huit catégories me sont proposées **When** je les parcours **Then** elles défilent horizontalement, chacune avec son pictogramme
4. **Given** je n'ai pas choisi de catégorie **When** j'enregistre **Then** la dépense est classée dans « Autre »
5. **Given** le montant est à zéro **When** je regarde le bouton d'enregistrement **Then** il est inactif
6. **Given** j'ai saisi un montant valide **When** j'enregistre **Then** la dépense est stockée localement, même sans connexion (NFR-R2) **And** un retour visuel me le confirme en moins d'une seconde (NFR-P6)

## Tasks / Subtasks

- [x] Poser la base locale — première story qui persiste quelque chose
  - [x] `drift` : `AppDatabase` dans `lib/data/local/`
  - [x] Table `transactions` **et elle seule** : montant, catégorie, note, date
  - [x] Le montant est un entier en base comme en Dart, jamais un flottant
  - [x] Ouverture du fichier via `path_provider`, une seule instance partagée
- [x] Service et provider de dépenses
  - [x] `TransactionsService` retournant un `Result<T>`
  - [x] Provider Riverpod exposant l'ajout et la liste du mois
  - [x] Aucun accès à la base depuis un widget
- [x] Écran de saisie — spécification 02.1
  - [x] En-tête avec bouton fermer (AC: 1)
  - [x] Affichage du montant en `heading-4xl`, clavier ouvert d'emblée (AC: 1, 2)
  - [x] Chips de catégories en défilement horizontal (AC: 3)
  - [x] Champ note facultatif, 60 caractères au maximum
  - [x] Bouton inactif tant que le montant est nul (AC: 5)
  - [x] Enregistrement puis retour, avec confirmation (AC: 6)
- [x] Brancher le tableau de bord sur les dépenses réelles
  - [x] L'action « Dépense » ouvre cet écran au lieu d'annoncer sa venue
  - [x] Le résumé du mois affiche le total quand des dépenses existent
- [x] Tests
  - [x] Unitaires : le service écrit et relit une dépense, le montant reste entier
  - [x] Widget : bouton inactif à zéro, catégorie par défaut, formatage du montant

## Dev Notes

**Le clavier ouvert d'emblée est le cœur de cette story.** L'objectif est de
tenir en quinze secondes, debout, dehors. Chaque geste supplémentaire — toucher
le champ, chercher une catégorie dans une liste déroulante — met l'habitude en
péril. C'est ce qui justifie le clavier immédiat, le défilement horizontal des
catégories, et la note reléguée en facultatif.

**Ne créer que la table `transactions`.** La méthode l'exige : chaque story crée
uniquement ce dont elle a besoin. Les budgets, dettes et objectifs viendront
avec leurs stories respectives.

**Montants en entiers de bout en bout.** En base comme en Dart. Un `REAL` SQLite
introduirait des arrondis invisibles jusqu'au jour où un total serait faux.

**Le mode hors connexion n'est pas un cas limite ici** : l'écriture est locale
par défaut. La synchronisation vers Supabase viendra plus tard et ne doit pas
être anticipée — le service écrit dans drift, un point c'est tout.

### Project Structure Notes

- Base : `lib/data/local/app_database.dart`
- Service : `lib/data/services/transactions_service.dart`
- Providers : `lib/features/transactions/providers/`
- Écran : `lib/features/transactions/presentation/expense_entry_screen.dart`
- Route à déclarer : `/depenses/ajouter`
- Catégories déjà définies : `lib/core/constants/expense_categories.dart`
- Réutiliser `PageHeader`, `SelectionChips` (`ChipsLayout.scroll`), `AppInput`,
  `PrimaryButton`, `AppToast`

### References

- Spécification `02.1-saisie-depense.md` — `OBJ-07-1` à `OBJ-07-5`
- `epics.md` — Epic 2, story 2.1
- `architecture.md` — patterns de persistance, `Result<T>`, montants entiers
- FR12 · NFR-R2, NFR-P6, NFR-SC3

## Dev Agent Record

### Agent Model Used

Claude Opus 5

### Debug Log References

`flutter analyze` : aucun problème. `flutter test` : 61 tests au vert,
dont 11 sur le service et 6 sur l'écran.

### Completion Notes List

- **L'application persiste enfin ses données.** Jusqu'ici tout vivait en mémoire
  et disparaissait au redémarrage. La base locale ne contient que la table
  `transactions`, conformément à la règle qui veut qu'une story ne crée que ce
  dont elle a besoin.
- Le tableau de bord n'annonce plus le suivi des dépenses : il l'ouvre, et son
  résumé du mois affiche le total réel dès qu'une dépense existe.

**Trois obstacles rencontrés, tous documentés ici pour la suite :**

1. **Le générateur de code restait bloqué.** `riverpod_generator` était déclaré
   sans jamais servir — les providers sont écrits à la main — et son `analyzer`
   ne supportait pas Dart 3.13 : il plantait sur `visitDotShorthandPropertyAccess`.
   Retiré. `drift` et `drift_dev` souffraient du même mal et sont passés de
   2.22 à 2.34. La génération, jusque-là interminable, prend 18 secondes.
2. **`tester.enterText` court-circuite les formateurs de saisie.** Vérifier le
   formatage depuis un test de widget ne prouvait donc rien. Le formateur a
   désormais ses propres tests unitaires, et le test de widget se contente de
   vérifier que le champ le porte.
3. **Le séparateur de milliers français est une espace insécable** (U+00A0), pas
   une espace ordinaire. Deux chaînes visuellement identiques ne l'étaient pas.
   Le test nomme désormais le caractère explicitement.

**Point ouvert :** l'écran n'a pas été vu dans un navigateur. Les tests couvrent
le comportement, mais les défauts d'affichage — troncatures, alignements — ne se
voient qu'à l'écran, et c'est ainsi que quatre d'entre eux ont été trouvés
jusqu'ici.

### File List

- `lib/data/local/app_database.dart` + `.g.dart` (créés)
- `lib/data/models/result.dart` (créé)
- `lib/data/services/transactions_service.dart` (créé)
- `lib/features/transactions/providers/transactions_provider.dart` (créé)
- `lib/features/transactions/presentation/expense_entry_screen.dart` (créé)
- `lib/core/utils/currency_input_formatter.dart` (créé, extrait de `AppInput`)
- `lib/core/router/app_router.dart` (route `/depenses/ajouter`)
- `lib/features/dashboard/presentation/dashboard_screen.dart` (total réel)
- `pubspec.yaml` (drift 2.34, riverpod_generator retiré)
- `test/unit/transactions/transactions_service_test.dart` (créé)
- `test/unit/utils/currency_input_formatter_test.dart` (créé)
- `test/widget/expense_entry_screen_test.dart` (créé)
