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

## Révision — 2026-08-20 : bascule vers Flutter

Le framework client passe de **React Native + Expo** à **Flutter + Dart**, sur décision produit.

**Ce qui change :** framework, langage, conventions de nommage, structure du projet, bibliothèques clientes, chaîne de build.

**Ce qui ne change pas :** Supabase et son schéma, les politiques RLS, les Edge Functions, les frontières architecturales, la règle des montants en entiers, le principe du moteur de simulation pur et hors ligne, l'ensemble des 57 FRs et des NFRs.

Les sections ci-dessous reflètent la stack Flutter. Les mentions résiduelles d'Expo dans l'historique du document sont caduques.

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
- Domaine : Mobile App (Flutter + Dart)
- Complexité : Haute — fintech, offline-first, moteur de simulation, paiements mobiles, sécurité données financières
- Composants architecturaux estimés : 12–15

### Contraintes Techniques

- Flutter + Dart — Android P1 (API 26+), iOS P2, Web P3
- `flutter_secure_storage` : sessions JWT dans le Keystore / Keychain
- `drift` (SQLite) : persistance locale chiffrée et file de mutations hors ligne
- `go_router` : navigation déclarative
- `flutter_riverpod` : état applicatif et état serveur
- Distribution : builds signés via CI (pas d'équivalent OTA à la Expo Updates —
  les correctifs passent par une publication store)

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

Mobile App — Flutter + Dart, un seul codebase pour Android, iOS et Web.

### Initialisation

Le projet est scaffoldé à la main (`pubspec.yaml`, `lib/`, thème, composants).
Les dossiers de plateforme sont générés localement et non versionnés :

```bash
flutter create . --platforms=android,ios --org com.sira
flutter pub get
```

**Dépendances retenues :**

| Paquet | Rôle |
|--------|------|
| `flutter_riverpod` | État applicatif et état serveur — sûr à la compilation |
| `go_router` | Navigation déclarative, deep links |
| `supabase_flutter` | SDK officiel Supabase |
| `flutter_secure_storage` | Sessions JWT (Keystore Android / Keychain iOS) |
| `drift` + `sqlite3_flutter_libs` | SQLite typé — persistance et file de mutations hors ligne |
| `intl` | Formatage FCFA et dates francophones |
| `fl_chart` | Courbes de projection et historiques BRVM |
| `sentry_flutter` | Crash reporting et traces |

**Équivalences avec la stack précédente :**

| React Native | Flutter |
|--------------|---------|
| Zustand | Riverpod |
| TanStack Query | Riverpod `AsyncNotifier` |
| MMKV | `flutter_secure_storage` + `drift` |
| NativeWind / Tailwind | `ThemeData` + tokens Dart |
| Reanimated | `AnimationController` (intégré) |
| Zod + React Hook Form | `Form` + validateurs (intégrés) |

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

**Dart :**
```
camelCase   → variables, fonctions, constantes
PascalCase  → classes, widgets, enums, typedefs
_leadingUnderscore → membres et classes privés au fichier
✅ final userId, int monthlyBudget(), class BudgetCard, enum DebtStrategy
❌ final user_id, const MAX_RETRY_COUNT
```

**Fichiers et dossiers :**
```
snake_case → tous les fichiers et dossiers, sans exception
✅ lib/features/debts/debt_calculator.dart, lib/shared/widgets/app_card.dart
❌ lib/features/debts/debtCalculator.dart, lib/shared/widgets/AppCard.dart
```

La correspondance avec la base reste directe : `snake_case` en base, `snake_case`
pour les fichiers, `camelCase` pour les champs Dart.

### Montants financiers — règle critique

FCFA = monnaie entière, sans centimes. Stocker et calculer en entiers.

```dart
// ✅ CORRECT
final int amount;          // 50000 = 50 000 FCFA — le type interdit le float
final double interestRate; // 0.065 = 6,5 % — double réservé aux taux

// ✅ Affichage
Currency.format(50000); // "50 000 FCFA"

// ❌ INTERDIT
final double amount = 50000.50;
```

Le typage `int` de Dart rend la règle structurelle : un montant décimal ne
compile pas. C'est un gain net par rapport au `number` de TypeScript.

### Structure du projet

Organisation par fonctionnalité : chaque domaine métier regroupe son interface,
ses providers et sa logique.

```
lib/
├── main.dart                  ← Point d'entrée, initialisations
├── app.dart                   ← MaterialApp.router
├── core/                      ← Transverse, sans dépendance aux features
│   ├── theme/                 ← Tokens du Design System
│   ├── router/                ← Routes go_router
│   ├── config/                ← Variables d'environnement
│   ├── constants/             ← Taux UEMOA, catégories
│   └── utils/                 ← Currency, Dates
├── data/
│   ├── models/                ← Modèles métier
│   ├── services/              ← Accès Supabase isolé
│   └── local/                 ← Base drift, file de mutations
├── features/                  ← Un dossier par domaine
│   └── <domaine>/
│       ├── presentation/      ← Écrans et widgets propres au domaine
│       ├── providers/         ← Riverpod
│       └── domain/            ← Logique métier pure
└── shared/
    └── widgets/               ← Composants du Design System
```

**Règle absolue :** un widget n'appelle jamais Supabase directement — il passe
par un provider Riverpod, lui-même adossé à `data/services/`.

### Format des réponses de service

```dart
/// Résultat uniforme — aucun service ne propage d'exception brute.
sealed class Result<T> {
  const Result();
}

final class Success<T> extends Result<T> {
  const Success(this.data);
  final T data;
}

final class Failure<T> extends Result<T> {
  const Failure(this.message);
  final String message;
}
```

Le `sealed class` de Dart force le traitement exhaustif des deux cas au
`switch` : impossible d'ignorer une erreur par omission.

### Gestion des erreurs

```dart
// Deux niveaux distincts : trace technique et message utilisateur.
try {
  await saveTransaction(data);
} catch (error, stack) {
  await Sentry.captureException(error, stackTrace: stack); // jamais exposé
  AppToast.show(context, 'Hmm, la sauvegarde a échoué. Réessaie dans un instant.',
      type: ToastType.error);
}
```

Interdit : `catch` vide, erreur silencieuse, détail technique montré à
l'utilisateur. Attendu : fonction dégradée, message clair, repli disponible.

### États de chargement

```dart
// AsyncValue porte les trois états — pas de booléen manuel.
ref.watch(transactionsProvider).when(
      data: (items) => TransactionList(items: items),
      loading: () => const TransactionSkeleton(),
      error: (e, _) => ErrorStateView(onRetry: () => ref.invalidate(transactionsProvider)),
    );
```

État vide → `EmptyState` avec action guidée (FR51). Chargement → squelette,
jamais d'écran blanc. Erreur réseau → message et possibilité de relancer.

### Moteur de simulation — règles spéciales

```dart
/// Fonctions pures, locales, testables — aucun effet de bord.
SimulationResult calculateCompoundInterest({
  required int principal,           // FCFA entier
  required double annualRate,       // fraction 0-1
  required int months,
  required int monthlyContribution, // FCFA entier
}) { ... }
```

Interdit dans le moteur : appel Supabase, lecture de provider, navigation.
Obligatoire : mention légale affichée sur tout résultat de simulation.

### Règles obligatoires — toute session de développement

- `snake_case` en base et pour les fichiers, `camelCase` en Dart
- Montants FCFA typés `int` — jamais `double`
- Aucun appel Supabase depuis un widget — passer par un provider
- Aucune donnée financière dans les logs, y compris les breadcrumbs Sentry
- Les services retournent un `Result<T>`
- Mention légale systématique sur toute simulation affichée
- Pas de `dynamic` — utiliser `Object?` si le type est incertain

---

## Structure du Projet & Frontières Architecturales

### Arborescence complète

```
sira/
├── pubspec.yaml
├── analysis_options.yaml       ← Lints stricts
├── env.example.json            ← Modèle de configuration
├── .github/workflows/ci.yml    ← Analyse + tests + build
│
├── lib/
│   ├── main.dart               ← Initialisations, ProviderScope
│   ├── app.dart                ← MaterialApp.router
│   │
│   ├── core/
│   │   ├── theme/              ← app_colors, app_typography, app_spacing,
│   │   │                         app_motion, app_theme
│   │   ├── router/app_router.dart
│   │   ├── config/env.dart
│   │   ├── constants/          ← uemoa_rates, expense_categories, plans
│   │   └── utils/              ← currency, dates, validators
│   │
│   ├── data/
│   │   ├── models/             ← user_profile, transaction, debt,
│   │   │                         savings_goal, simulation, subscription
│   │   ├── services/           ← Accès Supabase, un fichier par domaine
│   │   │   ├── supabase_client.dart
│   │   │   ├── auth_service.dart
│   │   │   ├── transactions_service.dart
│   │   │   ├── debts_service.dart
│   │   │   ├── goals_service.dart
│   │   │   ├── subscriptions_service.dart
│   │   │   └── uemoa_rates_service.dart      ← FR50
│   │   └── local/
│   │       ├── app_database.dart             ← drift
│   │       └── mutation_queue.dart           ← File hors ligne
│   │
│   ├── features/
│   │   ├── auth/               ← FR01-07  (01.1, 01.2, connexion)
│   │   ├── onboarding/         ← FR08-11  (01.3, 01.4, 01.5)
│   │   ├── dashboard/          ← FR18     (01.6)
│   │   ├── transactions/       ← FR12-17  (02.1, 02.2, 02.3)
│   │   ├── simulation/         ← FR19-25  (03.1, 03.2)
│   │   │   ├── domain/         ← Moteur pur, sans dépendance externe
│   │   │   │   ├── compound_interest.dart
│   │   │   │   ├── debt_avalanche.dart
│   │   │   │   ├── debt_snowball.dart
│   │   │   │   ├── goal_projection.dart
│   │   │   │   └── inflation_adjuster.dart
│   │   │   ├── presentation/
│   │   │   └── providers/
│   │   ├── debts/              ← FR26-31  (04.1, 04.2, 04.3)
│   │   ├── goals/              ← FR32-36  (05.1, 05.2, 05.3)
│   │   ├── assistant/          ← (06.1)
│   │   ├── investments/        ← (07.1, 07.2)
│   │   ├── entrepreneur/       ← (08.1)
│   │   ├── profile/            ← FR06-07  (09.1, 09.2)
│   │   ├── subscription/       ← FR37-42  (09.3)
│   │   ├── notifications/      ← FR43-46
│   │   └── admin/              ← FR47-49
│   │
│   └── shared/
│       └── widgets/            ← Design System
│           ├── primary_button.dart
│           ├── secondary_button.dart
│           ├── text_link.dart
│           ├── app_input.dart
│           ├── page_header.dart
│           ├── selection_chips.dart
│           ├── app_card.dart
│           ├── empty_state.dart
│           ├── app_toast.dart
│           ├── pressable_scale.dart
│           └── widgets.dart     ← Export groupé
│
├── test/
│   ├── unit/
│   │   ├── simulation/          ← Tests critiques — cas réels UEMOA
│   │   └── utils/
│   └── widget/
│
├── assets/images/
│
└── supabase/                    ← Inchangé — indépendant du framework
    ├── migrations/
    ├── seeds/
    └── functions/
        ├── wave-webhook/
        ├── momo-webhook/
        └── brvm-sync/
```

Les dossiers `android/`, `ios/` et `web/` sont générés par `flutter create .`
et ne sont pas versionnés tant qu'aucune configuration native ne le justifie.


### Frontières architecturales

**Frontière Auth :**
Supabase Auth → `authProvider` (Riverpod) → `redirect` de go_router → les routes authentifiées et d'onboarding sont protégées automatiquement.

**Frontière Paiement :**
Wave/MoMo → Edge Function (vérification signature + idempotence) → table `subscriptions` → `subscriptionProvider` → drapeaux de fonctionnalité → conditionnement dans les widgets.

**Frontière Simulation :**
`/services/simulation-engine/` = îlot isolé. Fonctions pures sans effets de bord. Aucun appel réseau, aucun store. Appelé uniquement via `useSimulation.ts`.

**Frontière BRVM :**
API BRVM externe → Edge Function cron quotidien → table `uemoa_rates` → `uemoa-rates.ts` service → hooks simulation.

**Frontière Offline :**
Mutations → file locale drift → synchronisation automatique à la reconnexion → Supabase.

### Flux de données principal

```
User action
  → Screen (app/)
  → Custom Hook (hooks/)
  → Service (services/)
  → Supabase SDK
  → PostgreSQL (RLS actif — user_id vérifié automatiquement)

Mode offline :
  → Mutation mise en file
  → drift (SQLite local)
  → Sync auto à la reconnexion
```

---

## Validation Architecturale

### Cohérence des décisions ✅

Les technologies retenues sont compatibles entre elles : Flutter, go_router, Riverpod, supabase_flutter, drift et sentry_flutter forment une stack cohérente. Riverpod couvre à la fois l'état applicatif et l'état serveur, ce qui supprime la frontière Zustand / TanStack Query de la stack précédente. Le moteur de simulation, écrit en Dart pur, s'intègre naturellement à l'approche hors ligne.

### Couverture des exigences ✅

**57/57 FRs couverts.** Tous les NFRs critiques adressés architecturalement :
- Simulation ≤500ms → calcul 100% local (`simulation-engine/`)
- Lecture et saisie hors ligne → drift + file de mutations
- Sécurité → `flutter_secure_storage` (Keystore / Keychain) + chiffrement Supabase + RLS
- Webhooks idempotents → Edge Function avec vérification `webhook_id`
- Multi-user préparé → RLS par `auth.uid()` dès le MVP

### Gaps identifiés et résolus

**Gap 1 — Stockage des sessions (mineur) :**
`supabase_flutter` persiste la session via `SharedPreferences` par défaut, ce qui
ne convient pas à un jeton d'authentification. Fournir un `LocalStorage`
personnalisé adossé à `flutter_secure_storage` (Keystore / Keychain).

**Gap 2 — Pas de génération de types automatique (mineur) :**
Le SDK Dart ne dispose pas d'équivalent à `supabase gen types typescript`. Les
modèles de `data/models/` sont écrits à la main et doivent être revus à chaque
migration. Une vérification est ajoutée à la checklist de migration.

**Gap 3 — FR24, simulation sans inscription (mineur) :**
Route `/simulateur-decouverte` hors des routes authentifiées — état local
uniquement, aucune sauvegarde. Redirige vers l'inscription à l'issue du calcul.

**Gap 4 — Notifications push (nouveau) :**
Sans Expo, il faut passer par Firebase Cloud Messaging et APNs, ce qui implique
un projet Firebase et la configuration native associée. Cette mise en place est
à intégrer à l'Epic 6.

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
- Gestion d'état → Riverpod
- Build & distribution → GitHub Actions + Fastlane

**Décisions importantes (structurent l'architecture) :**
- API → Supabase JS SDK + Edge Functions
- Monitoring → Sentry
- CI/CD → GitHub Actions (analyse, tests, build signé)

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
- Cache Riverpod — données serveur en mémoire, adossées à drift

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
- At-rest : Keystore / Keychain pour les jetons, chiffrement Supabase côté serveur
- In-transit : TLS 1.3 (Supabase par défaut)
- RLS : politique par table, `auth.uid()` obligatoire
- Logs : zéro donnée financière — `console.log` bannis sur les objets sensibles

---

### API & Communication

**Lecture/écriture :** SDK `supabase_flutter` appelé depuis la couche `data/services/` — pas d'API REST maison à maintenir.

**Webhooks Wave/MoMo :** Supabase Edge Functions (Deno/TypeScript)
- Réception + vérification signature
- Idempotence : vérification `webhook_id` avant activation Premium
- Retry automatique côté opérateur

**Données BRVM :** Edge Function cron (quotidien) → stockage en DB → servi depuis cache.

**Notifications push :** Firebase Cloud Messaging (Android) et APNs (iOS) via `firebase_messaging`, déclenchées depuis les Edge Functions.

**Gestion des erreurs :**
- Toute intégration externe (Wave, MoMo, BRVM) derrière une interface Dart
- Dégradation gracieuse : si API indisponible → feature non bloquante + message clair
- Timeout Wave/MoMo : 30s max, état "en attente" avec retry

---

### Architecture Frontend

| Aspect | Décision | Détail |
|--------|----------|--------|
| Navigation | `go_router` | Routes déclarées dans `core/router/` |
| État | `flutter_riverpod` | Session, abonnement, données serveur, préférences |
| Style | `ThemeData` + tokens Dart | `core/theme/` — miroir du Design System |
| Formulaires | `Form` + validateurs | Intégrés au framework, pas de dépendance |
| Stockage local | `flutter_secure_storage` (jetons) + `drift` (données) | |
| Moteur de simulation | Dart pur | Local, hors ligne, testable unitairement |

**Séparation des responsabilités :**
- Logique métier → providers Riverpod et `features/<domaine>/domain/`
- Widgets → présentation seule, aucune logique métier
- Services → accès Supabase isolé dans `data/services/`

---

### Infrastructure & Déploiement

| Aspect | Solution | Détail |
|--------|----------|--------|
| Build Android | GitHub Actions | `flutter build appbundle`, signature via secrets |
| Build iOS | Runner macOS GitHub Actions | Nécessaire faute de Mac local |
| Distribution | Fastlane | Google Play et App Store |
| Correctifs | Publication store | Pas d'équivalent OTA — à intégrer au rythme de release |
| Monitoring | `sentry_flutter` | Crash, performance, traces |
| Variables d'env | `--dart-define-from-file` + secrets CI | Jamais de secret dans le dépôt |

**Environnements :**
- `development` — Supabase local (CLI)
- `preview` — Supabase staging cloud
- `production` — Supabase production

### Analyse d'impact des décisions

**Séquence d'implémentation imposée par ces décisions :**
1. Init projet Flutter + configuration Supabase
2. Schéma DB + migrations + RLS policies
3. Supabase Auth + session management
4. Simulation engine (calculs locaux, testés unitairement)
5. Features métier (dépenses → dettes → objectifs)
6. Edge Functions (webhooks paiement)
7. Notifications push
8. Build signé + Sentry + CI/CD

**Dépendances croisées :**
- Toutes les features métier dépendent du schéma DB (décision 1)
- Le gating Premium dépend des webhooks (Edge Functions)
- Le hors-ligne dépend de drift et de la file de mutations, à poser avant les features
