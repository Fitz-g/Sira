# Story 2.3: Modification et suppression d'une dépense

Status: in-progress

## Story

As a utilisateur qui s'est trompé,
I want corriger ou effacer une dépense,
so that mes chiffres restent justes.

## Acceptance Criteria

1. **Given** je touche une dépense de la liste **When** l'écran s'ouvre **Then** ses champs sont préremplis et modifiables
2. **Given** je modifie le montant et j'enregistre **When** je reviens à la liste **Then** la ligne et le total du mois reflètent la modification
3. **Given** je fais glisser une ligne vers la gauche **When** le geste se termine **Then** un bouton de suppression rouge apparaît
4. **Given** je touche ce bouton de suppression **When** la boîte de dialogue s'affiche **Then** une confirmation m'est demandée avant tout effacement
5. **Given** je confirme la suppression **When** la liste se rafraîchit **Then** la dépense a disparu, le total est recalculé, et le budget de sa catégorie aussi

## Découpage en étapes

- [x] **Étape 1** — Ouvrir une dépense en édition, préremplie, et l'enregistrer (AC 1, 2)
- [ ] **Étape 2** — Le balayage vers la gauche et la confirmation (AC 3, 4)
- [ ] **Étape 3** — Recalcul de ce qui dépend d'une dépense modifiée ou effacée (AC 5)

## Dev Notes

**L'écran de saisie sert aussi à l'édition.** Deux écrans pour un même
formulaire divergeraient à la première évolution — un champ ajouté d'un côté et
pas de l'autre. `ExpenseEntryScreen` reçoit donc une dépense facultative :
absente, il crée ; présente, il modifie.

**Le balayage arrive de la story 2.2.** Il figurait dans son découpage parce que
la spécification 02.2 le décrit, mais ses critères d'acceptation sont ici.

**Le budget de la catégorie** mentionné au critère 5 n'existe pas encore — il
vient avec la story 2.4. À traiter à ce moment-là, pas avant.

### Project Structure Notes

- Écran partagé : `lib/features/transactions/presentation/expense_entry_screen.dart`
- Service : `TransactionsService.update` à ajouter ; `remove` existe et est testé
- Route à déclarer : `/depenses/modifier`, la dépense passée en `extra`
- `ExpenseRow` porte déjà un `onTap`, il n'est pas branché

### References

- Spécification `02.2-liste-depenses.md` — `OBJ-08-4`
- `epics.md` — Epic 2, story 2.3
- FR13

## Dev Agent Record

### Agent Model Used

Claude Opus 5

### Debug Log References

### Completion Notes List

**Étape 1 — l'édition.** Toucher une ligne ouvre le formulaire, prérempli. Le
même écran sert à créer et à modifier : deux écrans divergeraient à la première
évolution.

Deux points de justesse :

- **La date d'origine est conservée.** Corriger un montant ne doit pas déplacer
  la dépense dans le temps — elle changerait de journée dans la liste, voire de
  mois. Un test le verrouille.
- **Vider la note l'efface** plutôt que d'enregistrer une chaîne vide. Une note
  faite d'espaces n'est pas une note.

`update` signale un identifiant inconnu par `false` plutôt que par une erreur :
une dépense supprimée depuis un autre écran n'est pas une panne.

9 tests ajoutés, 102 au total.

### File List
