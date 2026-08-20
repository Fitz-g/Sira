---
stepsCompleted: ['step-01-validate-prerequisites', 'step-02-design-epics', 'step-03-create-stories']
inputDocuments:
  - '.bmad-outpout/planning-artifacts/prd.md'
  - '.bmad-outpout/planning-artifacts/architecture.md'
  - '.bmad-outpout/C-UX-Scenarios/'
  - '.bmad-outpout/D-Design-System/'
storiesGeneratedAt: '2026-08-20'
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
| FR50 | Epic 3 | Taux UEMOA configurables (constants) |
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
**FRs couverts :** FR01, FR02, FR03, FR04, FR05, FR06, FR07, FR08, FR09, FR10, FR11, FR55

### Epic 2 : Suivi des Dépenses, Budget & Santé Financière
Les utilisateurs peuvent saisir leurs dépenses, définir des budgets mensuels et visualiser leur tableau de bord de santé financière avec guidance pédagogique. Inclut les composants UI transversaux (EmptyState, ErrorState).
**FRs couverts :** FR12, FR13, FR14, FR15, FR16, FR17, FR18, FR51, FR52, FR53, FR54, FR56

### Epic 3 : Simulateur Financier UEMOA
Les utilisateurs peuvent simuler des projections d'investissement avec les paramètres UEMOA, modifier les scénarios en temps réel (≤500ms, 100% offline) et partager leurs résultats. Accessible sans inscription pour 1 simulation.
**FRs couverts :** FR19, FR20, FR21, FR22, FR23, FR24, FR25, FR50, FR57

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

---

## Contraintes transverses

Ces exigences s'appliquent à **toutes** les stories du document et n'en constituent pas une à elles seules. Chaque story est réputée les respecter.

| Réf | Contrainte | Vérification |
|-----|-----------|--------------|
| UX-DR2 | Tutoiement systématique, microcopy validé dans le PRD | Relecture des libellés à chaque story |
| UX-DR6 | Réutiliser les composants du Design System, ne pas en réinventer | Revue de code |
| ARCH | Montants FCFA en `int`, jamais `double` | Compilation |
| ARCH | Aucun appel Supabase depuis un widget — passer par un provider | Revue de code |
| ARCH | Les services retournent un `Result<T>` | Revue de code |
| ARCH | Aucune donnée financière dans les logs, breadcrumbs Sentry compris | Revue de code |
| NFR-A1 | Zones tactiles ≥ 44 × 44 pt | Revue de code |

---

## Epic 1: Fondations, Authentification & Onboarding

**Objectif :** un visiteur peut créer son compte, s'authentifier et configurer son profil financier initial pour accéder à un tableau de bord personnalisé.

**FRs couverts :** FR01, FR02, FR03, FR04, FR05, FR06, FR07, FR08, FR09, FR10, FR11, FR55

### Story 1.1: Socle technique et écran d'accueil

As a visiteur qui découvre l'application,
I want comprendre en quelques secondes ce qu'elle m'apporte,
So that je décide de créer un compte sans avoir à lire une page entière.

**Acceptance Criteria:**

**Given** l'application est installée
**When** je la lance pour la première fois
**Then** l'écran d'accueil s'affiche en moins de 4 secondes sur Android 8 avec 2 Go de RAM (NFR-P5)
**And** il présente une illustration, une promesse en une ligne, un sous-titre et un bouton d'action

**Given** je suis sur l'écran d'accueil
**When** je touche « C'est parti »
**Then** je suis conduit vers la création de compte

**Given** je suis sur l'écran d'accueil
**When** je touche « J'ai déjà un compte »
**Then** je suis conduit vers la connexion

**Given** le projet est initialisé
**When** un développeur consulte le code
**Then** les tokens du Design System (couleurs, typographie, espacement, animation) sont centralisés et utilisés par le thème
**And** aucune valeur visuelle n'est écrite en dur dans un écran

### Story 1.2: Création de compte par email

As a visiteur convaincu,
I want créer mon compte en moins de 60 secondes,
So that je commence à utiliser l'application sans friction.

**Acceptance Criteria:**

**Given** je suis sur l'écran d'inscription
**When** je le consulte
**Then** trois champs seulement me sont demandés : nom complet, email, mot de passe
**And** aucun numéro de téléphone n'est exigé

**Given** j'ai rempli les trois champs avec des valeurs valides
**When** je touche « Créer mon compte »
**Then** mon compte est créé et je suis conduit vers la première étape d'onboarding

**Given** un des champs est vide ou invalide
**When** je touche le bouton de validation
**Then** le bouton reste inactif et le champ fautif porte son message d'erreur
**And** le message est en langage courant, jamais une erreur technique

**Given** un compte existe déjà avec cet email
**When** je soumets le formulaire
**Then** un message me l'indique sous le champ email
**And** le formulaire reste rempli, je n'ai pas à tout resaisir

**Given** le mot de passe fait moins de 8 caractères
**When** je quitte le champ
**Then** un message m'indique la longueur minimale attendue

### Story 1.3: Connexion, session et déconnexion automatique

As a utilisateur déjà inscrit,
I want retrouver mon compte et être protégé si je laisse mon téléphone,
So that mes données financières restent privées.

**Acceptance Criteria:**

**Given** j'ai un compte
**When** je saisis mes identifiants corrects et je valide
**Then** je suis connecté et conduit vers mon tableau de bord

**Given** mes identifiants sont incorrects
**When** je valide
**Then** un message générique m'indique l'échec sans préciser si c'est l'email ou le mot de passe qui est faux

**Given** je suis connecté
**When** je ferme puis rouvre l'application
**Then** ma session est toujours active, je n'ai pas à me reconnecter

**Given** je suis connecté et inactif
**When** 15 minutes s'écoulent sans interaction (NFR-S3)
**Then** ma session expire et l'écran de connexion s'affiche

**Given** je suis connecté
**When** je me déconnecte volontairement
**Then** mon jeton est effacé du stockage sécurisé de l'appareil

### Story 1.4: Réinitialisation du mot de passe

As a utilisateur qui a oublié son mot de passe,
I want le réinitialiser par email,
So that je récupère l'accès à mes données sans perdre mon compte.

**Acceptance Criteria:**

**Given** je suis sur l'écran de connexion
**When** je touche « Mot de passe oublié »
**Then** un écran me demande mon adresse email

**Given** je saisis une adresse associée à un compte
**When** je valide
**Then** un email de réinitialisation est envoyé
**And** un message me confirme l'envoi

**Given** je saisis une adresse inconnue
**When** je valide
**Then** le même message de confirmation s'affiche, sans révéler qu'aucun compte n'existe

**Given** j'ouvre le lien reçu
**When** je saisis un nouveau mot de passe valide
**Then** il remplace l'ancien et je peux me connecter avec

### Story 1.5: Onboarding — profil de base

As a nouvel inscrit,
I want répondre à deux questions simples sur ma situation,
So that mon tableau de bord me corresponde dès le premier affichage.

**Acceptance Criteria:**

**Given** je viens de créer mon compte
**When** la première étape s'affiche
**Then** une barre de progression m'indique « Étape 1 sur 3 »
**And** un sous-titre m'assure que ces informations restent privées

**Given** on me demande mes revenus
**When** je consulte les choix
**Then** ce sont des fourchettes, jamais un champ de montant exact

**Given** je consulte la liste des situations familiales
**When** je la parcours
**Then** « Chef de famille élargie » y figure, aux côtés des situations classiques

**Given** je n'ai répondu qu'à une seule des deux questions
**When** je regarde le bouton de validation
**Then** il est inactif

**Given** j'ai répondu aux deux questions
**When** je touche « Continuer »
**Then** mes réponses sont conservées et l'étape 2 s'affiche

**Given** un libellé est plus long que la largeur disponible
**When** l'écran s'affiche
**Then** le libellé se replie sur deux lignes plutôt que d'être tronqué

### Story 1.6: Onboarding — situation financière

As a nouvel inscrit,
I want déclarer mes dettes et mon épargne sans me sentir jugé,
So that le plan qu'on me proposera parte de ma situation réelle.

**Acceptance Criteria:**

**Given** l'étape 2 s'affiche
**When** je la lis
**Then** le sous-titre indique explicitement l'absence de jugement

**Given** l'interrupteur « J'ai des dettes en cours » est inactif
**When** je regarde l'écran
**Then** aucun champ de montant n'est visible

**Given** j'active l'interrupteur
**When** l'animation se termine
**Then** le champ de montant apparaît sous l'interrupteur

**Given** j'ai saisi un montant puis désactivé l'interrupteur
**When** je consulte les données enregistrées
**Then** le montant est remis à zéro et n'apparaît pas dans mon profil

**Given** j'active un interrupteur sans renseigner le montant correspondant
**When** je regarde le bouton de validation
**Then** il est inactif

**Given** je n'ai activé aucun interrupteur
**When** je regarde le bouton de validation
**Then** il est actif — ne rien déclarer est une réponse valable

**Given** je ne souhaite pas répondre
**When** je touche « Passer cette étape »
**Then** je passe à l'étape 3 sans blocage

### Story 1.7: Onboarding — premier objectif

As a nouvel inscrit,
I want indiquer ce que je cherche à accomplir,
So that l'application oriente ses conseils vers ce qui compte pour moi.

**Acceptance Criteria:**

**Given** l'étape 3 s'affiche
**When** je la consulte
**Then** la barre de progression est pleine et son libellé annonce la dernière étape

**Given** cinq objectifs me sont proposés
**When** je les parcours
**Then** chacun porte un pictogramme et un libellé court
**And** la cinquième carte occupe toute la largeur, sans laisser de case vide

**Given** je sélectionne un objectif puis un autre
**When** je regarde la grille
**Then** un seul objectif est actif à la fois

**Given** aucun objectif n'est sélectionné
**When** je regarde le bouton de validation
**Then** il est inactif

**Given** j'ai choisi mon objectif
**When** je touche « Voir mon tableau de bord »
**Then** mon tableau de bord s'affiche et je ne peux pas revenir en arrière sur l'onboarding

### Story 1.8: Persistance du profil et onboarding reprenable

As a utilisateur pressé,
I want pouvoir remettre à plus tard ce que je n'ai pas rempli,
So that je ne sois jamais bloqué à l'entrée de l'application.

**Acceptance Criteria:**

**Given** j'ai terminé les trois étapes
**When** l'onboarding s'achève
**Then** mon profil est enregistré localement
**And** il survit à la fermeture et à la réouverture de l'application

**Given** j'ai passé l'étape 2
**When** je consulte mon tableau de bord
**Then** une invitation discrète me propose de compléter ma situation financière (UX-DR5)

**Given** j'accepte cette invitation
**When** je la touche
**Then** l'étape correspondante s'ouvre, préremplie de ce que j'avais déjà saisi

**Given** j'interromps l'onboarding en cours de route
**When** je relance l'application
**Then** je reprends à l'étape où je m'étais arrêté, sans perdre mes réponses précédentes

### Story 1.9: Tableau de bord initial personnalisé

As a utilisateur qui vient de terminer l'onboarding,
I want voir immédiatement une vue qui me ressemble,
So that je constate que l'application a compris ma situation.

**Acceptance Criteria:**

**Given** je viens de terminer l'onboarding
**When** mon tableau de bord s'affiche
**Then** il me salue par mon prénom
**And** il affiche un score de santé financière, un résumé du mois, trois actions rapides et un conseil contextuel

**Given** le tableau de bord se charge sur un réseau 3G
**When** je mesure le délai
**Then** les données apparaissent en moins de 3 secondes (NFR-P2)

**Given** les trois actions rapides sont affichées
**When** je les consulte
**Then** elles mènent respectivement à la saisie d'une dépense, aux objectifs et au simulateur

**Given** je n'ai encore saisi aucune dépense
**When** je consulte le résumé du mois
**Then** un message encourageant remplace les chiffres, avec une action pour démarrer (FR51)

**Given** les données sont en cours de chargement
**When** l'écran s'affiche
**Then** des squelettes occupent la place des cartes, jamais un écran blanc

### Story 1.10: Consultation et modification du profil

As a utilisateur,
I want corriger mes informations quand ma situation change,
So that les conseils restent adaptés à ma réalité.

**Acceptance Criteria:**

**Given** je suis connecté
**When** j'ouvre mon profil
**Then** j'y vois mon nom, mon email, ma photo et ma devise

**Given** je modifie mon nom
**When** j'enregistre
**Then** la modification est visible immédiatement sur mon tableau de bord
**And** une confirmation brève apparaît

**Given** je modifie une fourchette de revenus ou ma situation familiale
**When** j'enregistre
**Then** le score de santé financière est recalculé

**Given** l'enregistrement échoue
**When** l'erreur survient
**Then** un message clair me le signale et mes saisies sont conservées

### Story 1.11: Suppression du compte et des données

As a utilisateur qui souhaite partir,
I want supprimer mon compte et tout ce qui s'y rattache,
So that je garde le contrôle de mes données financières.

**Acceptance Criteria:**

**Given** je suis dans mes paramètres
**When** je demande la suppression de mon compte
**Then** un avertissement m'explique que l'opération est définitive
**And** une confirmation explicite m'est demandée

**Given** je confirme
**When** la suppression s'exécute
**Then** mes dépenses, budgets, dettes, objectifs et simulations sont supprimés
**And** les données locales de l'appareil sont effacées
**And** je suis renvoyé vers l'écran d'accueil

**Given** j'annule à l'étape de confirmation
**When** je reviens en arrière
**Then** rien n'a été supprimé

### Story 1.12: Déverrouillage biométrique

As a utilisateur soucieux de sa confidentialité,
I want ouvrir l'application par empreinte ou reconnaissance faciale,
So that mes données restent protégées sans saisir un mot de passe à chaque fois.

**Acceptance Criteria:**

**Given** mon appareil dispose d'un capteur biométrique
**When** j'ouvre les paramètres de sécurité
**Then** l'option de déverrouillage biométrique m'est proposée

**Given** mon appareil ne dispose d'aucun capteur
**When** j'ouvre les paramètres de sécurité
**Then** l'option n'est pas affichée, sans message d'erreur

**Given** j'ai activé la biométrie
**When** je rouvre l'application après expiration de session
**Then** le capteur m'est proposé avant le formulaire de mot de passe

**Given** la vérification biométrique échoue trois fois
**When** je réessaie
**Then** le formulaire de mot de passe prend le relais

**Given** la biométrie est activée
**When** j'inspecte ce qui est transmis au serveur
**Then** aucune donnée biométrique ne quitte l'appareil (NFR-S7)

---

## Epic 2: Suivi des Dépenses, Budget & Santé Financière

**Objectif :** l'utilisateur saisit ses dépenses, définit des budgets et lit sa santé financière, guidé plutôt que laissé seul devant des chiffres.

**FRs couverts :** FR12, FR13, FR14, FR15, FR16, FR17, FR18, FR51, FR52, FR53, FR54, FR56

### Story 2.1: Saisie d'une dépense

As a utilisateur pressé, debout dans la rue,
I want noter une dépense en moins de 15 secondes,
So that l'habitude tienne au-delà de trois jours.

**Acceptance Criteria:**

**Given** j'ouvre la saisie d'une dépense
**When** l'écran s'affiche
**Then** le clavier numérique est déjà ouvert et le curseur dans le champ du montant

**Given** je saisis un montant
**When** je tape les chiffres
**Then** le montant s'affiche formaté avec ses séparateurs de milliers, suivi de FCFA

**Given** huit catégories me sont proposées
**When** je les parcours
**Then** elles défilent horizontalement, chacune avec son pictogramme

**Given** je n'ai pas choisi de catégorie
**When** j'enregistre
**Then** la dépense est classée dans « Autre »

**Given** le montant est à zéro
**When** je regarde le bouton d'enregistrement
**Then** il est inactif

**Given** j'ai saisi un montant valide
**When** j'enregistre
**Then** la dépense est stockée localement, même sans connexion (NFR-R2)
**And** un retour visuel me le confirme en moins d'une seconde (NFR-P6)

### Story 2.2: Liste des dépenses filtrable

As a utilisateur,
I want relire mes dépenses par période et par catégorie,
So that je comprenne où part mon argent.

**Acceptance Criteria:**

**Given** j'ouvre la liste de mes dépenses
**When** elle s'affiche
**Then** les dépenses du mois en cours apparaissent, regroupées par jour
**And** le total du mois est affiché en tête

**Given** je consulte le sélecteur de mois
**When** je touche le chevron précédent ou suivant
**Then** la liste et le total se mettent à jour pour ce mois

**Given** je filtre par catégorie
**When** je choisis une catégorie
**Then** seules les dépenses de cette catégorie restent affichées, et le total reflète le filtre

**Given** aucune dépense n'existe pour la période choisie
**When** la liste s'affiche
**Then** un message encourageant remplace la liste, avec une action pour saisir la première (FR51)

**Given** la liste contient 10 000 dépenses
**When** je la fais défiler
**Then** le défilement reste fluide (NFR-SC3)

### Story 2.3: Modification et suppression d'une dépense

As a utilisateur qui s'est trompé,
I want corriger ou effacer une dépense,
So that mes chiffres restent justes.

**Acceptance Criteria:**

**Given** je touche une dépense de la liste
**When** l'écran s'ouvre
**Then** ses champs sont préremplis et modifiables

**Given** je modifie le montant et j'enregistre
**When** je reviens à la liste
**Then** la ligne et le total du mois reflètent la modification

**Given** je fais glisser une ligne vers la gauche
**When** le geste se termine
**Then** un bouton de suppression rouge apparaît

**Given** je touche ce bouton de suppression
**When** la boîte de dialogue s'affiche
**Then** une confirmation m'est demandée avant tout effacement

**Given** je confirme la suppression
**When** la liste se rafraîchit
**Then** la dépense a disparu, le total est recalculé, et le budget de sa catégorie aussi

### Story 2.4: Définition d'un budget mensuel par catégorie

As a utilisateur qui veut se fixer des limites,
I want attribuer un montant mensuel à chaque catégorie,
So that je sache quand je dépasse.

**Acceptance Criteria:**

**Given** j'ouvre l'écran du budget
**When** il s'affiche
**Then** chaque catégorie de dépense y figure avec son enveloppe, vide ou renseignée

**Given** je saisis un montant pour une catégorie
**When** j'enregistre
**Then** ce montant devient l'enveloppe du mois en cours

**Given** j'ai défini des enveloppes le mois précédent
**When** un nouveau mois commence
**Then** les mêmes enveloppes sont reconduites par défaut

**Given** je laisse une catégorie sans enveloppe
**When** je consulte le budget
**Then** cette catégorie n'affiche pas de barre de progression, sans être signalée comme une erreur

### Story 2.5: Écart entre dépenses réelles et budget

As a utilisateur,
I want voir où j'en suis par rapport à ce que je m'étais fixé,
So that j'ajuste avant la fin du mois.

**Acceptance Criteria:**

**Given** j'ai défini des enveloppes et saisi des dépenses
**When** j'ouvre le budget
**Then** chaque catégorie affiche une barre de progression : dépensé sur enveloppe

**Given** une catégorie est consommée à moins de 80 %
**When** je regarde sa barre
**Then** elle est verte

**Given** une catégorie est consommée entre 80 et 100 %
**When** je regarde sa barre
**Then** elle est orange

**Given** une catégorie dépasse son enveloppe
**When** je regarde sa barre
**Then** elle est rouge et le dépassement est chiffré

**Given** je saisis une nouvelle dépense
**When** je reviens au budget
**Then** la barre de sa catégorie est déjà à jour

### Story 2.6: Alerte de seuil budgétaire

As a utilisateur,
I want être prévenu avant de dépasser,
So that je puisse encore corriger le tir.

**Acceptance Criteria:**

**Given** une catégorie atteint 90 % de son enveloppe
**When** j'enregistre la dépense qui franchit ce seuil
**Then** une alerte apparaît dans l'application, nommant la catégorie et le reste disponible

**Given** l'alerte a déjà été montrée pour cette catégorie ce mois-ci
**When** je saisis une dépense supplémentaire dans la même catégorie
**Then** elle n'est pas répétée à chaque saisie

**Given** un nouveau mois commence
**When** les enveloppes se réinitialisent
**Then** les alertes redeviennent possibles

**Given** le ton de l'alerte
**When** je la lis
**Then** elle constate sans culpabiliser

### Story 2.7: Score de santé financière

As a utilisateur non-expert,
I want un indicateur unique de ma situation,
So that je sache si je vais dans le bon sens sans analyser dix chiffres.

**Acceptance Criteria:**

**Given** mon profil et mes données sont renseignés
**When** j'ouvre mon tableau de bord
**Then** un score sur 100 s'affiche, accompagné d'un libellé en langage courant

**Given** la formule de calcul
**When** un développeur la consulte
**Then** elle est documentée, déterministe et testée unitairement
**And** ses composantes et leur pondération sont explicites

**Given** mon score est inférieur ou égal à 40
**When** je le consulte
**Then** l'arc est rouge et le libellé indique qu'une attention est requise

**Given** mon score est compris entre 41 et 70
**When** je le consulte
**Then** l'arc est orange

**Given** mon score dépasse 70
**When** je le consulte
**Then** l'arc est vert

**Given** je viens de terminer l'onboarding sans aucune dépense saisie
**When** mon score s'affiche
**Then** il repose sur les seules données d'onboarding
**And** une mention indique qu'il s'affinera avec l'usage

### Story 2.8: États vides pédagogiques

As a utilisateur qui découvre une section,
I want savoir quoi faire quand il n'y a rien à afficher,
So that je ne reste pas devant un écran vide.

**Acceptance Criteria:**

**Given** une section ne contient aucune donnée
**When** je l'ouvre
**Then** une illustration, un titre encourageant, une explication et une action m'accueillent (UX-DR1)

**Given** je lis le titre d'un état vide
**When** je le compare aux formulations interdites
**Then** il célèbre le point de départ plutôt que de constater une absence

**Given** je touche l'action proposée
**When** l'écran change
**Then** je suis conduit exactement à ce qui remplira cette section

**Given** les sections dépenses, budget, dettes, objectifs et investissements
**When** chacune est vide
**Then** chacune dispose de son propre état vide, avec un texte qui lui est propre

### Story 2.9: Explications contextuelles des notions financières

As a utilisateur qui n'est pas expert,
I want comprendre les termes que l'application emploie,
So that je ne subisse pas un vocabulaire qui m'exclut.

**Acceptance Criteria:**

**Given** une notion financière est affichée (taux, rendement, inflation, amortissement)
**When** je touche son pictogramme d'aide
**Then** une explication courte, en langage courant, s'affiche

**Given** je lis une explication
**When** je la compare au ton attendu
**Then** elle explique sans condescendance et sans jargon non défini

**Given** un chiffre repose sur une hypothèse
**When** il s'affiche
**Then** l'hypothèse est visible à côté du chiffre, pas dissimulée

### Story 2.10: Suggestion corrective quand le score se dégrade

As a utilisateur dont la situation se détériore,
I want qu'on me propose une action concrète,
So that je sache par où commencer plutôt que de me décourager.

**Acceptance Criteria:**

**Given** mon score a baissé par rapport au mois précédent
**When** j'ouvre mon tableau de bord
**Then** une suggestion s'affiche, fondée sur la composante qui a le plus reculé

**Given** je lis cette suggestion
**When** je la compare aux données de mon profil
**Then** elle est spécifique à ma situation, jamais un conseil générique

**Given** une suggestion m'est faite
**When** je la touche
**Then** elle mène à l'écran qui permet d'agir dessus

**Given** mon score est stable ou en hausse
**When** j'ouvre mon tableau de bord
**Then** aucune suggestion corrective n'apparaît

### Story 2.11: Neutralité — aucune recommandation de produit tiers

As a utilisateur,
I want être certain qu'on ne me vend rien,
So that je puisse faire confiance aux conseils reçus.

**Acceptance Criteria:**

**Given** je parcours l'application
**When** je lis les conseils, insights et suggestions
**Then** aucun produit ou service financier tiers n'est nommé ni recommandé (FR54, UX-DR4)

**Given** un instrument financier est mentionné dans le simulateur
**When** je le consulte
**Then** il est présenté comme une catégorie de placement, jamais comme l'offre d'un établissement

**Given** la base de code
**When** on l'inspecte
**Then** aucune régie publicitaire ni lien d'affiliation n'y est intégré

### Story 2.12: Dégradation gracieuse en cas d'indisponibilité externe

As a utilisateur,
I want que l'application reste utilisable quand un service tiers tombe,
So that je ne sois pas bloqué pour une panne qui n'est pas la mienne.

**Acceptance Criteria:**

**Given** un service externe est indisponible
**When** j'ouvre l'écran qui en dépend
**Then** un message clair m'explique la situation et propose une alternative (FR56)
**And** aucun détail technique ne m'est exposé

**Given** un service externe est indisponible
**When** j'utilise les autres fonctions de l'application
**Then** aucune n'est bloquée (NFR-R5)

**Given** je suis hors connexion
**When** je saisis une dépense
**Then** elle est enregistrée localement et mise en file d'attente
**And** elle part vers le serveur dès le retour du réseau, sans aucune perte (NFR-R3)

**Given** une erreur technique survient
**When** elle est traitée
**Then** elle est transmise à Sentry sans aucune donnée financière
**And** l'utilisateur ne voit qu'un message en langage courant

---

## Epic 3: Simulateur Financier UEMOA

**Objectif :** l'utilisateur projette son avenir financier avec des paramètres ancrés dans la réalité UEMOA, modifie ses hypothèses en temps réel et hors connexion, et partage son résultat.

**FRs couverts :** FR19, FR20, FR21, FR22, FR23, FR24, FR25, FR50, FR57

### Story 3.1: Taux de référence UEMOA configurables

As a utilisateur,
I want que les taux proposés reflètent les instruments réellement disponibles chez moi,
So that mes projections aient un sens dans mon contexte.

**Acceptance Criteria:**

**Given** j'ouvre le simulateur
**When** je choisis un type de placement
**Then** un taux de référence UEMOA lui est associé par défaut (FR25)

**Given** les taux sont définis
**When** un développeur les consulte
**Then** ils se trouvent dans un fichier de configuration dédié, jamais écrits en dur dans un calcul (FR50)

**Given** les instruments proposés
**When** je les parcours
**Then** ils couvrent l'épargne classique, les bons du Trésor, les obligations d'État et la BRVM

**Given** un taux est affiché à l'utilisateur
**When** je le lis
**Then** sa source et sa date de référence sont accessibles

**Given** un taux doit être corrigé
**When** on modifie le fichier de configuration
**Then** aucune autre partie du code n'a besoin d'être touchée

### Story 3.2: Moteur de projection d'épargne

As a utilisateur,
I want un calcul juste et instantané, même sans réseau,
So that je puisse explorer mes options n'importe où.

**Acceptance Criteria:**

**Given** un montant cible, une durée, un taux et un apport initial
**When** le moteur calcule
**Then** il retourne le versement mensuel nécessaire, le capital atteint, le total versé, les intérêts et la courbe mois par mois

**Given** le versement mensuel calculé
**When** on le réinjecte dans la projection
**Then** le capital atteint est supérieur ou égal au montant cible

**Given** un taux nul
**When** le moteur calcule
**Then** le versement mensuel vaut simplement la cible restante divisée par la durée

**Given** l'apport initial couvre déjà la cible
**When** le moteur calcule
**Then** le versement mensuel retourné est zéro

**Given** le moteur
**When** un développeur l'inspecte
**Then** il ne contient aucun appel réseau, aucun accès à l'état global, aucune navigation
**And** il est couvert par des tests unitaires portant sur des cas UEMOA réels

**Given** la courbe affichée et le montant annoncé
**When** on les compare
**Then** ils proviennent du même calcul, aucun arrondi ne les fait diverger

### Story 3.3: Configuration d'une simulation

As a utilisatrice qui craint le jargon financier,
I want paramétrer ma projection avec des questions en langage courant,
So that je n'aie pas besoin d'être experte pour m'en servir.

**Acceptance Criteria:**

**Given** j'ouvre le simulateur
**When** l'écran s'affiche
**Then** on me demande ce que je veux faire, combien, et dans combien de temps — rien d'autre

**Given** je consulte les types d'objectif
**When** je les parcours
**Then** ils sont formulés en langage courant, sans terme technique

**Given** je manipule le curseur de durée
**When** je le déplace
**Then** l'unité bascule seule entre mois et années selon la valeur

**Given** le montant est vide ou nul
**When** je regarde le bouton de validation
**Then** il est inactif

**Given** j'ai renseigné un montant et une durée
**When** je regarde l'écran
**Then** un aperçu m'annonce le versement mensuel approximatif
**And** l'hypothèse de rendement retenue est affichée juste en dessous

### Story 3.4: Projection avec courbe d'évolution

As a utilisatrice,
I want voir ma trajectoire d'un coup d'œil,
So that je comprenne si mon projet est à ma portée.

**Acceptance Criteria:**

**Given** j'ai lancé ma simulation
**When** le résultat s'affiche
**Then** le versement mensuel apparaît en premier, avant tout autre chiffre

**Given** le résultat s'affiche
**When** je regarde la courbe
**Then** elle montre l'épargne cumulée mois par mois, avec un repère au point d'arrivée

**Given** la courbe est affichée
**When** j'en lis les axes
**Then** trois repères par axe suffisent à la lire, sans surcharge

**Given** le résultat s'affiche
**When** je le parcours
**Then** un récapitulatif détaille l'objectif, la durée, le total versé et les intérêts gagnés

**Given** un résultat de simulation est affiché
**When** je le lis jusqu'en bas
**Then** une mention indique qu'il s'agit d'une estimation et non d'un conseil financier (UX-DR3)

**Given** le calcul est en cours
**When** l'écran s'affiche
**Then** des squelettes occupent la place du contenu, jamais un écran blanc

### Story 3.5: Recalcul instantané des paramètres

As a utilisatrice qui explore,
I want voir l'effet de chaque changement immédiatement,
So that je puisse essayer dix combinaisons en deux minutes.

**Acceptance Criteria:**

**Given** je modifie le montant cible
**When** je relâche la saisie
**Then** l'aperçu se met à jour en moins de 500 millisecondes (NFR-P3)

**Given** je déplace le curseur de durée
**When** je le relâche
**Then** le versement mensuel est recalculé sans rechargement d'écran

**Given** je suis hors connexion
**When** je modifie un paramètre
**Then** le recalcul fonctionne à l'identique

**Given** j'allonge la durée sans changer la cible
**When** je lis le nouveau versement
**Then** il est inférieur au précédent

### Story 3.6: Comparaison avec l'inflation UEMOA

As a utilisateur,
I want savoir ce que mon capital vaudra réellement,
So that je ne me réjouisse pas d'un gain que l'inflation aura absorbé.

**Acceptance Criteria:**

**Given** une projection est affichée
**When** je consulte le détail
**Then** le capital final apparaît aussi exprimé en pouvoir d'achat d'aujourd'hui (FR22)

**Given** le rendement réel est affiché
**When** je le compare au rendement nominal
**Then** une phrase explique en langage courant ce que l'écart signifie

**Given** le taux d'inflation utilisé
**When** je cherche d'où il vient
**Then** il provient du fichier de configuration des taux UEMOA, et sa valeur est visible

**Given** un rendement inférieur à l'inflation
**When** la projection s'affiche
**Then** la perte de pouvoir d'achat est signalée explicitement

### Story 3.7: Sauvegarde d'un scénario

As a utilisateur qui hésite entre plusieurs plans,
I want conserver mes simulations,
So that je puisse y revenir et les comparer.

**Acceptance Criteria:**

**Given** une projection est affichée et je suis abonné Premium
**When** je choisis de l'enregistrer
**Then** elle est sauvegardée avec ses paramètres et son nom

**Given** je suis en formule gratuite
**When** je tente d'enregistrer un scénario
**Then** l'action est présentée comme une fonction Premium, sans blocage brutal
**And** la comparaison des formules m'est accessible en un geste

**Given** j'ai des scénarios enregistrés
**When** j'ouvre le simulateur
**Then** je peux les rouvrir avec leurs paramètres intacts

**Given** un scénario enregistré
**When** je le supprime
**Then** une confirmation m'est demandée avant l'effacement

### Story 3.8: Simulation sans compte

As a visiteur qui n'a pas encore créé de compte,
I want essayer une projection complète,
So that je juge sur pièce avant de m'engager.

**Acceptance Criteria:**

**Given** je n'ai pas de compte
**When** j'accède au simulateur depuis le point d'entrée prévu
**Then** je peux paramétrer et lancer une projection complète (FR24)

**Given** j'ai obtenu mon résultat sans compte
**When** je consulte les actions disponibles
**Then** la sauvegarde et la comparaison de scénarios ne me sont pas proposées

**Given** j'ai vu mon résultat
**When** je souhaite aller plus loin
**Then** la création de compte m'est proposée au moment où la valeur vient d'être démontrée

**Given** j'ai déjà utilisé ma simulation découverte
**When** j'en relance une
**Then** le comportement retenu par la décision DEC-01 s'applique

**Given** je quitte l'application sans créer de compte
**When** je reviens
**Then** aucune donnée personnelle n'a été conservée

### Story 3.9: Partage d'une capture de simulation

As a utilisateur convaincu par sa projection,
I want la montrer à un proche,
So that l'application se fasse connaître par ceux qui l'utilisent.

**Acceptance Criteria:**

**Given** une projection est affichée
**When** je touche le partage
**Then** une image reprenant le chiffre clé, la courbe et les paramètres est générée

**Given** l'image générée
**When** je la regarde
**Then** elle porte la mention légale et l'identité de l'application

**Given** l'image est générée
**When** le partage s'ouvre
**Then** les applications installées sur mon téléphone me sont proposées

**Given** l'image est partagée
**When** on l'inspecte
**Then** elle ne contient aucune donnée personnelle autre que les paramètres de la simulation

---

## Epic 4: Gestion des Dettes & Plan de Remboursement

**Objectif :** l'utilisateur cartographie ses dettes, obtient un plan de remboursement chiffré et voit sa date de libération.

**FRs couverts :** FR26, FR27, FR28, FR29, FR30, FR31

### Story 4.1: Ajout d'une dette

As a utilisateur endetté,
I want déclarer une dette sans avoir à tout connaître,
So that je commence à y voir clair même avec des informations partielles.

**Acceptance Criteria:**

**Given** j'ouvre l'ajout d'une dette
**When** l'écran s'affiche
**Then** le créancier, le montant total et la mensualité me sont demandés
**And** le taux d'intérêt et la date de début sont marqués comme facultatifs

**Given** je remplis les champs obligatoires
**When** j'enregistre
**Then** la dette est ajoutée et une confirmation brève apparaît

**Given** je laisse le taux d'intérêt vide
**When** j'enregistre
**Then** la dette est acceptée, et les calculs qui en dépendent le signalent

**Given** un champ obligatoire est vide
**When** je regarde le bouton d'enregistrement
**Then** il est inactif

**Given** la mensualité dépasse le montant total
**When** j'enregistre
**Then** un message m'invite à vérifier les valeurs saisies

### Story 4.2: Liste consolidée des dettes

As a utilisateur qui appréhende de faire face,
I want voir toutes mes dettes au même endroit,
So that je mesure la situation sans me sentir jugé.

**Acceptance Criteria:**

**Given** j'ai déclaré des dettes
**When** j'ouvre la liste
**Then** le total restant dû s'affiche en tête, avec le nombre de créanciers

**Given** le total est affiché
**When** je lis le message qui l'accompagne
**Then** il est neutre et encourageant, jamais culpabilisant

**Given** chaque dette est listée
**When** je consulte une ligne
**Then** elle indique le créancier, le solde restant, la mensualité et une barre de progression

**Given** je n'ai déclaré aucune dette
**When** j'ouvre la liste
**Then** un état vide m'invite à cartographier la première

**Given** j'ai au moins une dette
**When** je consulte l'écran
**Then** l'accès au plan de remboursement m'est proposé

### Story 4.3: Modification et suppression d'une dette

As a utilisateur,
I want corriger une dette mal saisie ou retirer une dette soldée,
So that ma cartographie reste fidèle.

**Acceptance Criteria:**

**Given** je touche une dette
**When** l'écran de détail s'ouvre
**Then** ses champs sont préremplis et modifiables

**Given** je modifie le solde restant
**When** j'enregistre
**Then** le total et le plan de remboursement sont recalculés

**Given** je fais glisser une ligne vers la gauche
**When** je touche la suppression
**Then** une confirmation m'est demandée, mentionnant que l'historique des remboursements sera perdu

**Given** je supprime la dernière dette
**When** la liste se rafraîchit
**Then** l'état vide reprend sa place

### Story 4.4: Plan de remboursement avalanche ou boule de neige

As a utilisateur débordé,
I want qu'on me dise dans quel ordre rembourser,
So that je n'aie plus à arbitrer moi-même.

**Acceptance Criteria:**

**Given** j'ai plusieurs dettes déclarées
**When** j'ouvre le plan de remboursement
**Then** mes dettes sont ordonnées selon une méthode nommée et expliquée

**Given** la méthode avalanche est retenue
**When** je consulte l'ordre
**Then** les dettes aux taux les plus élevés viennent en premier

**Given** la méthode boule de neige est retenue
**When** je consulte l'ordre
**Then** les soldes les plus faibles viennent en premier

**Given** je change de méthode
**When** le plan se recalcule
**Then** l'ordre et le calendrier se mettent à jour, et l'écart de coût total entre les deux méthodes m'est indiqué

**Given** une dette n'a pas de taux d'intérêt renseigné
**When** la méthode avalanche s'applique
**Then** cette dette est signalée comme non classable faute d'information

**Given** le calcul du plan
**When** un développeur l'inspecte
**Then** il est réalisé par des fonctions pures, testées unitairement

### Story 4.5: Date de libération financière

As a utilisateur qui a besoin d'un horizon,
I want savoir quand j'aurai fini de rembourser,
So that l'effort ait une fin visible.

**Acceptance Criteria:**

**Given** un plan de remboursement est établi
**When** je le consulte
**Then** une date estimée de fin de toutes mes dettes s'affiche (FR30)

**Given** cette date est affichée
**When** je la lis
**Then** la durée restante est exprimée en langage courant, en plus de la date

**Given** j'augmente une mensualité
**When** le plan se recalcule
**Then** la date de libération avance, et le gain en temps m'est indiqué

**Given** une mensualité ne couvre pas les intérêts d'une dette
**When** le plan se calcule
**Then** l'application signale que cette dette ne se résorbera pas au rythme actuel

### Story 4.6: Enregistrement d'un remboursement

As a utilisateur qui vient de payer,
I want enregistrer mon versement,
So that je voie ma dette diminuer réellement.

**Acceptance Criteria:**

**Given** je consulte une dette
**When** j'enregistre un remboursement
**Then** le solde restant diminue du montant versé

**Given** un remboursement est enregistré
**When** je consulte l'historique de la dette
**Then** il y figure avec sa date et son montant

**Given** le remboursement solde la dette
**When** je valide
**Then** la dette passe en état soldé et un message célèbre l'étape franchie

**Given** j'enregistre un montant supérieur au solde restant
**When** je valide
**Then** l'application m'alerte et propose de solder la dette

**Given** un remboursement modifie le solde
**When** je reviens au plan
**Then** l'ordre des dettes et la date de libération sont à jour

---

## Epic 5: Objectifs d'Épargne

**Objectif :** l'utilisateur se fixe des objectifs chiffrés, suit sa progression et sait s'il tiendra le rythme.

**FRs couverts :** FR32, FR33, FR34, FR35, FR36

### Story 5.1: Création d'un objectif d'épargne

As a utilisateur qui a un projet,
I want le transformer en objectif chiffré,
So that j'aie une cible plutôt qu'une intention.

**Acceptance Criteria:**

**Given** j'ouvre la création d'un objectif
**When** l'écran s'affiche
**Then** le nom, le montant cible et la date limite me sont demandés
**And** l'épargne déjà disponible est proposée en champ facultatif

**Given** j'ai renseigné le montant et la date
**When** je regarde l'écran
**Then** un aperçu m'annonce le versement mensuel nécessaire, calculé par le moteur de simulation

**Given** un champ obligatoire est vide
**When** je regarde le bouton de validation
**Then** il est inactif

**Given** la date limite est passée
**When** je la sélectionne
**Then** un message m'invite à choisir une date future

**Given** je viens d'une projection du simulateur
**When** j'ouvre la création d'objectif
**Then** les paramètres de la simulation sont déjà remplis

### Story 5.2: Liste des objectifs

As a utilisateur,
I want voir tous mes objectifs et leur avancement,
So that je garde le cap sur plusieurs projets à la fois.

**Acceptance Criteria:**

**Given** j'ai des objectifs en cours
**When** j'ouvre la liste
**Then** le total épargné tous objectifs confondus s'affiche en tête

**Given** chaque objectif est listé
**When** je consulte une carte
**Then** elle indique le nom, le montant cible, le montant atteint et une barre de progression

**Given** je n'ai aucun objectif
**When** j'ouvre la liste
**Then** un état vide m'invite à créer le premier

**Given** un objectif est atteint
**When** je consulte la liste
**Then** il est visuellement distingué des objectifs en cours

### Story 5.3: Enregistrement d'un versement

As a utilisateur qui vient de mettre de l'argent de côté,
I want l'enregistrer sur mon objectif,
So that ma progression reflète la réalité.

**Acceptance Criteria:**

**Given** je consulte un objectif
**When** j'enregistre un versement
**Then** le montant atteint augmente et la barre de progression se met à jour

**Given** un versement est enregistré
**When** je consulte l'historique de l'objectif
**Then** il y figure avec sa date et son montant

**Given** un versement porte le total au-delà de la cible
**When** je valide
**Then** l'objectif est marqué comme atteint et l'étape est célébrée

**Given** je me suis trompé de montant
**When** je supprime le versement
**Then** une confirmation m'est demandée, puis la progression est recalculée

### Story 5.4: Progression et mensualité recommandée

As a utilisateur,
I want savoir combien mettre de côté chaque mois,
So that je n'aie pas à faire le calcul moi-même.

**Acceptance Criteria:**

**Given** je consulte un objectif
**When** l'écran s'affiche
**Then** le versement mensuel recommandé pour tenir l'échéance est indiqué

**Given** j'ai pris du retard
**When** le versement est recalculé
**Then** il augmente, et l'écart avec la recommandation initiale m'est expliqué

**Given** j'ai de l'avance
**When** le versement est recalculé
**Then** il diminue

**Given** un versement recommandé est affiché
**When** je le lis
**Then** il provient du moteur de simulation, pas d'un calcul dupliqué

### Story 5.5: Projection d'atteinte à la date cible

As a utilisateur,
I want savoir si je vais y arriver au rythme actuel,
So that je puisse corriger avant qu'il ne soit trop tard.

**Acceptance Criteria:**

**Given** j'ai enregistré au moins deux versements
**When** je consulte mon objectif
**Then** une projection m'indique si la cible sera atteinte à la date prévue, au rythme constaté

**Given** le rythme actuel est insuffisant
**When** la projection s'affiche
**Then** l'écart est chiffré et une action correctrice m'est proposée

**Given** le rythme actuel dépasse le nécessaire
**When** la projection s'affiche
**Then** la date d'atteinte anticipée m'est indiquée

**Given** je n'ai enregistré aucun versement
**When** je consulte mon objectif
**Then** aucune projection de rythme n'est affichée, seule la recommandation initiale figure

### Story 5.6: Modification et archivage d'un objectif

As a utilisateur dont les priorités changent,
I want ajuster ou ranger un objectif,
So that ma liste reste le reflet de ce qui compte aujourd'hui.

**Acceptance Criteria:**

**Given** je consulte un objectif
**When** je modifie son montant cible ou sa date
**Then** la mensualité recommandée et la projection sont recalculées

**Given** un objectif ne me concerne plus
**When** je l'archive
**Then** il disparaît de la liste active sans que ses versements soient perdus

**Given** j'ai des objectifs archivés
**When** je consulte la liste
**Then** je peux les afficher et en réactiver un

**Given** j'archive un objectif atteint
**When** je consulte le total épargné
**Then** le montant reste comptabilisé dans l'historique

---

## Epic 6: Notifications & Engagement

**Objectif :** l'utilisateur reçoit au bon moment les rappels qui l'aident à tenir ses engagements, et garde la main sur ce qu'il reçoit.

**FRs couverts :** FR43, FR44, FR45, FR46

### Story 6.1: Réglage des notifications par catégorie

As a utilisateur,
I want choisir ce dont on me prévient,
So that l'application m'aide sans devenir envahissante.

**Acceptance Criteria:**

**Given** j'ouvre mes paramètres de notification
**When** l'écran s'affiche
**Then** chaque catégorie dispose de son propre interrupteur : budget, dettes, résumé mensuel

**Given** je désactive une catégorie
**When** l'événement correspondant survient
**Then** aucune notification ne m'est envoyée pour cette catégorie

**Given** je n'ai jamais accordé l'autorisation système
**When** j'active une première catégorie
**Then** la demande d'autorisation m'est présentée, avec l'explication de son utilité

**Given** j'ai refusé l'autorisation au niveau du système
**When** j'ouvre les paramètres
**Then** l'application me l'indique et m'oriente vers les réglages du téléphone

### Story 6.2: Notification de seuil budgétaire

As a utilisateur,
I want être averti quand une enveloppe se vide,
So that je puisse ajuster avant la fin du mois.

**Acceptance Criteria:**

**Given** une catégorie atteint son seuil d'alerte
**When** l'événement se produit
**Then** une notification m'est envoyée, nommant la catégorie et le reste disponible (FR44)

**Given** je touche cette notification
**When** l'application s'ouvre
**Then** elle m'amène directement à l'écran du budget

**Given** la catégorie a déjà déclenché son alerte ce mois-ci
**When** je saisis d'autres dépenses dans cette catégorie
**Then** aucune notification supplémentaire n'est envoyée

**Given** j'ai désactivé les notifications de budget
**When** un seuil est atteint
**Then** aucune notification n'est envoyée, mais l'alerte reste visible dans l'application

### Story 6.3: Rappel d'échéance de dette

As a utilisateur endetté,
I want qu'on me rappelle mes échéances,
So that je n'accumule pas de pénalités par oubli.

**Acceptance Criteria:**

**Given** une échéance de dette approche
**When** le délai de rappel est atteint
**Then** une notification me prévient, nommant le créancier et le montant (FR45)

**Given** je touche la notification
**When** l'application s'ouvre
**Then** elle m'amène au détail de la dette concernée

**Given** j'ai déjà enregistré le remboursement du mois
**When** la date de rappel arrive
**Then** aucun rappel n'est envoyé

**Given** plusieurs échéances tombent le même jour
**When** les rappels sont envoyés
**Then** ils sont regroupés en une seule notification

### Story 6.4: Résumé financier mensuel

As a utilisateur,
I want un bilan mensuel,
So that je prenne du recul sans avoir à consulter chaque écran.

**Acceptance Criteria:**

**Given** un mois se termine
**When** le résumé est généré
**Then** il présente le total dépensé, le respect des enveloppes, l'évolution du score et la progression des objectifs (FR46)

**Given** je touche la notification du résumé
**When** l'application s'ouvre
**Then** le bilan détaillé du mois écoulé s'affiche

**Given** le mois écoulé ne comporte aucune donnée
**When** le résumé serait généré
**Then** aucune notification n'est envoyée

**Given** je lis le résumé
**When** j'en compare le ton aux règles éditoriales
**Then** il constate les faits et encourage la suite, sans culpabiliser

---

## Epic 7: Abonnement Premium & Paiements Mobile Money

**Objectif :** l'utilisateur comprend ce qu'apporte la formule payante, y souscrit par Wave ou Orange Money, et garde la maîtrise de son abonnement.

**FRs couverts :** FR37, FR38, FR39, FR40, FR41, FR42

### Story 7.1: Comparaison des formules

As a utilisateur qui hésite,
I want comparer clairement le gratuit et le payant,
So that je décide en connaissance de cause.

**Acceptance Criteria:**

**Given** j'ouvre l'écran d'abonnement
**When** il s'affiche
**Then** ma formule actuelle est indiquée par un badge

**Given** la comparaison est affichée
**When** je la lis
**Then** chaque fonction figure sur une ligne, avec sa disponibilité dans chaque formule (FR37)

**Given** je consulte le tableau
**When** je cherche la simulation
**Then** son statut dans chaque formule y est explicitement indiqué

**Given** le prix est affiché
**When** je le lis
**Then** il est exprimé en FCFA, sans frais caché

### Story 7.2: Souscription via Wave ou Orange Money

As a utilisateur convaincu,
I want payer avec le moyen que j'utilise déjà,
So that je n'aie pas besoin d'une carte bancaire.

**Acceptance Criteria:**

**Given** je choisis de passer à Premium
**When** le sélecteur de paiement s'ouvre
**Then** Wave et Orange Money me sont proposés (FR38)

**Given** je choisis un opérateur
**When** le paiement se lance
**Then** je suis redirigé vers son parcours de paiement

**Given** aucun identifiant de paiement
**When** on inspecte ce que l'application stocke
**Then** aucun identifiant Wave ou Orange Money n'y est conservé (NFR-S4)

**Given** le paiement n'est pas confirmé dans les 30 secondes
**When** le délai expire
**Then** l'abonnement passe en état « en attente » et une relance m'est proposée (NFR-I1)

**Given** l'opérateur est indisponible
**When** je tente de payer
**Then** un message clair me l'indique et mes fonctions gratuites restent accessibles

### Story 7.3: Activation Premium après paiement

As a utilisateur qui vient de payer,
I want accéder immédiatement aux fonctions payantes,
So that je constate que mon paiement a été pris en compte.

**Acceptance Criteria:**

**Given** le paiement est confirmé par l'opérateur
**When** le webhook est reçu
**Then** mon abonnement passe en Premium et les fonctions payantes se débloquent (FR39)

**Given** le même webhook est reçu deux fois
**When** il est traité
**Then** l'abonnement n'est activé qu'une seule fois et aucun double débit n'est enregistré (NFR-I3)

**Given** la signature du webhook est invalide
**When** il est reçu
**Then** il est rejeté et l'incident est journalisé sans donnée financière

**Given** mon abonnement vient d'être activé
**When** je reviens dans l'application
**Then** une confirmation m'accueille et le badge de ma formule est à jour

### Story 7.4: Bascule entre facturation mensuelle et annuelle

As a utilisateur,
I want choisir la périodicité qui m'arrange,
So that je paie de la façon la plus adaptée à mes revenus.

**Acceptance Criteria:**

**Given** je consulte les formules
**When** je bascule l'interrupteur de périodicité
**Then** les prix affichés se mettent à jour (FR40)

**Given** la formule annuelle est affichée
**When** je la compare à la mensuelle
**Then** l'économie réalisée est chiffrée

**Given** je suis déjà abonné au mois
**When** je passe à l'annuel
**Then** le prorata est expliqué avant validation

### Story 7.5: État de l'abonnement et renouvellement

As a utilisateur abonné,
I want savoir où j'en suis,
So that je ne sois jamais surpris par un prélèvement.

**Acceptance Criteria:**

**Given** je suis abonné
**When** j'ouvre l'écran d'abonnement
**Then** ma formule, sa périodicité et sa date de renouvellement s'affichent (FR41)

**Given** mon abonnement expire dans moins de sept jours
**When** je consulte l'écran
**Then** l'échéance est mise en évidence

**Given** mon abonnement a expiré
**When** j'ouvre l'application
**Then** je repasse en formule gratuite sans perdre aucune donnée
**And** les fonctions Premium redeviennent des invitations, jamais des écrans vides

### Story 7.6: Annulation de l'abonnement

As a utilisateur qui souhaite arrêter,
I want annuler sans obstacle,
So that je garde confiance même en partant.

**Acceptance Criteria:**

**Given** je suis abonné
**When** je demande l'annulation
**Then** elle est accessible en deux gestes au maximum depuis l'écran d'abonnement (FR42)

**Given** je confirme l'annulation
**When** elle est enregistrée
**Then** mon accès Premium court jusqu'à la fin de la période déjà payée

**Given** j'ai annulé
**When** la période payée s'achève
**Then** je repasse en gratuit et mes données sont conservées

**Given** j'annule
**When** le parcours se déroule
**Then** aucune tentative de rétention insistante ne m'est opposée

---

## Epic 8: Administration & Monitoring Plateforme

**Objectif :** l'administrateur suit la santé de la plateforme, gère les abonnements et est alerté quand un service tiers défaille.

**FRs couverts :** FR47, FR48, FR49

### Story 8.1: Tableau de bord des métriques

As a administrateur,
I want suivre les indicateurs clés,
So that je pilote le produit sur des faits.

**Acceptance Criteria:**

**Given** je suis authentifié comme administrateur
**When** j'ouvre l'espace d'administration
**Then** les inscriptions, le taux de conversion et la rétention à J+30 et J+90 s'affichent (FR47)

**Given** l'indicateur principal du produit
**When** je consulte le tableau de bord
**Then** la part d'inscrits ayant lancé au moins une simulation y figure

**Given** je ne suis pas administrateur
**When** je tente d'accéder à cette route
**Then** l'accès m'est refusé côté serveur, pas seulement masqué dans l'interface

**Given** les métriques sont affichées
**When** je les consulte
**Then** elles sont agrégées, sans donnée financière individuelle identifiable

### Story 8.2: Gestion des abonnements

As a administrateur,
I want consulter et corriger un abonnement,
So that je puisse résoudre un litige de paiement.

**Acceptance Criteria:**

**Given** je recherche un utilisateur
**When** j'ouvre sa fiche d'abonnement
**Then** sa formule, son historique de paiements et son état s'affichent (FR48)

**Given** un paiement a échoué à tort
**When** j'active manuellement l'abonnement
**Then** l'action est enregistrée avec son auteur et sa date

**Given** j'effectue un remboursement manuel
**When** je le valide
**Then** une confirmation m'est demandée et l'opération est tracée

**Given** je consulte une fiche
**When** je la parcours
**Then** aucune donnée financière personnelle de l'utilisateur, hors abonnement, ne m'est exposée

### Story 8.3: Alertes d'indisponibilité des services tiers

As a administrateur,
I want être prévenu quand un service externe tombe,
So that je réagisse avant que les utilisateurs ne s'en plaignent.

**Acceptance Criteria:**

**Given** un service tiers échoue de façon répétée
**When** le seuil d'échec est franchi
**Then** une alerte est déclenchée, nommant le service et la nature de la panne (FR49)

**Given** une alerte est active
**When** le service redevient disponible
**Then** le rétablissement est signalé

**Given** un service est en panne prolongée
**When** les échecs se répètent
**Then** les alertes ne se répètent pas à chaque échec individuel

**Given** une alerte est journalisée
**When** on l'inspecte
**Then** elle ne contient aucune donnée financière ni identifiant utilisateur

---

## Couverture des exigences UX

| Réf | Exigence | Couverte par |
|-----|----------|--------------|
| UX-DR1 | États vides pédagogiques | Story 2.8, reprise dans 2.2, 4.2, 5.2 |
| UX-DR2 | Tutoiement et microcopy validé | Contrainte transverse, vérifiée à chaque story |
| UX-DR3 | Mention légale sur les simulations | Story 3.4, reprise dans 3.9 |
| UX-DR4 | Aucune recommandation de produit tiers | Story 2.11 |
| UX-DR5 | Onboarding progressif et reprenable | Story 1.8 |
| UX-DR6 | Composants du Design System | Contrainte transverse, posée par la story 1.1 |

---

## Spécifications sans exigence associée

Quatre vues conçues en phase 3 ne correspondent à aucune exigence fonctionnelle du PRD et ne figurent donc dans aucun epic :

| Spécification | Scénario | Priorité au découpage |
|---------------|----------|----------------------|
| 06.1 Assistant financier | 06 — Kofi consulte son assistant | P2 |
| 07.1 Liste des investissements | 07 — Kofi suit ses investissements BRVM | P2 |
| 07.2 Détail d'un investissement | 07 | P2 |
| 08.1 Espace entrepreneur | 08 — Moussa configure son espace | P3 |

L'assistant financier contextuel et le suivi BRVM figurent pourtant parmi les avantages concurrentiels revendiqués par le Product Brief. Deux voies possibles : écrire les exigences manquantes et créer les epics correspondants, ou assumer que ces vues sortent du périmètre du MVP. **À trancher avant la clôture de la phase de découpage.**
