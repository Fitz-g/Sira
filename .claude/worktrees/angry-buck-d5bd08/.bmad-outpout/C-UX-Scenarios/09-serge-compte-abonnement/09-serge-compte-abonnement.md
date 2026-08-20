# 09 : Serge Gère son Compte et Souscrit

**Projet :** App Finance UEMOA
**Créé :** 2026-04-04
**Méthode :** WDS

---

## Transaction (Q1)
Se connecter à un compte existant, intégrer Wave, et souscrire à un plan d'abonnement.

## Objectif Business (Q2)
**Objectif :** O1 — Construire une base d'abonnés actifs et rentable
**Sous-objectif :** 1.3 — Revenus récurrents couvrant les coûts opérationnels à 18 mois

## Utilisateur & Situation (Q3)
**Persona :** Le Professionnel Débordé (Priorité 2)
**Situation :** Serge, convaincu par l'app après avoir vu son plan de remboursement. Il veut connecter son Wave pour automatiser le suivi de ses transactions et passer à un plan payant.

## Forces Motrices (Q4)
**Espoir :** Tout connecter en une session et avoir l'app complète avec ses transactions Wave automatiques.
**Crainte :** Que l'intégration Wave soit compliquée ou ne fonctionne pas, et qu'il perde du temps.

## Appareil & Point d'Entrée (Q5 + Q6)
**Appareil :** Mobile Android
**Entrée :** Navigue vers "Profil" depuis le menu principal, puis "Paramètres & intégrations".

## Meilleur Résultat (Q7)
**Succès utilisateur :** Wave connecté, profil complet, abonnement actif — ses transactions Wave s'importent automatiquement.
**Succès business :** Conversion payante confirmée + intégration partenaire activée — objectif 1.3 en progression.

## Chemin le Plus Court (Q8)
1. **Profil utilisateur** — Vérifie et complète ses informations
2. **Paramètres & intégrations** — Connecte son compte Wave en quelques taps
3. **Abonnement** — Choisit son plan (mensuel / annuel), confirme ✓

## Connexions Trigger Map
- ✅ **Désir :** Reprendre le contrôle et avoir l'app complète [Score 14]
- ❌ **Crainte :** Peur que les intégrations ne fonctionnent pas
- **Objectif :** O1 / 1.3

## Étapes du Scénario
| Étape | Dossier | Objectif | Action de sortie |
|-------|---------|---------|-----------------|
| 09.1 | `09.1-profil/` | Compléter son profil | Navigue vers Paramètres |
| 09.2 | `09.2-parametres-integrations/` | Connecter Wave | Valide l'intégration |
| 09.3 | `09.3-abonnement/` | Choisir et confirmer le plan | Succès ✓ |
