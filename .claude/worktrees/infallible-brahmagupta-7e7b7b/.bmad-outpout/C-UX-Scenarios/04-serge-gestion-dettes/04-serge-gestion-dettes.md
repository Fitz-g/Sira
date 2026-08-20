# 04 : Serge Cartographie ses Dettes et Crée son Plan

**Projet :** App Finance UEMOA
**Créé :** 2026-04-04
**Méthode :** WDS

---

## Transaction (Q1)
Lister toutes ses dettes pour la première fois et obtenir un plan de remboursement structuré et atteignable.

## Objectif Business (Q2)
**Objectif :** O2 — Créer une transformation financière réelle + O1 conversion payante
**Sous-objectif :** 2.3 — NPS ≥ 50 / résolution d'un problème urgent à fort potentiel de conversion

## Utilisateur & Situation (Q3)
**Persona :** Le Professionnel Débordé (Priorité 2)
**Situation :** Serge, 40 ans, ingénieur à Lomé. Dimanche matin, vient de recevoir une notification de prélèvement. Il décide enfin de faire face à sa situation financière.

## Forces Motrices (Q4)
**Espoir :** Voir l'ensemble de ses dettes cartographiées et avoir un chemin de sortie concret.
**Crainte :** Que le total soit pire que ce qu'il imagine et qu'il n'y ait pas d'issue.

## Appareil & Point d'Entrée (Q5 + Q6)
**Appareil :** Mobile Android
**Entrée :** Navigue vers "Dettes" depuis le menu principal après avoir vu la notification de prélèvement.

## Meilleur Résultat (Q7)
**Succès utilisateur :** Toutes ses dettes listées, plan de remboursement avec ordre de priorité et calendrier mensuel — il se sent soulagé, pas jugé.
**Succès business :** Conversion payante déclenchée — problème urgent résolu, utilisateur convaincu de la valeur du produit.

## Chemin le Plus Court (Q8)
1. **Liste des dettes** — Voit l'espace vide, comprend qu'il peut tout cartographier ici
2. **Ajouter une dette** — Saisit sa première dette (montant, créancier, taux, mensualité)
3. **Plan de remboursement** — Voit son plan automatique avec ordre de priorité et calendrier ✓

## Connexions Trigger Map
- ✅ **Désir :** Plan de remboursement des dettes structuré [Score 14]
- ❌ **Crainte :** Peur que les dettes soient ingérables [Score 14]
- **Objectif :** O2 / 2.3 + O1

## Étapes du Scénario
| Étape | Dossier | Objectif | Action de sortie |
|-------|---------|---------|-----------------|
| 04.1 | `04.1-liste-dettes/` | Accéder à l'espace dettes | Tape "Ajouter une dette" |
| 04.2 | `04.2-ajouter-dette/` | Saisir les détails de la dette | Valide et ajoute |
| 04.3 | `04.3-plan-remboursement/` | Voir le plan généré automatiquement | Succès ✓ |
