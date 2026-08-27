# Story 2.4: Définition d'un budget mensuel par catégorie

Status: in-progress

## Story

As a utilisateur qui veut se fixer des limites,
I want attribuer un montant mensuel à chaque catégorie,
so that je sache quand je dépasse.

## Acceptance Criteria

1. **Given** j'ouvre l'écran du budget **When** il s'affiche **Then** chaque catégorie de dépense y figure avec son enveloppe, vide ou renseignée
2. **Given** je saisis un montant pour une catégorie **When** j'enregistre **Then** ce montant devient l'enveloppe du mois en cours
3. **Given** j'ai défini des enveloppes le mois précédent **When** un nouveau mois commence **Then** les mêmes enveloppes sont reconduites par défaut
4. **Given** je laisse une catégorie sans enveloppe **When** je consulte le budget **Then** cette catégorie n'affiche pas de barre de progression, sans être signalée comme une erreur

## Découpage en étapes

- [x] **Étape 1** — La table `budgets`, sa migration, et le service
- [ ] **Étape 2** — L'écran de définition : chaque catégorie avec son champ (AC 1, 2, 4)
- [ ] **Étape 3** — La reconduction d'un mois sur l'autre (AC 3)

## Dev Notes

**Les barres de progression appartiennent à la story 2.5**, pas à celle-ci. La
spécification 02.3 les décrit — l'écran les porte — mais comparer le dépensé à
l'enveloppe est le sujet de la story suivante. La 2.4 se limite à poser les
enveloppes.

**La reconduction ne recopie rien en base.** Un mois sans enregistrement hérite
du dernier mois renseigné, à la lecture. Recopier chaque mois demanderait une
tâche de fond, et figerait un budget que l'utilisateur n'a jamais confirmé.

**À reprendre ici :** le critère 5 de la story 2.3 demande que le budget de la
catégorie soit recalculé après suppression d'une dépense. Les budgets n'existant
pas alors, la clause a été reportée. Elle relève désormais de la story 2.5, qui
introduit la comparaison — c'est là qu'un recalcul a un sens.

### Project Structure Notes

- Table : `Budgets` dans `lib/data/local/app_database.dart`, schéma v2
- Service : `lib/data/services/budgets_service.dart`
- Écran : `lib/features/budget/presentation/budget_screen.dart` (étape 2)
- Route à déclarer : `/budget` ; le lien existe déjà sur la liste des dépenses

### References

- Spécification `02.3-budget-mensuel.md` — `OBJ-09-1`, `OBJ-09-5`
- `epics.md` — Epic 2, story 2.4
- FR15

## Dev Agent Record

### Agent Model Used

Claude Opus 5

### Debug Log References

`flutter analyze` : aucun problème. `flutter test` : 126 tests au vert.

### Completion Notes List

**Étape 1 — la table et le service.** Une ligne par catégorie et par mois, avec
une contrainte d'unicité sur ce couple : c'est ce qui permet de changer de
budget d'un mois à l'autre sans réécrire l'historique.

**Migration en v2.** Une base v1 existe déjà sur l'appareil de Fitz — la table
s'ajoute sans toucher aux dépenses saisies.

Deux choix qui portent du sens :

- **Un montant nul retire l'enveloppe.** Ne rien allouer est une réponse
  valable, et l'utilisateur doit pouvoir revenir en arrière.
- **Une catégorie sans enveloppe est absente de la carte**, et non présente à
  zéro. Ne rien avoir alloué et avoir alloué zéro ne sont pas la même chose —
  la première n'affichera pas de barre, la seconde serait toujours dépassée.

**Un défaut instructif rencontré :** `insertOnConflictUpdate` résout le conflit
sur la clé primaire. Chaque insertion produisant un identifiant neuf, la clé
primaire n'entrait jamais en conflit, et l'ancienne enveloppe restait en place.
Le `catch` avalait l'erreur en silence — seule la relecture a révélé le
problème. Le conflit vise désormais explicitement la contrainte d'unicité.

12 tests, 126 au total.

### File List

- `lib/data/local/app_database.dart` + `.g.dart` (table `Budgets`, schéma v2)
- `lib/data/services/budgets_service.dart` (créé)
- `test/unit/budgets/budgets_service_test.dart` (créé)
