---
stepsCompleted: ['step-01-init', 'step-02-context', 'step-03-starter', 'step-04-decisions', 'step-05-patterns', 'step-06-structure', 'step-07-validation', 'step-08-complete']
workflowType: 'architecture'
status: 'complete'
completedAt: '2026-04-15'
inputDocuments:
  - '.bmad-outpout/planning-artifacts/prd.md'
  - '.bmad-outpout/A-Product-Brief/project-brief.md'
  - '.bmad-outpout/C-UX-Scenarios/00-ux-scenarios.md'
workflowType: 'architecture'
project_name: 'App Finance UEMOA'
user_name: 'Fitz'
date: '2026-04-15'
---

# Architecture Decision Document — App Finance UEMOA

_Ce document se construit de façon collaborative, étape par étape. Les sections sont ajoutées au fil des décisions architecturales._

---

## Analyse du Contexte Projet

### Vue d'ensemble des exigences

**Exigences Fonctionnelles :** 57 FRs répartis en 11 domaines — Auth, Onboarding, Dépenses/Budget, Simulation (différenciateur central), Dettes, Objectifs d'épargne, Abonnement/Paiement, Notifications, Pédagogie UX, Résilience, Administration.

**Exigences Non-Fonctionnelles critiques :**
- Simulation recalculée ≤ 500ms (calcul 100% local, offline)
- Dashboard chargé ≤ 3s sur réseau 3G
- Démarrage froid ≤ 4s sur Android 8 / 2GB RAM
- APK ≤ 30MB
- Offline : lecture + saisie sans connexion, sync automatique à la reconnexion
- Sécurité : AES-256 at-rest, TLS 1.3 in-transit, isolation stricte par user_id côté serveur
- Crash rate < 0.5% Android
- Scalabilité : 1 000 utilisateurs concurrents, extensible à 50 000 sans refactoring majeur

**Complexité & Domaine :**
- Domaine : Mobile App (React Native + Expo, TypeScript strict)
- Complexité : Haute — fintech, offline-first, moteur de simulation, paiements mobiles, sécurité données financières
- Composants architecturaux estimés : 12–15

### Contraintes Techniques (décidées dans le PRD)

- React Native + Expo (TypeScript strict) — Android P1 (API 26+), iOS P2, Web P3
- MMKV : stockage local chiffré pour données financières sensibles
- TanStack Query : cache offline + file de mutations avec retry automatique
- React Navigation v6+
- Zustand ou Redux Toolkit (à décider)
- Expo Updates : correctifs OTA sans validation store

### Concernements Transversaux

1. **Auth & isolation données** — toutes les requêtes filtrées par `user_id` vérifié côté serveur
2. **Offline-first** — simulation 100% locale, saisies en file d'attente, dashboard en cache
3. **Gating freemium/premium** — vérification état abonnement sur toutes les features Premium
4. **Intégrations isolées** — Wave, Orange Money, BRVM derrière interfaces internes (jamais appelées directement)
5. **Disclaimers légaux** — affichés systématiquement sur toute simulation
6. **Dégradation gracieuse** — aucune feature core ne se bloque sur une API externe indisponible
7. **Taux UEMOA configurables** — FR50 : taux dans fichier de configuration, jamais codés en dur

---

## Starter Template

### Domaine technologique

Mobile App — React Native + Expo (TypeScript strict), décidé dans le PRD.

### Starter sélectionné : `create-expo-app` officiel (SDK 55)

**Expo SDK 55** — React Native 0.83/0.84, New Architecture activée par défaut, Expo Router 4 intégré.

**Commande d'initialisation :**

```bash
npx create-expo-app@latest FinanceUEMOA
```

**Décisions prises par le starter :**
- TypeScript strict configuré
- Expo Router v4 — navigation par fichiers (`/app/` = routes)
- Structure de base : `/app`, `/components`, `/assets`
- Hot reload, debug, build Android/iOS prêts
- New Architecture (meilleure performance native, bridge JS supprimé)

**Dépendances additionnelles :**

| Lib | Rôle |
|-----|------|
| `zustand` | État global — léger, adapté solo dev |
| `@tanstack/react-query` | Cache + file de mutations offline |
| `react-native-mmkv` | Stockage local chiffré (données financières) |
| `nativewind` + `tailwindcss` | Style Tailwind sur mobile |
| `zod` | Validation de toute donnée externe |
| `react-hook-form` | Formulaires (onboarding, dépenses, simulation) |
| `expo-notifications` | Push notifications (budget, dettes, rappels) |
| `expo-local-authentication` | Biométrie optionnelle |
| `expo-updates` | OTA — correctifs sans validation store |

**Note :** L'initialisation du projet avec cette commande sera la première story d'implémentation.

---

## Patterns d'Implémentation & Règles de Cohérence

### Points de conflit identifiés

6 zones critiques où des choix incohérents entre sessions de développement pourraient créer des conflits : nommage, montants financiers, structure projet, format réponses Supabase, gestion des erreurs, états de chargement.

### Patterns de nommage

**Base de données (PostgreSQL/Supabase) :**
```
snake_case pour tout — tables, colonnes, foreign keys
✅ user_id, monthly_amount, created_at, debt_payments
❌ userId, monthlyAmount, createdAt
```

**TypeScript / React Native :**
```
camelCase   → variables et fonctions
PascalCase  → composants, types, interfaces, enums
SCREAMING_SNAKE_CASE → constantes globales
✅ const userId, function getMonthlyBudget(), <BudgetCard />, type DebtPlan, MAX_RETRY_COUNT
❌ const user_id, function get_monthly_budget()
```

**Fichiers et dossiers :**
```
kebab-case  → tous les fichiers et dossiers
PascalCase  → fichiers de composants React uniquement
✅ /services/debt-calculator.ts, /components/BudgetCard.tsx, /hooks/useSimulation.ts
❌ /services/debtCalculator.ts, /components/budget-card.tsx
```

### Montants financiers — règle critique

FCFA = monnaie entière, sans centimes. Stocker et calculer en entiers.

```typescript
// ✅ CORRECT
amount: number         // ex: 50000 = 50 000 FCFA — jamais de float
interestRate: number   // ex: 0.065 = 6,5% — float uniquement pour les taux

// ✅ Affichage
formatCurrency(50000) → "50 000 FCFA"

// ❌ INTERDIT
amount: 50000.50
```

### Structure du projet

```
/app                    ← Routes Expo Router (screens)
  /(auth)               ← Groupe routes non-authentifiées
  /(tabs)               ← Groupe routes authentifiées (tabs)
  /admin                ← Routes admin
/components
  /ui                   ← Atomes (Button, Input, Card...)
  /features             ← Composants feature (BudgetCard, DebtItem...)
/hooks                  ← Custom hooks (useSimulation, useBudget...)
/services               ← Accès Supabase isolé
  supabase.ts           ← Client Supabase + types générés
  transactions.ts
  debts.ts
  simulation.ts         ← Moteur de simulation (calculs purs)
/stores                 ← Zustand stores (état global)
/types                  ← Types TypeScript partagés
/constants              ← UEMOA_RATES, config
/utils                  ← Fonctions pures utilitaires (formatCurrency...)
/__tests__              ← Tests co-localisés avec la source
```

**Règle absolue :** les composants n'appellent jamais Supabase directement — toujours via `/services/` ou un custom hook.

### Format des réponses Supabase

```typescript
// Wrapper de service — format uniforme pour tous les appels
type ServiceResult<T> = { data: T | null; error: string | null }

async function getTransactions(userId: string): Promise<ServiceResult<Transaction[]>> {
  const { data, error } = await supabase.from('transactions').select()
  if (error) return { data: null, error: error.message }
  return { data, error: null }
}
```

### Gestion des erreurs

```typescript
// 2 niveaux distincts : log technique (Sentry) + message utilisateur
try {
  await saveTransaction(data)
} catch (error) {
  Sentry.captureException(error)   // Log complet — jamais exposé à l'utilisateur
  showToast("Hmm, la sauvegarde a échoué. Réessaie dans un instant.")
}
// ❌ INTERDIT : catch vide, erreur silencieuse, détails techniques exposés à l'utilisateur
// ✅ Mode dégradé : feature désactivée + message clair + fallback toujours disponible
```

### États de chargement

```typescript
// TanStack Query gère isLoading/isError/data — pas de state manuel
const { data, isLoading, error } = useQuery({ queryKey: ['transactions'], queryFn: fetchTransactions })

// États vides → <EmptyState /> avec action guidée (FR51)
// Chargement → <LoadingSpinner /> ou skeleton — jamais de blank screen
// Erreur réseau → <ErrorState message="..." onRetry={refetch} />
```

### Simulation engine — règles spéciales

```typescript
// Fonctions pures, 100% locales, testables unitairement — aucun effet de bord
function calculateCompoundInterest(
  principal: number,            // FCFA entier
  rate: number,                 // float 0-1
  years: number,
  monthlyContribution: number   // FCFA entier
): SimulationResult { ... }

// ❌ INTERDIT dans le moteur : appels Supabase, Zustand, navigation
// ✅ Disclaimer affiché systématiquement sur tout résultat (obligation légale)
```

### Règles obligatoires — tous les agents Claude

- `snake_case` en DB, `camelCase` en TypeScript — sans exception
- Montants FCFA en entiers — jamais de float
- Jamais appeler Supabase depuis un composant — passer par `/services/`
- Jamais de données financières dans les logs (Sentry breadcrumbs inclus)
- Services retournent toujours `{ data, error }`
- Disclaimer systématique sur toute simulation affichée
- Pas de `any` TypeScript — utiliser `unknown` si type incertain

---

## Structure du Projet & Frontières Architecturales

### Arborescence complète

```
FinanceUEMOA/
├── app.config.ts              ← Config Expo (env, plugins, EAS)
├── package.json
├── tsconfig.json              ← TypeScript strict
├── tailwind.config.js
├── babel.config.js
├── eas.json                   ← Config EAS Build (dev/preview/prod)
├── .env.local                 ← Variables locales (jamais commitées)
├── .env.example               ← Template variables d'env
├── .gitignore
│
├── .github/
│   └── workflows/
│       └── ci.yml             ← Build + test auto sur push
│
├── app/                       ← Routes Expo Router (= screens)
│   ├── _layout.tsx            ← Root layout (providers globaux)
│   ├── index.tsx              ← Redirect → auth ou tabs
│   ├── (auth)/                ← Routes non-authentifiées
│   │   ├── _layout.tsx
│   │   ├── welcome.tsx        ← 01.1 Splash/Welcome
│   │   ├── login.tsx          ← FR01-02 Connexion
│   │   ├── register.tsx       ← FR01 Inscription
│   │   └── forgot-password.tsx ← FR03 Reset mot de passe
│   ├── (onboarding)/          ← FR08-11 Onboarding progressif
│   │   ├── _layout.tsx
│   │   ├── profile.tsx        ← 01.3 Profil
│   │   ├── situation.tsx      ← 01.4 Situation financière
│   │   └── goal.tsx           ← 01.5 Premier objectif
│   ├── (tabs)/                ← Routes authentifiées (tab bar)
│   │   ├── _layout.tsx        ← Tab bar configuration
│   │   ├── index.tsx          ← 01.6 Dashboard (FR18)
│   │   ├── transactions.tsx   ← 02.2 Liste dépenses (FR14)
│   │   ├── simulator.tsx      ← 03.1 Simulateur (FR19-25)
│   │   ├── debts.tsx          ← 04.1 Liste dettes (FR28)
│   │   └── goals.tsx          ← 05.1 Liste objectifs (FR32)
│   ├── transaction/
│   │   ├── new.tsx            ← 02.1 Saisie dépense (FR12)
│   │   └── [id].tsx           ← FR13 Modifier/supprimer
│   ├── budget.tsx             ← 02.3 Budget mensuel (FR15-17)
│   ├── simulation/
│   │   └── [id].tsx           ← 03.2 Résultat + scénario (FR23)
│   ├── debt/
│   │   ├── new.tsx            ← 04.2 Ajouter dette (FR26)
│   │   └── [id]/
│   │       ├── index.tsx      ← Détail dette (FR27-28)
│   │       └── repayment.tsx  ← 04.3 Plan remboursement (FR29-30)
│   ├── goal/
│   │   ├── new.tsx            ← 05.2 Créer objectif (FR32)
│   │   └── [id].tsx           ← 05.3 Détail objectif (FR33-36)
│   ├── profile.tsx            ← 09.1 Profil (FR06-07)
│   ├── settings.tsx           ← 09.2 Paramètres & intégrations
│   ├── subscription.tsx       ← 09.3 Abonnement (FR37-42)
│   └── admin/                 ← FR47-49 Admin (route protégée)
│       ├── _layout.tsx
│       └── index.tsx
│
├── components/
│   ├── ui/                    ← Atomes réutilisables
│   │   ├── Button.tsx
│   │   ├── Input.tsx
│   │   ├── Card.tsx
│   │   ├── Badge.tsx
│   │   ├── LoadingSpinner.tsx
│   │   ├── EmptyState.tsx     ← FR51 États vides pédagogiques
│   │   ├── ErrorState.tsx     ← FR56 Erreur dégradée
│   │   ├── Toast.tsx
│   │   ├── Modal.tsx
│   │   ├── ProgressBar.tsx
│   │   ├── CurrencyInput.tsx  ← Input FCFA (entiers, formatage)
│   │   └── RateInput.tsx      ← Input taux en %
│   └── features/
│       ├── auth/
│       │   └── BiometricButton.tsx    ← FR04
│       ├── dashboard/
│       │   ├── HealthScoreCard.tsx    ← FR18
│       │   └── QuickStatsRow.tsx
│       ├── transactions/
│       │   ├── TransactionItem.tsx
│       │   ├── CategoryPicker.tsx
│       │   └── BudgetProgressBar.tsx  ← FR16-17
│       ├── simulation/
│       │   ├── SimulationForm.tsx
│       │   ├── ProjectionChart.tsx
│       │   ├── ScenarioComparison.tsx ← FR23 Premium
│       │   └── SimulationDisclaimer.tsx ← OBLIGATOIRE légalement
│       ├── debts/
│       │   ├── DebtItem.tsx
│       │   ├── DebtPlanCard.tsx
│       │   └── LiberationDateBadge.tsx ← FR30
│       ├── goals/
│       │   ├── GoalCard.tsx
│       │   └── GoalProgress.tsx       ← FR34-35
│       └── subscription/
│           ├── PlanCard.tsx           ← FR37
│           └── PaymentButton.tsx      ← FR38 Wave/MoMo
│
├── hooks/                     ← Logique métier — jamais dans les composants
│   ├── useAuth.ts             ← FR01-07 Session + biométrie
│   ├── useSimulation.ts       ← FR19-25 Calculs locaux
│   ├── useDebtPlan.ts         ← FR29-30 Avalanche/boule de neige
│   ├── useBudget.ts           ← FR15-17 Budget + alertes
│   ├── useGoalProjection.ts   ← FR34-35 Projection objectif
│   ├── useSubscription.ts     ← FR37-42 État abonnement + feature flags
│   ├── useOfflineSync.ts      ← Offline mutations queue
│   └── useNotifications.ts    ← FR43-46 Push
│
├── services/                  ← Accès Supabase isolé (jamais appelé depuis les composants)
│   ├── supabase.ts            ← Client singleton + types générés
│   ├── auth.ts                ← FR01-07
│   ├── transactions.ts        ← FR12-18
│   ├── budgets.ts             ← FR15-17
│   ├── debts.ts               ← FR26-31
│   ├── goals.ts               ← FR32-36
│   ├── subscriptions.ts       ← FR37-42
│   ├── notifications.ts       ← FR43-46
│   ├── uemoa-rates.ts         ← FR50 Taux configurables
│   ├── admin.ts               ← FR47-49
│   └── simulation-engine/     ← Moteur pur — zéro dépendances externes
│       ├── compound-interest.ts
│       ├── debt-avalanche.ts
│       ├── debt-snowball.ts
│       ├── goal-projection.ts
│       └── inflation-adjuster.ts
│
├── stores/                    ← Zustand (état global uniquement)
│   ├── auth.store.ts          ← Session, profil user
│   ├── subscription.store.ts  ← Plan actuel, feature flags Premium
│   └── ui.store.ts            ← Préférences UI
│
├── types/
│   ├── supabase.ts            ← Types auto-générés (supabase gen types)
│   ├── models.ts              ← Transaction, Debt, Goal, Simulation...
│   ├── navigation.ts          ← Types routes Expo Router
│   └── api.ts                 ← ServiceResult<T>, etc.
│
├── constants/
│   ├── uemoa-rates.ts         ← Taux BRVM/épargne/inflation défaut (FR50)
│   ├── categories.ts          ← Catégories dépenses UEMOA
│   ├── plans.ts               ← Features Gratuit vs Premium
│   └── config.ts              ← Timeouts, limites, seuils
│
├── utils/
│   ├── currency.ts            ← formatCurrency(50000) → "50 000 FCFA"
│   ├── dates.ts               ← Formatage dates fr-FR/fr-CI
│   └── validation.ts          ← Helpers Zod communs
│
├── supabase/                  ← Infrastructure Supabase
│   ├── config.toml
│   ├── migrations/            ← Migrations DB versionées
│   ├── seeds/                 ← Données de test locales
│   └── functions/             ← Edge Functions (Deno/TypeScript)
│       ├── wave-webhook/      ← Webhook paiement Wave (FR38-39)
│       ├── momo-webhook/      ← Webhook Orange Money/MoMo
│       └── brvm-sync/         ← Cron quotidien données BRVM
│
└── __tests__/
    ├── unit/
    │   ├── simulation-engine/ ← Tests critiques — cas réels UEMOA
    │   └── utils/
    └── integration/
        └── services/
```

### Frontières architecturales

**Frontière Auth :**
Supabase Auth → `useAuth` hook → middleware Expo Router → routes `(tabs)/` et `(onboarding)/` protégées automatiquement.

**Frontière Paiement :**
Wave/MoMo → Edge Function (vérification signature + idempotence) → table `subscriptions` → `useSubscription` hook → feature flags Zustand → gating dans les composants.

**Frontière Simulation :**
`/services/simulation-engine/` = îlot isolé. Fonctions pures sans effets de bord. Aucun appel réseau, aucun store. Appelé uniquement via `useSimulation.ts`.

**Frontière BRVM :**
API BRVM externe → Edge Function cron quotidien → table `uemoa_rates` → `uemoa-rates.ts` service → hooks simulation.

**Frontière Offline :**
TanStack Query mutations → file locale MMKV (chiffré) → sync automatique à la reconnexion → Supabase.

### Flux de données principal

```
User action
  → Screen (app/)
  → Custom Hook (hooks/)
  → Service (services/)
  → Supabase SDK
  → PostgreSQL (RLS actif — user_id vérifié automatiquement)

Mode offline :
  → TanStack Query mutation en attente
  → MMKV (chiffré)
  → Sync auto à la reconnexion
```

---

## Validation Architecturale

### Cohérence des décisions ✅

Toutes les technologies sont compatibles entre elles. Expo SDK 55 + Expo Router v4 + Supabase JS v2.99.1 + NativeWind 4 + Sentry v8.7.0 forment une stack cohérente sans conflits de versions. La séparation Zustand (état app) / TanStack Query (état serveur) est propre et sans chevauchement. Le simulation engine pur s'intègre naturellement dans l'architecture offline-first.

### Couverture des exigences ✅

**57/57 FRs couverts.** Tous les NFRs critiques adressés architecturalement :
- Simulation ≤500ms → calcul 100% local (`simulation-engine/`)
- Offline read+write → MMKV + TanStack Query mutations queue
- Sécurité AES-256 → MMKV chiffré + Supabase encryption + RLS
- Webhooks idempotents → Edge Function avec vérification `webhook_id`
- Multi-user préparé → RLS par `auth.uid()` dès le MVP

### Gaps identifiés et résolus

**Gap 1 — Supabase Auth storage adapter (mineur) :**
Supabase Auth avec React Native nécessite MMKV comme storage pour les sessions JWT.
```typescript
// services/supabase.ts
const supabase = createClient(url, key, {
  auth: { storage: new MMKVStorage(), autoRefreshToken: true, persistSession: true }
})
```

**Gap 2 — Script génération types (mineur) :**
À ajouter dans `package.json` pour régénérer les types après chaque migration :
```json
"scripts": {
  "types:supabase": "supabase gen types typescript --local > types/supabase.ts"
}
```

**Gap 3 — FR24 simulation sans inscription (mineur) :**
Route `/app/simulator-preview.tsx` hors groupe `(tabs)/` — état local uniquement, pas de sauvegarde. Redirige vers inscription après la simulation.

### Checklist de complétude

- [x] Contexte projet analysé — 57 FRs, NFRs, contraintes UEMOA
- [x] Stack décidée avec versions vérifiées
- [x] Patterns d'implémentation définis — nommage, FCFA entiers, erreurs, offline
- [x] Structure projet complète — arborescence mappée aux FRs
- [x] Frontières architecturales claires — Auth, Paiement, Simulation, BRVM, Offline
- [x] Gaps identifiés et résolus

### Statut : PRÊT POUR L'IMPLÉMENTATION ✅

**Confiance : Haute**

**Première commande d'implémentation :**
```bash
npx create-expo-app@latest FinanceUEMOA
```

---

## Décisions Architecturales

### Analyse des priorités

**Décisions critiques (bloquent l'implémentation) :**
- Backend & base de données → Supabase (PostgreSQL)
- Authentification → Supabase Auth
- State management → Zustand + TanStack Query
- Build & distribution → EAS Build + EAS Submit

**Décisions importantes (structurent l'architecture) :**
- API → Supabase JS SDK + Edge Functions
- Monitoring → Sentry
- OTA → Expo Updates
- CI/CD → GitHub Actions + EAS

**Décisions différées (post-MVP) :**
- Import automatique Wave/MoMo (Phase 2)
- BRVM temps réel (Phase 2)
- Multi-utilisateurs (schéma préparé, feature désactivée)

---

### Architecture des données

**Backend : Supabase** (`@supabase/supabase-js` v2.99.1)

PostgreSQL avec Row Level Security (RLS) — isolation des données garantie au niveau base de données, pas seulement dans le code. Chaque requête est filtrée par `auth.uid()` automatiquement.

Avantage pour ce projet : les données financières sont intrinsèquement relationnelles (transactions → catégories → budgets → objectifs → dettes). PostgreSQL est fait pour ces jointures et agrégations.

**Stockage local (offline) :**
- `react-native-mmkv` — données financières sensibles (chiffrées AES)
- TanStack Query cache — données serveur en mémoire + file de mutations

**Schéma principal (tables Supabase) :**
- `profiles` — données utilisateur, situation financière
- `transactions` — dépenses et revenus
- `budgets` — enveloppes budgétaires mensuelles
- `debts` + `debt_payments` — dettes et remboursements
- `savings_goals` + `goal_contributions` — objectifs et versements
- `simulations` — scénarios sauvegardés
- `subscriptions` — état abonnement, historique paiements
- `uemoa_rates` — taux de référence configurables (FR50)

**Migration :** Supabase CLI (`supabase db diff` + migrations versionées)

---

### Authentification & Sécurité

**Auth : Supabase Auth**
- Email + mot de passe (MVP)
- JWT + refresh tokens gérés par le SDK
- Session expirée après 15 min d'inactivité (middleware Supabase)
- Biométrie locale : `expo-local-authentication` — traitement 100% local OS, jamais transmis

**Sécurité données :**
- At-rest : AES-256 via MMKV (local) + chiffrement Supabase (serveur)
- In-transit : TLS 1.3 (Supabase par défaut)
- RLS : politique par table, `auth.uid()` obligatoire
- Logs : zéro donnée financière — `console.log` bannis sur les objets sensibles

---

### API & Communication

**Lecture/écriture :** Supabase JS SDK directement depuis React Native — pas d'API REST custom à maintenir.

**Webhooks Wave/MoMo :** Supabase Edge Functions (Deno/TypeScript)
- Réception + vérification signature
- Idempotence : vérification `webhook_id` avant activation Premium
- Retry automatique côté opérateur

**Données BRVM :** Edge Function cron (quotidien) → stockage en DB → servi depuis cache.

**Notifications push :** Expo Push Notifications Service → `expo-notifications` côté client.

**Gestion des erreurs :**
- Toute intégration externe (Wave, MoMo, BRVM) derrière une interface TypeScript
- Dégradation gracieuse : si API indisponible → feature non bloquante + message clair
- Timeout Wave/MoMo : 30s max, état "en attente" avec retry

---

### Architecture Frontend

| Aspect | Décision | Détail |
|--------|----------|--------|
| Navigation | Expo Router v4 | `/app/` = routes, file-based |
| State global | Zustand | Session user, abonnement, préférences UI |
| State serveur | TanStack Query | Cache, offline mutations, sync auto |
| Style | NativeWind + Tailwind | Classes Tailwind sur composants RN |
| Formulaires | React Hook Form + Zod | Validation schéma-first |
| Stockage local | MMKV (sensible) + AsyncStorage (préférences) | |
| Simulation engine | Calculs purs TypeScript | 100% local, offline, testable unitairement |

**Séparation des responsabilités :**
- Logique métier → custom hooks (`useSimulation`, `useDebtPlan`, `useBudget`)
- Composants UI → présentation pure, sans logique métier
- Services → couche d'accès Supabase isolée (`/services/`)

---

### Infrastructure & Déploiement

| Aspect | Solution | Version |
|--------|----------|---------|
| Build mobile | EAS Build | Cloud — Android + iOS sans Mac local |
| Distribution | EAS Submit | Google Play + App Store automatisé |
| OTA updates | Expo Updates | Correctifs JS sans validation store |
| Monitoring | `@sentry/react-native` | v8.7.0 — crash + performance + traces |
| Variables d'env | `app.config.ts` + EAS Secrets | Jamais de secrets dans le code |
| CI/CD | GitHub Actions + EAS | Build + submit automatique sur tag |

**Environnements :**
- `development` — Supabase local (CLI)
- `preview` — Supabase staging cloud
- `production` — Supabase production

### Analyse d'impact des décisions

**Séquence d'implémentation imposée par ces décisions :**
1. Init projet Expo + configuration Supabase local
2. Schéma DB + migrations + RLS policies
3. Supabase Auth + session management
4. Simulation engine (calculs locaux, testés unitairement)
5. Features métier (dépenses → dettes → objectifs)
6. Edge Functions (webhooks paiement)
7. Notifications push
8. EAS Build + Sentry + CI/CD

**Dépendances croisées :**
- Toutes les features métier dépendent du schéma DB (décision 1)
- Le gating Premium dépend des webhooks (Edge Functions)
- L'offline-first dépend de TanStack Query configuré avant les features
