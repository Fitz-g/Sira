---
stepsCompleted: ['step-01-validate-prerequisites', 'step-02-design-epics']
inputDocuments:
  - '.bmad-outpout/planning-artifacts/prd.md'
  - '.bmad-outpout/planning-artifacts/architecture.md'
---

# App Finance UEMOA - Epic Breakdown

## Overview

This document provides the complete epic and story breakdown for App Finance UEMOA, decomposing the requirements from the PRD and Architecture into implementable stories.

## Requirements Inventory

### Functional Requirements

**1. Gestion de Compte & Authentification**
- FR01: Un visiteur peut créer un compte avec email et mot de passe
- FR02: Un utilisateur peut se connecter avec ses identifiants
- FR03: Un utilisateur peut réinitialiser son mot de passe par email
- FR04: Un utilisateur peut activer le déverrouillage biométrique (Touch ID / Face ID)
- FR05: Le système déconnecte automatiquement un utilisateur après 15 min d'inactivité
- FR06: Un utilisateur peut modifier ses informations de profil (nom, photo, devise)
- FR07: Un utilisateur peut supprimer son compte et toutes ses données associées

**2. Onboarding & Configuration Initiale**
- FR08: Un nouvel utilisateur peut renseigner sa situation financière initiale (revenus, charges fixes)
- FR09: Un nouvel utilisateur peut définir un premier objectif d'épargne pendant l'onboarding
- FR10: Le système génère un tableau de bord initial personnalisé à partir des données d'onboarding
- FR11: Un utilisateur peut passer et compléter l'onboarding ultérieurement
- FR55: Un utilisateur peut compléter son profil financier progressivement après l'onboarding

**3. Suivi des Dépenses & Budget**
- FR12: Un utilisateur peut saisir une dépense avec montant, catégorie, date et note optionnelle
- FR13: Un utilisateur peut modifier ou supprimer une dépense existante
- FR14: Un utilisateur peut consulter la liste de ses dépenses filtrée par période ou catégorie
- FR15: Un utilisateur peut définir un budget mensuel par catégorie de dépenses
- FR16: Le système calcule et affiche l'écart entre dépenses réelles et budget défini
- FR17: Le système alerte l'utilisateur quand une catégorie de budget atteint 90% de son seuil
- FR18: Un utilisateur peut consulter son tableau de bord santé financière (solde, tendances, score)

**4. Simulation & Projection Financière**
- FR19: Un utilisateur peut configurer une simulation avec montant initial, taux de rendement, durée et apport périodique
- FR20: Le système calcule et affiche une projection financière avec courbe d'évolution et montant final
- FR21: Un utilisateur peut modifier les paramètres d'une simulation et voir le résultat recalculé instantanément (≤500ms)
- FR22: Le système compare la projection avec l'inflation UEMOA pour afficher le rendement réel
- FR23: Un utilisateur peut sauvegarder un scénario de simulation pour y revenir ultérieurement
- FR24: Un utilisateur non-inscrit peut accéder à 1 simulation complète sans compte (sans sauvegarde ni comparaison)
- FR25: Le système propose des taux de référence UEMOA (épargne, bons du Trésor, BRVM) comme valeurs par défaut
- FR57: Un utilisateur peut partager une capture visuelle de sa simulation ou projection

**5. Gestion des Dettes**
- FR26: Un utilisateur peut ajouter une dette avec nom, montant total, taux d'intérêt, mensualité et date d'échéance
- FR27: Un utilisateur peut modifier ou supprimer une dette existante
- FR28: Un utilisateur peut consulter la liste consolidée de ses dettes avec solde restant
- FR29: Le système génère un plan de remboursement automatique selon la méthode avalanche ou boule de neige
- FR30: Le système affiche une date estimée de libération totale des dettes
- FR31: Un utilisateur peut enregistrer un remboursement effectué et voir le solde mis à jour

**6. Objectifs d'Épargne**
- FR32: Un utilisateur peut créer un objectif d'épargne avec nom, montant cible et date d'échéance
- FR33: Un utilisateur peut enregistrer un versement vers un objectif
- FR34: Le système calcule et affiche la progression et le montant mensuel recommandé pour atteindre l'objectif
- FR35: Le système projette si l'objectif sera atteint à la date cible au rythme actuel
- FR36: Un utilisateur peut modifier ou archiver un objectif existant

**7. Abonnement & Paiement**
- FR37: Un utilisateur peut consulter la comparaison des plans Gratuit et Premium
- FR38: Un utilisateur peut souscrire au plan Premium via Wave ou Orange Money
- FR39: Le système active les fonctionnalités Premium après confirmation de paiement
- FR40: Un utilisateur peut basculer entre facturation mensuelle et annuelle
- FR41: Un utilisateur peut consulter l'état de son abonnement et sa date de renouvellement
- FR42: Un utilisateur peut annuler son abonnement Premium à tout moment

**8. Notifications & Communication**
- FR43: Un utilisateur peut activer ou désactiver les notifications par catégorie
- FR44: Le système envoie une notification quand un seuil de budget est atteint
- FR45: Le système envoie une notification de rappel avant une échéance de dette
- FR46: Le système envoie un résumé financier mensuel à l'utilisateur

**9. Expérience & Pédagogie**
- FR51: Le système affiche un contenu d'orientation pédagogique quand une section est vide
- FR52: Le système fournit des explications contextuelles sur les notions financières affichées
- FR53: Le système suggère une action corrective quand le score de santé financière se dégrade
- FR54: Le système n'affiche jamais de recommandations de produits ou services financiers tiers

**10. Fiabilité & Gestion des Erreurs**
- FR56: Le système informe l'utilisateur de l'indisponibilité d'un service externe avec un message clair et une action alternative

**11. Administration & Monitoring**
- FR47: Un administrateur peut consulter les métriques clés de la plateforme (inscriptions, conversions, rétention)
- FR48: Un administrateur peut gérer les abonnements (consultation, remboursement manuel)
- FR49: Le système génère des alertes automatiques en cas d'indisponibilité des APIs tierces
- FR50: Le système expose des taux de référence UEMOA configurables via fichier de configuration

### NonFunctional Requirements

**Performance**
- NFR-P1: Calcul simulation — résultat affiché ≤2s sur réseau 3G (débit ≥1 Mbps)
- NFR-P2: Chargement tableau de bord — données affichées ≤3s au démarrage sur réseau 3G
- NFR-P3: Recalcul simulation instantané — mise à jour paramètre ≤500ms (calcul local)
- NFR-P4: Taille de l'app — APK/IPA ≤30MB
- NFR-P5: Démarrage à froid — app prête ≤4s sur Android 8, 2GB RAM
- NFR-P6: Actions critiques (saisie dépense, création objectif) — ≤1s de feedback visuel

**Sécurité**
- NFR-S1: Chiffrement at-rest — AES-256 pour toutes les données financières
- NFR-S2: Chiffrement in-transit — TLS 1.3 obligatoire
- NFR-S3: Authentification — JWT + refresh tokens, session expirée après 15 min d'inactivité
- NFR-S4: Credentials tiers — aucun credential Wave/MoMo stocké (OAuth ou deep link uniquement)
- NFR-S5: Logs — zéro donnée financière dans les logs applicatifs
- NFR-S6: Isolation — toutes les queries filtrées par user_id vérifié côté serveur (RLS)
- NFR-S7: Biométrie — traitement local OS uniquement, jamais transmis

**Fiabilité**
- NFR-R1: Disponibilité — ≥99% uptime mensuel
- NFR-R2: Offline — app utilisable en lecture et saisie sans connexion
- NFR-R3: Perte de données — zéro perte lors d'une coupure réseau pendant une saisie
- NFR-R4: Crash rate — <0.5% des sessions Android, <0.3% iOS
- NFR-R5: Dégradation gracieuse — si API externe indisponible → features core non bloquées, message clair
- NFR-R6: Recovery — après crash, l'utilisateur retrouve son dernier état sans perte

**Scalabilité**
- NFR-SC1: Charge initiale — ≥1 000 utilisateurs actifs simultanés sans dégradation
- NFR-SC2: Croissance — extensible horizontalement sans refactoring majeur à 50 000 utilisateurs
- NFR-SC3: Données par compte — aucune dégradation jusqu'à 10 000 transactions
- NFR-SC4: Multi-user — schéma préparé dès le MVP, activation sans migration destructive

**Accessibilité Pratique**
- NFR-A1: Zones tactiles — éléments tactiles ≥44×44pt
- NFR-A2: Contraste — ratio ≥4.5:1 pour tout texte (WCAG AA)
- NFR-A3: Scaling texte — support jusqu'à 150% sans casse de layout
- NFR-A4: Réseau dégradé — UX fonctionnelle sur 2G/Edge

**Intégrations**
- NFR-I1: Wave / Orange Money — timeout confirmation ≤30s, état "en attente" avec retry au-delà
- NFR-I2: BRVM — délai J-1 acceptable, fraîcheur affichée ("données du JJ/MM/AAAA")
- NFR-I3: Webhooks — idempotence garantie (webhook dupliqué ≠ double activation Premium)
- NFR-I4: Découplage — toute intégration externe encapsulée derrière une interface interne

### Additional Requirements

**Starter Template (Architecture — impacte Epic 1, Story 1) :**
- Initialisation via `npx create-expo-app@latest FinanceUEMOA` (Expo SDK 55)
- New Architecture activée par défaut (React Native 0.83/0.84)
- Expo Router v4 intégré (navigation file-based)
- Configuration TypeScript strict dès l'init

**Infrastructure :**
- Backend Supabase (PostgreSQL) avec RLS (Row Level Security) activé
- Supabase Auth avec MMKV comme storage adapter pour les sessions JWT React Native
- MMKV (`react-native-mmkv`) pour stockage local chiffré des données financières sensibles
- TanStack Query pour cache serveur + file de mutations offline avec retry automatique
- Zustand pour état global (session user, abonnement, préférences UI)
- NativeWind + Tailwind CSS pour le style mobile
- Zod pour validation de toutes les données externes
- React Hook Form pour les formulaires

**Supabase Edge Functions :**
- `wave-webhook/` — réception + vérification signature + idempotence pour FR38-39
- `momo-webhook/` — idem pour Orange Money
- `brvm-sync/` — cron quotidien pour données BRVM (FR25, NFR-I2)

**CI/CD & Infrastructure :**
- EAS Build (Android + iOS en cloud, sans Mac local)
- EAS Submit (Google Play + App Store automatisé)
- GitHub Actions + EAS sur tag pour CI/CD
- Sentry v8.7.0 pour crash + performance + traces
- Expo Updates pour OTA sans validation store

**Schéma DB :**
- Tables : `profiles`, `transactions`, `budgets`, `debts`, `debt_payments`, `savings_goals`, `goal_contributions`, `simulations`, `subscriptions`, `uemoa_rates`
- Script `types:supabase` à ajouter dans `package.json` pour régénérer les types après migration

**Patterns obligatoires :**
- `snake_case` en DB, `camelCase` en TypeScript — sans exception
- Montants FCFA en entiers (jamais de float)
- Composants n'appellent jamais Supabase directement — toujours via `/services/`
- Services retournent toujours `{ data, error }`
- Disclaimer légal systématique sur toute simulation affichée
- Pas de `any` TypeScript — `unknown` si type incertain

**Feature spéciale FR24 :**
- Route `/app/simulator-preview.tsx` hors groupe `(tabs)/` — état local uniquement, redirection vers inscription après simulation

### UX Design Requirements

Aucun document UX Design distinct n'a été fourni pour ce projet. Les exigences UX sont intégrées directement dans le PRD (section "Ton de Voix & Principes UX") et dans l'Architecture (patterns `EmptyState`, `ErrorState`, `LoadingSpinner`).

Les éléments UX non-négociables documentés dans le PRD sont :
- UX-DR1: États vides pédagogiques — chaque section vide guide vers la prochaine action utile (`EmptyState` component défini dans l'architecture)
- UX-DR2: Tutoiement systématique et microcopy validé (exemples de tone of voice définis dans le PRD — à appliquer dans chaque story)
- UX-DR3: Disclaimers systématiques sur toutes les simulations ("indicatif — pas un conseil financier") — obligation légale
- UX-DR4: Zéro recommandation de produits ou services financiers tiers (FR54)
- UX-DR5: Onboarding progressif — l'utilisateur peut utiliser l'app avant d'avoir tout rempli (FR11)
- UX-DR6: Composants UI atom définis dans l'architecture : `Button`, `Input`, `Card`, `Badge`, `LoadingSpinner`, `EmptyState`, `ErrorState`, `Toast`, `Modal`, `ProgressBar`, `CurrencyInput`, `RateInput`

### FR Coverage Map

| FR | Épic | Description courte |
|----|------|--------------------|
| FR01 | Epic 1 | Inscription email/password |
| FR02 | Epic 1 | Connexion |
| FR03 | Epic 1 | Reset mot de passe |
| FR04 | Epic 1 | Biométrie optionnelle |
| FR05 | Epic 1 | Session timeout 15 min |
| FR06 | Epic 1 | Modification profil |
| FR07 | Epic 1 | Suppression compte |
| FR08 | Epic 1 | Situation financière initiale |
| FR09 | Epic 1 | Premier objectif onboarding |
| FR10 | Epic 1 | Dashboard initial personnalisé |
| FR11 | Epic 1 | Onboarding progressif (passable) |
| FR50 | Epic 1 | Taux UEMOA configurables (constants) |
| FR55 | Epic 1 | Profil financier progressif post-onboarding |
| FR12 | Epic 2 | Saisie dépense |
| FR13 | Epic 2 | Modification/suppression dépense |
| FR14 | Epic 2 | Liste dépenses filtrée |
| FR15 | Epic 2 | Budget mensuel par catégorie |
| FR16 | Epic 2 | Écart dépenses réelles / budget |
| FR17 | Epic 2 | Alerte 90% budget |
| FR18 | Epic 2 | Dashboard santé financière |
| FR51 | Epic 2 | États vides pédagogiques |
| FR52 | Epic 2 | Explications contextuelles notions financières |
| FR53 | Epic 2 | Suggestion corrective score dégradé |
| FR54 | Epic 2 | Zéro recommandation produits tiers |
| FR56 | Epic 2 | Message clair indisponibilité service externe |
| FR19 | Epic 3 | Configuration simulation |
| FR20 | Epic 3 | Projection avec courbe d'évolution |
| FR21 | Epic 3 | Recalcul instantané ≤500ms |
| FR22 | Epic 3 | Comparaison inflation UEMOA |
| FR23 | Epic 3 | Sauvegarde scénario (Premium) |
| FR24 | Epic 3 | Simulation sans inscription |
| FR25 | Epic 3 | Taux UEMOA par défaut |
| FR57 | Epic 3 | Partage capture simulation |
| FR26 | Epic 4 | Ajout dette |
| FR27 | Epic 4 | Modification/suppression dette |
| FR28 | Epic 4 | Liste consolidée dettes |
| FR29 | Epic 4 | Plan remboursement avalanche/snowball |
| FR30 | Epic 4 | Date de libération financière |
| FR31 | Epic 4 | Enregistrement remboursement |
| FR32 | Epic 5 | Création objectif d'épargne |
| FR33 | Epic 5 | Versement vers objectif |
| FR34 | Epic 5 | Progression + montant mensuel recommandé |
| FR35 | Epic 5 | Projection atteinte objectif |
| FR36 | Epic 5 | Modification/archivage objectif |
| FR43 | Epic 6 | Paramètres notifications par catégorie |
| FR44 | Epic 6 | Notification seuil budget |
| FR45 | Epic 6 | Rappel échéance dette |
| FR46 | Epic 6 | Résumé financier mensuel |
| FR37 | Epic 7 | Comparaison plans Gratuit/Premium |
| FR38 | Epic 7 | Souscription Wave/Orange Money |
| FR39 | Epic 7 | Activation Premium post-paiement |
| FR40 | Epic 7 | Basculement mensuel/annuel |
| FR41 | Epic 7 | État abonnement + renouvellement |
| FR42 | Epic 7 | Annulation abonnement |
| FR47 | Epic 8 | Dashboard métriques admin |
| FR48 | Epic 8 | Gestion abonnements admin |
| FR49 | Epic 8 | Alertes APIs tierces |

## Epic List

### Epic 1 : Fondations, Authentification & Onboarding
Les utilisateurs peuvent s'inscrire, s'authentifier et configurer leur profil financier initial pour accéder à l'application. Inclut l'initialisation complète du projet (starter Expo, Supabase, CI/CD, Sentry).
**FRs couverts :** FR01, FR02, FR03, FR04, FR05, FR06, FR07, FR08, FR09, FR10, FR11, FR50, FR55

### Epic 2 : Suivi des Dépenses, Budget & Santé Financière
Les utilisateurs peuvent saisir leurs dépenses, définir des budgets mensuels et visualiser leur tableau de bord de santé financière avec guidance pédagogique. Inclut les composants UI transversaux (EmptyState, ErrorState).
**FRs couverts :** FR12, FR13, FR14, FR15, FR16, FR17, FR18, FR51, FR52, FR53, FR54, FR56

### Epic 3 : Simulateur Financier UEMOA
Les utilisateurs peuvent simuler des projections d'investissement avec les paramètres UEMOA, modifier les scénarios en temps réel (≤500ms, 100% offline) et partager leurs résultats. Accessible sans inscription pour 1 simulation.
**FRs couverts :** FR19, FR20, FR21, FR22, FR23, FR24, FR25, FR57

### Epic 4 : Gestion des Dettes & Plan de Remboursement
Les utilisateurs peuvent documenter leurs dettes, générer un plan de remboursement automatisé (méthode avalanche ou boule de neige) et visualiser leur date de libération financière.
**FRs couverts :** FR26, FR27, FR28, FR29, FR30, FR31

### Epic 5 : Objectifs d'Épargne
Les utilisateurs peuvent créer des objectifs d'épargne, enregistrer des versements et suivre leur progression avec projection de l'atteinte à la date cible.
**FRs couverts :** FR32, FR33, FR34, FR35, FR36

### Epic 6 : Notifications & Engagement
Les utilisateurs reçoivent des notifications ciblées sur leur budget, leurs dettes et leurs objectifs pour rester engagés et maximiser leur conversion vers le Premium.
**FRs couverts :** FR43, FR44, FR45, FR46

### Epic 7 : Abonnement Premium & Paiements Mobile Money
Les utilisateurs peuvent souscrire au plan Premium via Wave ou Orange Money et accéder aux fonctionnalités avancées après confirmation de paiement.
**FRs couverts :** FR37, FR38, FR39, FR40, FR41, FR42

### Epic 8 : Administration & Monitoring Plateforme
L'administrateur peut consulter les métriques clés de la plateforme, gérer les abonnements et recevoir des alertes automatiques sur les APIs tierces.
**FRs couverts :** FR47, FR48, FR49
