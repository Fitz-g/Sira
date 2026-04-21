# 05 : Kofi Crée et Suit son Premier Objectif d'Épargne

**Projet :** App Finance UEMOA
**Créé :** 2026-04-04
**Méthode :** WDS

---

## Transaction (Q1)
Créer un objectif d'épargne concret avec montant cible et date limite, et voir la progression automatique.

## Objectif Business (Q2)
**Objectif :** O2 — Créer une transformation financière réelle
**Sous-objectif :** 2.2 — 70% des utilisateurs actifs créent ≥1 objectif dans le premier mois

## Utilisateur & Situation (Q3)
**Persona :** L'Actif en Progression (Priorité 1)
**Situation :** Kofi, en soirée chez lui. Après quelques jours d'utilisation, il réalise qu'il peut épargner pour acheter une moto dans 8 mois. Il veut structurer cet objectif.

## Forces Motrices (Q4)
**Espoir :** Avoir un plan concret — un montant mensuel calculé automatiquement pour son objectif moto.
**Crainte :** Que l'objectif soit déclaré irréaliste par rapport à ses revenus et qu'il se décourage.

## Appareil & Point d'Entrée (Q5 + Q6)
**Appareil :** Mobile Android
**Entrée :** Appuie sur "Créer un objectif" depuis le dashboard ou le menu Objectifs.

## Meilleur Résultat (Q7)
**Succès utilisateur :** Objectif créé, montant mensuel à épargner calculé automatiquement, progression trackée.
**Succès business :** Engagement profond — utilisateur ancré dans l'app par un objectif personnel concret.

## Chemin le Plus Court (Q8)
1. **Liste des objectifs** — Voit ses objectifs (vide au départ), appuie sur "Créer"
2. **Créer un objectif** — Saisit nom, montant cible, date limite
3. **Détail d'un objectif** — Voit la progression + montant mensuel recommandé ✓

## Connexions Trigger Map
- ✅ **Désir :** Créer un premier objectif d'épargne concret [Score 13]
- ❌ **Crainte :** Peur de ne jamais pouvoir épargner [Score 13]
- **Objectif :** O2 / 2.2

## Étapes du Scénario
| Étape | Dossier | Objectif | Action de sortie |
|-------|---------|---------|-----------------|
| 05.1 | `05.1-liste-objectifs/` | Accéder à l'espace objectifs | Tape "Créer un objectif" |
| 05.2 | `05.2-creer-objectif/` | Configurer l'objectif | Valide la création |
| 05.3 | `05.3-detail-objectif/` | Voir la projection et le plan mensuel | Succès ✓ |
