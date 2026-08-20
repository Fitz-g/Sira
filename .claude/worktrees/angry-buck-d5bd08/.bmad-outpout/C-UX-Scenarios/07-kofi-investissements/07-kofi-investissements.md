# 07 : Kofi Suit ses Investissements BRVM

**Projet :** App Finance UEMOA
**Créé :** 2026-04-04
**Méthode :** WDS

---

## Transaction (Q1)
Ajouter un investissement BRVM et suivre sa performance avec des données locales réelles.

## Objectif Business (Q2)
**Objectif :** O3 — S'imposer comme la référence finance perso en zone UEMOA
**Sous-objectif :** 3.1 — 10 000 utilisateurs enregistrés à 24 mois / ancrage UEMOA-first

## Utilisateur & Situation (Q3)
**Persona :** L'Actif en Progression (Priorité 1)
**Situation :** Kofi vient d'acheter ses premières actions BRVM via un SGI partenaire. Il veut les tracker dans l'app pour avoir tout au même endroit.

## Forces Motrices (Q4)
**Espoir :** Voir la performance de son investissement avec les vrais cours BRVM, dans la même app que ses finances perso.
**Crainte :** Que l'app ne reconnaisse pas les titres BRVM ou affiche des données incorrectes.

## Appareil & Point d'Entrée (Q5 + Q6)
**Appareil :** Mobile Android
**Entrée :** Navigue vers "Investissements" depuis le menu principal après avoir reçu sa confirmation d'achat BRVM.

## Meilleur Résultat (Q7)
**Succès utilisateur :** Investissement ajouté, performance trackée avec cours BRVM réels, visible dans son tableau de bord global.
**Succès business :** Différenciateur UEMOA-first validé — rétention long terme et positionnement unique.

## Chemin le Plus Court (Q8)
1. **Liste des investissements** — Voit l'espace investissements, appuie sur "Ajouter"
2. **Détail d'un investissement** — Saisit le titre BRVM, quantité, prix d'achat — voit la performance en temps réel ✓

## Connexions Trigger Map
- ✅ **Désir :** Simuler un investissement BRVM avec données réelles [Score 12]
- ❌ **Crainte :** Peur que les données ne soient pas adaptées au contexte UEMOA
- **Objectif :** O3 / 3.1

## Étapes du Scénario
| Étape | Dossier | Objectif | Action de sortie |
|-------|---------|---------|-----------------|
| 07.1 | `07.1-liste-investissements/` | Accéder à l'espace investissements | Tape "Ajouter" |
| 07.2 | `07.2-detail-investissement/` | Configurer et suivre l'investissement BRVM | Succès ✓ |
