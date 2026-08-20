# 01 : Kofi Découvre et Configure son Tableau de Bord

**Projet :** App Finance UEMOA
**Créé :** 2026-04-04
**Méthode :** Whiteport Design Studio (WDS)

---

## Transaction (Q1)

**Ce que ce scénario couvre :**
Se créer un compte, configurer son profil financier, et voir son premier tableau de bord santé financière.

---

## Objectif Business (Q2)

**Objectif :** O1 — Construire une base d'abonnés actifs et rentable
**Sous-objectif :** 1.1 — 1 000 abonnés actifs dans les 12 mois suivant le lancement

---

## Utilisateur & Situation (Q3)

**Persona :** L'Actif en Progression (Priorité 1)
**Situation :** Kofi, 32 ans, chef de projet dans une entreprise de télécoms à Abidjan. Le soir chez lui, sur son téléphone, après avoir réalisé qu'il n'a aucune idée de combien il dépense réellement chaque mois. Un ami vient de lui envoyer un lien WhatsApp.

---

## Forces Motrices (Q4)

**Espoir :** Voir enfin clairement où va son argent et avoir un point de départ concret.

**Crainte :** Que l'app soit comme les autres — trop complexe, pas adaptée à sa réalité, et qu'il abandonne encore.

---

## Appareil & Point d'Entrée (Q5 + Q6)

**Appareil :** Mobile Android
**Entrée :** Son ami lui envoie le lien via WhatsApp — "j'ai trouvé une app qui marche vraiment pour nous". Il clique depuis WhatsApp et atterrit sur le splash screen.

---

## Meilleur Résultat (Q7)

**Succès utilisateur :**
Profil financier configuré, premier tableau de bord santé financière visible et personnalisé — en moins de 5 minutes.

**Succès business :**
Activation confirmée — onboarding complété, premier événement trackable vers conversion payante, base d'un utilisateur récurrent.

---

## Chemin le Plus Court (Q8)

1. **Splash / Welcome** — Proposition de valeur en 3 secondes, il appuie sur "C'est parti"
2. **Inscription** — Crée son compte (email ou Google en un tap)
3. **Onboarding E1** — Renseigne son profil (revenus approximatifs, situation familiale)
4. **Onboarding E2** — Renseigne sa situation financière actuelle (dettes en cours, épargne existante)
5. **Onboarding E3** — Choisit son premier objectif principal
6. **Accueil / Dashboard** — Voit son tableau de bord santé financière personnalisé ✓

---

## Connexions Trigger Map

**Persona :** L'Actif en Progression (Priorité 1)

**Forces adressées :**
- ✅ **Désir :** Voir clairement où va son argent chaque mois [Score 15]
- ❌ **Crainte :** Sentiment d'exclusion face aux apps complexes [Score 15]

**Objectif business :** O1 — Abonnés actifs / Objectif 1.1

---

## Étapes du Scénario

| Étape | Dossier | Objectif | Action de sortie |
|-------|---------|---------|-----------------|
| 01.1 | `01.1-splash-welcome/` | Capter l'attention, déclencher l'inscription | Tape "C'est parti" |
| 01.2 | `01.2-inscription/` | Créer le compte facilement | Soumet le formulaire |
| 01.3 | `01.3-onboarding-profil/` | Renseigner profil de base | Tape "Continuer" |
| 01.4 | `01.4-onboarding-situation/` | Déclarer dettes et épargne actuelles | Tape "Continuer" |
| 01.5 | `01.5-onboarding-objectif/` | Choisir son premier objectif | Tape "Voir mon tableau de bord" |
| 01.6 | `01.6-dashboard/` | Voir le tableau de bord personnalisé | Succès ✓ |
