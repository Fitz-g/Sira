# 02 : Kofi Suit ses Dépenses et Pilote son Budget

**Projet :** App Finance UEMOA
**Créé :** 2026-04-04
**Méthode :** WDS

---

## Transaction (Q1)
Saisir une dépense du quotidien en quelques secondes et voir instantanément l'impact sur son budget mensuel.

## Objectif Business (Q2)
**Objectif :** O2 — Créer une transformation financière réelle
**Sous-objectif :** 2.2 — 70% des utilisateurs actifs créent ≥1 objectif dans le premier mois

## Utilisateur & Situation (Q3)
**Persona :** L'Actif en Progression (Priorité 1)
**Situation :** Kofi, 32 ans, à la pause déjeuner. Vient de payer son repas et veut le noter avant d'oublier. Il est dehors, pressé.

## Forces Motrices (Q4)
**Espoir :** Noter sa dépense en 10 secondes et voir où il en est sur son budget.
**Crainte :** Que la saisie soit longue et fastidieuse, et qu'il abandonne l'habitude au bout de 3 jours.

## Appareil & Point d'Entrée (Q5 + Q6)
**Appareil :** Mobile Android
**Entrée :** Ouvre l'app directement depuis son écran d'accueil, sur le chemin du retour au bureau.

## Meilleur Résultat (Q7)
**Succès utilisateur :** Dépense notée en moins de 15 secondes, budget mensuel mis à jour en temps réel.
**Succès business :** Usage quotidien établi — rétention et métriques d'engagement actif.

## Chemin le Plus Court (Q8)
1. **Saisie dépense** — Saisit montant, catégorie, note rapide
2. **Liste des dépenses** — Voit sa dépense ajoutée + historique du mois
3. **Budget mensuel** — Voit l'impact sur son enveloppe mensuelle ✓

## Connexions Trigger Map
- ✅ **Désir :** Voir clairement où va son argent [Score 15]
- ❌ **Crainte :** Frustration de tout réexpliquer à l'IA sans mémoire [Score 14]
- **Objectif :** O2 / 2.2

## Étapes du Scénario
| Étape | Dossier | Objectif | Action de sortie |
|-------|---------|---------|-----------------|
| 02.1 | `02.1-saisie-depense/` | Saisir rapidement une dépense | Valide la saisie |
| 02.2 | `02.2-liste-depenses/` | Confirmer l'ajout + voir l'historique | Tape "Voir mon budget" |
| 02.3 | `02.3-budget-mensuel/` | Voir l'impact sur le budget | Succès ✓ |
