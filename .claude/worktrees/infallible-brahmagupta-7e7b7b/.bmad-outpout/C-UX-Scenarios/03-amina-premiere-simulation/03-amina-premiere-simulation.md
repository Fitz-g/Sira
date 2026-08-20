# 03 : Amina Lance sa Première Simulation de Projection

**Projet :** App Finance UEMOA
**Créé :** 2026-04-04
**Méthode :** WDS

---

## Transaction (Q1)
Paramétrer et lancer une simulation de projection financière pour la première fois, sans jargon.

## Objectif Business (Q2)
**Objectif :** O2 — Créer une transformation financière réelle
**Sous-objectif :** 2.1 — 50% des inscrits lancent ≥1 simulation dans les 3 premiers mois (métrique principale)

## Utilisateur & Situation (Q3)
**Persona :** L'Étudiante Ambitieuse (Priorité 2)
**Situation :** Amina, 21 ans, étudiante en gestion à Dakar. Samedi après-midi, sur son téléphone, curieuse de savoir si elle peut épargner pour voyager dans 2 ans avec un budget étudiant.

## Forces Motrices (Q4)
**Espoir :** Voir un chiffre concret — "si j'épargne X francs/mois, j'aurai Y dans 2 ans."
**Crainte :** Que les calculs soient trop complexes et qu'elle ne comprenne rien, comme dans les autres apps.

## Appareil & Point d'Entrée (Q5 + Q6)
**Appareil :** Mobile Android
**Entrée :** Voit le bouton "Simuler" sur son dashboard, appuie dessus par curiosité après une semaine d'utilisation.

## Meilleur Résultat (Q7)
**Succès utilisateur :** Simulation lancée, graphique de projection clair en 2 minutes — elle sait exactement combien épargner chaque mois.
**Succès business :** Métrique principale atteinte — inscription d'une utilisatrice dans les 50% qui lancent une simulation à 3 mois.

## Chemin le Plus Court (Q8)
1. **Simulateur** — Choisit son objectif (voyage), saisit montant cible et durée (2 ans)
2. **Résultat de simulation** — Voit le graphique de projection + montant mensuel recommandé ✓

## Connexions Trigger Map
- ✅ **Désir :** Se projeter dans 5 ans avec un plan chiffré [Score 13]
- ❌ **Crainte :** Sentiment d'exclusion face aux apps complexes [Score 15]
- **Objectif :** O2 / 2.1

## Étapes du Scénario
| Étape | Dossier | Objectif | Action de sortie |
|-------|---------|---------|-----------------|
| 03.1 | `03.1-simulateur/` | Paramétrer la simulation simplement | Lance la simulation |
| 03.2 | `03.2-resultat-simulation/` | Voir la projection et comprendre le plan | Succès ✓ |
