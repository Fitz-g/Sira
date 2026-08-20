---
stepsCompleted: ['step-01-init', 'step-02-discovery', 'step-02b-vision', 'step-02c-executive-summary', 'step-03-success', 'step-04-journeys', 'step-05-domain', 'step-06-innovation', 'step-07-project-type', 'step-08-scoping', 'step-09-functional', 'step-10-nonfunctional', 'step-11-polish', 'step-12-complete']
workflowStatus: complete
completedAt: '2026-04-15'
inputDocuments:
  - '.bmad-outpout/A-Product-Brief/project-brief.md'
  - '.bmad-outpout/B-Trigger-Map/trigger-map.md'
  - '.bmad-outpout/C-UX-Scenarios/00-ux-scenarios.md'
briefCount: 1
researchCount: 0
brainstormingCount: 0
projectDocsCount: 0
workflowType: 'prd'
classification:
  projectType: mobile_app
  domain: fintech
  complexity: high
  projectContext: greenfield
---

# Product Requirements Document — App Finance UEMOA

**Auteur :** Fitz · **Date :** 2026-04-06 · **Stack :** React Native + Expo (TypeScript strict) · **Domaine :** Fintech, complexité haute, greenfield

---

## Résumé Exécutif

Application de planification et simulation financière personnelle pour la zone UEMOA — première solution ancrée dans les réalités africaines (BRVM, taux UEMOA, Wave/Orange Money/MoMo). Cible : l'actif, l'étudiant, l'entrepreneur informel — non-expert, prêt à structurer ses finances et à se projeter dans l'avenir.

Né d'un besoin personnel documenté : remplacer les requêtes ponctuelles à l'IA, les tableurs ad hoc et l'improvisation financière par un outil intégré, cohérent, à mémoire de contexte. Couvre l'intégralité du spectre — suivi des dépenses, gestion des dettes, objectifs d'épargne, simulation d'investissement — dans un seul produit, guidé, pédagogique et neutre.

Modèle B2C, abonnement individuel. Lean bootstrap : Fitz est le premier testeur et le premier cas d'usage validé. Android priorité, iOS et Web secondaires.

### Ce Qui Le Rend Unique

Le gap n'est pas le suivi des dépenses — c'est la **projection financière accessible**. Wave gère les transactions. Mint/YNAB ignorent la BRVM. Les banques ont un conflit d'intérêt structurel. ChatGPT répond ponctuellement sans contexte persistant.

Ce produit est la première plateforme à combiner :

1. **Moteur de simulation quantitatif** — ROI, inflation, rendements, accessible aux non-experts
2. **UEMOA-first** — données BRVM réelles, taux locaux, instruments africains
3. **Neutralité absolue** — aucun produit financier à vendre, aucun conflit d'intérêt
4. **Intégrations multi-portefeuilles** — Wave + MoMo + Flooz dans un seul tableau de bord
5. **IA financière contextuelle** — mémoire des habitudes, stratégies personnalisées sans tout réexpliquer

Avantage compétitif central : neutralité + profondeur de simulation dans un marché structurellement sous-servi. Ces deux propriétés ne peuvent pas être copiées par les acteurs existants dont le modèle business dépend du volume de transactions.

---

## Critères de Succès

### Succès Utilisateur

| Métrique | Cible | Horizon |
|----------|-------|---------|
| Simulation lancée | ≥50% des inscrits ont lancé ≥1 simulation de projection | J+90 |
| Engagement multi-features | ≥40% des utilisateurs actifs ont utilisé ≥3 modules distincts | J+90 |
| Moment "aha!" | Premier objectif ou simulation créé < 10 min après inscription | J+1 |
| Rétention | ≥35% d'utilisateurs actifs à J+30, ≥20% à J+90 | J+90 |
| NPS in-app | Score ≥40 | J+90 |

**Indicateur principal :** 50% des inscrits lancent ≥1 simulation dans les 3 premiers mois — validation que le différenciateur central est activé.

### Succès Business

| Métrique | Cible | Horizon |
|----------|-------|---------|
| Conversion freemium → Premium | ≥8% des utilisateurs actifs à J+30 | 6 mois |
| Viralité | ≥1 invitation envoyée par utilisateur actif | 3 mois |
| MRR | Premier revenu récurrent validé | 6 mois |
| Validation dogfooding | Fitz utilise l'app quotidiennement ≥30 jours consécutifs | Avant lancement |

### Succès Technique

| Métrique | Cible |
|----------|-------|
| Performance simulation | Résultat affiché ≤ 2s sur réseau 3G |
| Disponibilité | ≥99% uptime mensuel |
| Sécurité données | Chiffrement at-rest + in-transit, zéro exposition de données financières |
| Crash rate | < 0.5% des sessions Android |
| Taille app | ≤ 30MB |

### Horizons

- **Court terme (3 mois) :** Dogfooding validé. ≥1 ami testeur régulier. Premier abonné payant.
- **Moyen terme (12–24 mois) :** Croissance organique. MRR stable. Module BRVM actif.
- **Long terme (5 ans) :** Référence finance perso UEMOA. Expansion Afrique francophone.

---

## Scoping & Développement Phasé

### Philosophie MVP

**Objectif :** Valider une hypothèse centrale — un non-expert UEMOA peut lancer une simulation financière en moins de 10 minutes, sans aide. Tout le reste est secondaire.

**Ressources :** Solo dev (Fitz + Claude Code). Architecture maintenable seul à long terme.

**Critère de lancement :** Fitz utilise l'app quotidiennement 30 jours sans tableur. ≥2 amis non-experts ont complété une simulation sans aide.

### Phase 1 — MVP

**Parcours couverts :** Kofi (onboarding + dashboard + dépenses), Amina (simulation), Serge (dettes).

| Feature | Valeur core | Dépendances |
|---------|-------------|-------------|
| Onboarding 4 étapes | Activation < 5 min | Auth |
| Tableau de bord santé financière | Ancrage quotidien | Dépenses, dettes, objectifs |
| Saisie dépenses + budget mensuel | Prise de conscience immédiate | — |
| Gestion dettes + plan remboursement | Moment émotionnel fort | — |
| Objectifs d'épargne + progression | Motivation long terme | — |
| **Simulateur financier** | **Différenciateur central — priorité absolue** | Taux UEMOA manuels |
| Compte + abonnement Gratuit/Premium | Monétisation dès le départ | Wave paiement |
| Auth sécurisée | Non-négociable | — |
| Paiement Wave + Orange Money | Conversion Premium | Intégration externe |

**Exclusions délibérées :** Import auto Wave/MoMo · Données BRVM temps réel · Export rapports · Multi-utilisateurs (architecture préparée, feature désactivée)

### Phase 2 — Growth

Déclencheur : dogfooding validé + premier abonné payant.

- Intégration Wave/MoMo import transactions automatique
- Données BRVM temps réel
- Assistant IA contextuel avancé (mémoire longue)
- Notifications push intelligentes
- Finances familiales multi-utilisateurs
- Export CSV / PDF

### Phase 3 — Vision

Déclencheur : MRR stable + 500+ utilisateurs actifs.

- Espace entrepreneur (séparation finances perso / business)
- Expansion géographique Afrique francophone
- Paiements depuis l'application
- Partenariats SGI/banques UEMOA (B2B optionnel)

### Mitigation des Risques Scoping

| Type | Risque | Mitigation |
|------|--------|------------|
| **Technique** | Moteur simulation — calculs incorrects = perte de confiance totale | Tests unitaires exhaustifs, validation avec cas réels UEMOA avant lancement |
| **Technique** | Intégration Wave instable | Fallback saisie manuelle toujours disponible, Wave non-bloquant pour les features core |
| **Marché** | Adoption faible | Dogfooding rigoureux, lancement bouche-à-oreille avant tout marketing |
| **Ressource** | Solo dev — feature creep | Scope verrouillé jusqu'au lancement MVP. Toute nouvelle idée → backlog Phase 2 |

---

## Parcours Utilisateur

### Parcours 1 — Kofi, L'Actif en Progression *(Chemin principal)*

**Situation :** Kofi, 31 ans, commercial à Abidjan. Revenu correct, mais ne sait jamais où part son argent. Un ami lui envoie un lien WhatsApp : "Essaie ça, c'est vraiment fait pour nous."

**Découverte :** Il ouvre l'app avec méfiance. La splash page répond en 3 secondes : "Ton argent, maîtrisé." Une illustration locale. Un seul bouton. Il tape "C'est parti".

**Onboarding :** Formulaire court — prénom, situation, un objectif. En 4 minutes, le tableau de bord est prêt avec une jauge de santé financière, ses catégories de dépenses, son premier objectif.

**Moment clé :** Il saisit 3 dépenses. Le tableau recalcule en temps réel. "40% de mon budget part en transports et sorties." Il crée un budget mensuel. L'app : "À ce rythme, tu atteins ton objectif en 8 mois — pas mal !"

**Résolution :** Kofi revient chaque matin. À J+30, il a économisé 25 000 FCFA de plus. Il envoie le lien à deux collègues.

**Exigences révélées :** Onboarding < 5 min · tableau de bord temps réel · saisie rapide · feedback pédagogique.

---

### Parcours 2 — Amina, La Simulatrice *(Différenciateur central)*

**Situation :** Amina, 26 ans, chargée de projet à Dakar. 500 000 FCFA d'économies. Question : "Si j'investis 200 000 FCFA en bons BRVM à 6%, combien j'aurai dans 3 ans ?"

**Découverte :** Cherche "calculateur investissement BRVM Sénégal". L'app lui offre un aperçu de simulation sans compte. Elle s'inscrit.

**Simulation :** 200 000 FCFA, 6% annuel, 3 ans, apport mensuel 20 000 FCFA. Projection visuelle avec courbe d'évolution, montant final, comparatif inflation UEMOA.

**Moment clé :** Elle modifie les paramètres en temps réel, joue 20 minutes, enregistre 3 scénarios. Elle souscrit au Premium le soir même pour débloquer la comparaison de scénarios.

**Résolution :** Amina utilise l'app comme son "conseiller financier personnel". Elle partage ses projections sur Instagram.

**Exigences révélées :** Simulateur multi-paramètres · recalcul instantané · données BRVM · comparaison scénarios · aperçu sans inscription.

---

### Parcours 3 — Serge, Le Professionnel Débordé *(Gestion de crise)*

**Situation :** Serge, 38 ans, ingénieur à Lomé. Salaire confortable — 3 crédits en cours, obligations familiales, fin de mois sous tension depuis 2 ans. Il ouvre l'app à 23h un dimanche, seul, après une alerte de prélèvement.

**Onboarding :** L'app pose les bonnes questions sans jugement. Il entre ses 3 dettes, revenus, charges fixes. Diagnostic : "Tu consacres 58% de tes revenus au remboursement — voici un plan pour t'en sortir en 18 mois."

**Moment clé :** Plan de remboursement dette par dette, méthode avalanche automatique. Serge voit : "Décembre 2027, toutes dettes soldées."

**Résolution :** À 6 mois, première dette soldée. Il souscrit au Premium sans hésiter.

**Exigences révélées :** Diagnostic non-jugeant · gestion multi-dettes · plan automatisé (avalanche/boule de neige) · date de libération financière.

---

### Parcours 4 — Moussa, L'Entrepreneur Informel *(Utilisateur secondaire)*

**Situation :** Moussa, 34 ans, gérant de boutique à Cotonou. Mélange finances perso et business depuis des années.

**Usage :** Deux espaces : "Perso" et "Boutique Moussa". Pour la première fois, il voit que sa boutique est rentable — mais qu'il pioche trop dans la caisse pour du perso. Il se fixe un "salaire" de gérant de 80 000 FCFA/mois.

**Résolution :** Finances définitivement séparées. Premier mois d'épargne personnelle.

**Exigences révélées :** Espaces multiples · catégorisation flexible · vue consolidée et vue séparée.

---

### Parcours 5 — Admin Opérationnel *(Monitoring plateforme)*

**Usage :** Dashboard admin — inscriptions, conversions, erreurs APIs Wave/MoMo, alertes performance. Gestion des abonnements (remboursements, annulations). Monitoring intégrations BRVM.

**Exigences révélées :** Dashboard analytics · gestion abonnements · monitoring APIs tierces · alertes automatiques.

---

### Synthèse des Exigences par Parcours

| Capacité | Kofi | Amina | Serge | Moussa | Admin |
|----------|------|-------|-------|--------|-------|
| Onboarding guidé < 5 min | ✓ | ✓ | ✓ | | |
| Tableau de bord santé financière | ✓ | | ✓ | ✓ | |
| Saisie & catégorisation dépenses | ✓ | | ✓ | ✓ | |
| Budget mensuel par enveloppe | ✓ | | | | |
| Simulateur multi-paramètres | | ✓ | | | |
| Gestion multi-dettes + plan auto | | | ✓ | | |
| Espaces multiples perso/business | | | | ✓ | |
| Paiement Wave/MoMo (abonnement) | | ✓ | ✓ | | |
| Dashboard admin + monitoring | | | | | ✓ |

---

## Ton de Voix & Principes UX

### Attributs du Ton

| Attribut | Description |
|----------|-------------|
| **Chaleureux & encourageant** | Rassurer, jamais intimider |
| **Pédagogique sans condescendance** | Expliquer simplement, sans faire sentir l'ignorance |
| **Direct & concret** | Pas de jargon non expliqué, des actions claires |
| **Motivant** | Célébrer les petits progrès, encourager l'étape suivante |
| **Local & humain** | Proche, pas institutionnel |

**Règle fondamentale :** Tutoiement systématique. Phrases courtes et actives.

### Microcopy de Référence

| Contexte | ❌ À éviter | ✅ Ton validé |
|----------|------------|--------------|
| Bouton démarrer | `Soumettre` | `C'est parti →` |
| Erreur saisie | `Montant invalide` | `Hmm, vérifie ce montant` |
| Chargement | `Chargement...` | `On calcule tout ça...` |
| Objectif créé | `Objectif enregistré` | `Bel objectif ! On le suit ensemble.` |
| État vide | `Aucune dépense` | `Pas encore de dépenses ce mois — beau début !` |
| Simulation lancée | `Traitement en cours` | `On projette ton avenir... 🔢` |
| Disclaimer simulation | *(absent)* | `Ces projections sont indicatives — pas un conseil financier.` |

### Principes UX Non-Négociables

- **Neutralité visible** — Jamais de recommandation de produit financier tiers. Jamais de contenu sponsorisé.
- **États vides pédagogiques** — Chaque section vide guide vers la prochaine action utile.
- **Onboarding progressif** — L'utilisateur peut utiliser l'app avant d'avoir tout rempli.
- **Zéro jugement** — Le diagnostic financier rassure, il ne condamne jamais.
- **Disclaimers systématiques** — Toute simulation affiche "indicatif — pas un conseil financier."

---

## Exigences Domaine

### Compliance & Réglementaire

**Positionnement juridique :** L'app est un agrégateur et simulateur — elle n'émet pas de monnaie électronique, ne détient pas de fonds, ne traite pas de paiements directement. Ce positionnement réduit significativement la charge réglementaire BCEAO.

| Exigence | Détail | Priorité |
|----------|--------|----------|
| Pas de licence émetteur | Paiements abonnements via Wave/MoMo (agréés BCEAO) — l'app ne tient pas les fonds | Non-bloquant MVP |
| Protection données personnelles | Lois nationales UEMOA (Sénégal Loi 2008-12, etc.) — consentement explicite, droit à l'effacement | MVP |
| KYC minimal | Pas de KYC complet requis — email + prénom suffisent | MVP |
| CGU & Confidentialité | Usage des données financières, non-responsabilité sur les projections | MVP |
| Disclaimers légaux | "Les simulations sont indicatives et ne constituent pas un conseil financier" — obligatoire sur toutes les projections | MVP |

### Contraintes Techniques de Sécurité

| Contrainte | Exigence |
|------------|----------|
| Chiffrement | AES-256 at-rest, TLS 1.3 in-transit |
| Authentification | JWT + refresh tokens, biométrie optionnelle |
| Logs d'audit | Actions critiques loguées (modifications données, changements abonnement) |
| Isolation données | Données strictement isolées par user_id côté serveur |
| Credentials tiers | Jamais stockés — OAuth ou deep link uniquement |
| Timeout sessions | Session inactive > 15 min → déconnexion automatique |

### Exigences d'Intégration

| Système | Type | Contraintes |
|---------|------|-------------|
| Wave API | Paiement abonnement | OAuth 2.0, webhooks confirmation, sandbox disponible |
| Orange Money / MTN MoMo | Paiement abonnement | APIs GSMA MoMo standard, vérification numéro requis |
| BRVM | Données marchés | API publique — données J-1 acceptable au MVP |
| Auth + DB | Infrastructure | Cloud RGPD-compliant (Firebase/Supabase) |
| Expo Push | Notifications | Consentement utilisateur requis avant activation |

### Risques Domaine & Mitigations

| Risque | Impact | Mitigation |
|--------|--------|------------|
| Indisponibilité API Wave/MoMo | Blocage souscription Premium | Mode dégradé + retry automatique, accès conservé jusqu'à résolution |
| Données BRVM indisponibles | Simulateur partiellement non fonctionnel | Cache + indicateur "données du JJ/MM" |
| Fuite de données financières | Perte de confiance totale | Chiffrement, audit logs, zéro données financières dans les logs |
| Projections perçues comme garanties | Risque légal | Disclaimers systématiques, ton pédagogique |
| Fraude abonnement | Perte de revenu | Vérification numéro avant activation, délai 5 min |

---

## Innovation & Patterns Nouveaux

### Zones d'Innovation

**1. Repositionnement de la simulation financière**
La simulation quantitative (ROI, inflation, projections) est historiquement réservée aux experts. Ce produit la rend accessible à un salarié ordinaire de Dakar, avec des paramètres contextualisés UEMOA. Changement de paradigme.

**2. Agrégation multi-portefeuilles africains**
Aucun acteur ne regroupe Wave + Orange Money + MTN MoMo + Flooz dans un tableau unifié. Conflits d'intérêt commercial empêchent les acteurs en place de le faire.

**3. IA financière à contexte persistant**
ChatGPT répond ponctuellement mais repart de zéro à chaque session. L'app maintient un contexte financier long — habitudes, objectifs, dettes, historique.

**4. Neutralité structurelle comme avantage produit**
Aucun produit financier à vendre. Contrainte d'architecture, pas de positionnement marketing.

### Paysage Concurrentiel

| Innovation | Qui l'a tenté | Pourquoi ça n'existe pas |
|------------|--------------|--------------------------|
| Finance perso UEMOA-first | Personne | Marché perçu comme non-rentable par les acteurs occidentaux |
| Agrégation Wave + MoMo | Personne | Conflits commerciaux entre opérateurs |
| Simulation accessible non-experts | YNAB, Mint (partiel) | Pas adapté UEMOA, pas de données locales |
| IA financière à mémoire | ChatGPT | Pas de contexte persistant |

### Validation des Innovations

| Innovation | Validation MVP | Indicateur |
|------------|---------------|------------|
| Simulation accessible | Fitz + 3 amis testeurs non-experts | ≥2 testeurs font une simulation complète sans aide |
| Agrégation multi-wallets | Wave seul au MVP, MoMo Phase 2 | Taux d'activation Wave ≥ 40% des Premium |
| IA financière | Assistant basique au MVP, mémoire longue Phase 2 | ≥3 questions posées par utilisateur actif en 30 jours |
| Neutralité | Design — pas de "produit recommandé" visible | NPS ≥ 40, mention "confiance" dans les feedbacks |

### Risques d'Innovation

| Risque | Probabilité | Mitigation |
|--------|-------------|------------|
| Données BRVM inexactes | Moyen | Taux manuels configurables au MVP |
| IA conseille mal | Élevé | Ton "suggestion" jamais "prescription", disclaimers |
| Agrégation Wave bloquée | Moyen | Architecture API-agnostique, fallback saisie manuelle |

---

## Exigences Spécifiques Mobile App

### Plateformes Cibles

| Plateforme | Priorité | Cible minimum |
|------------|----------|---------------|
| Android | P1 — MVP | Android 8.0+ (API 26+) — ~90% des appareils actifs UEMOA |
| iOS | P2 — MVP | iOS 14+ |
| Web (PWA) | P3 — Post-MVP | Chrome/Safari/Firefox modernes |

**Contrainte matérielle :** Optimisé pour entrée de gamme (2GB RAM, réseau 3G/4G). APK ≤ 30MB.

### Permissions Devices

| Permission | Usage | Déclencheur |
|------------|-------|-------------|
| Notifications push | Rappels budget, dettes, objectifs | Post-onboarding, après premier objectif créé |
| Biométrie | Déverrouillage app | Paramètres — jamais forcé |
| Caméra | Scan reçus (Phase 2) | Non requis MVP |

**Règle :** Zéro permission au lancement. Chaque demande arrive après que la valeur est évidente.

### Mode Offline

| Fonctionnalité | Offline | Sync |
|---------------|---------|------|
| Lecture tableau de bord | ✓ — données cachées | Au prochain démarrage connecté |
| Saisie dépense | ✓ — file d'attente locale | Automatique à la reconnexion |
| Simulateur | ✓ — calculs locaux | N/A |
| Paiement abonnement | ✗ | N/A |
| Sync BRVM | ✗ | Dernier cache affiché avec horodatage |

### Stratégie Push Notifications

| Déclencheur | Message type |
|-------------|--------------|
| Budget >90% | "Tu approches la limite de ton budget [catégorie]" |
| Objectif atteint | "Bel objectif atteint ! 🎉" |
| Échéance dette | "Rappel : remboursement [dette] dans 3 jours" |
| Inactivité 7 jours | "Ton tableau de bord t'attend — 2 min suffisent" |
| Résumé mensuel | "Ton bilan de [mois] est prêt" |

**Fréquence max :** 1 push/jour. Opt-in granulaire par catégorie.

### Conformité Stores

| Store | Exigence | Action |
|-------|----------|--------|
| Google Play | Données financières | Data Safety Form + politique de confidentialité publique |
| App Store | Guidelines §3.1.2 | Paiement Wave/MoMo externe — évite commission 30% Apple (à confirmer) |
| Les deux | Consentement | Écran de consentement à l'inscription |

### Stack d'Implémentation

- **Navigation :** React Navigation v6+
- **State management :** Zustand ou Redux Toolkit
- **Storage local :** MMKV (chiffré) pour données sensibles, AsyncStorage pour préférences
- **Sync offline :** TanStack Query — file de mutations avec retry
- **OTA :** Expo Updates — correctifs sans validation store

---

## Exigences Fonctionnelles

### 1. Gestion de Compte & Authentification

- **FR01 :** Un visiteur peut créer un compte avec email et mot de passe
- **FR02 :** Un utilisateur peut se connecter avec ses identifiants
- **FR03 :** Un utilisateur peut réinitialiser son mot de passe par email
- **FR04 :** Un utilisateur peut activer le déverrouillage biométrique (Touch ID / Face ID)
- **FR05 :** Le système déconnecte automatiquement un utilisateur après 15 min d'inactivité
- **FR06 :** Un utilisateur peut modifier ses informations de profil (nom, photo, devise)
- **FR07 :** Un utilisateur peut supprimer son compte et toutes ses données associées

### 2. Onboarding & Configuration Initiale

- **FR08 :** Un nouvel utilisateur peut renseigner sa situation financière initiale (revenus, charges fixes)
- **FR09 :** Un nouvel utilisateur peut définir un premier objectif d'épargne pendant l'onboarding
- **FR10 :** Le système génère un tableau de bord initial personnalisé à partir des données d'onboarding
- **FR11 :** Un utilisateur peut passer et compléter l'onboarding ultérieurement
- **FR55 :** Un utilisateur peut compléter son profil financier progressivement après l'onboarding

### 3. Suivi des Dépenses & Budget

- **FR12 :** Un utilisateur peut saisir une dépense avec montant, catégorie, date et note optionnelle
- **FR13 :** Un utilisateur peut modifier ou supprimer une dépense existante
- **FR14 :** Un utilisateur peut consulter la liste de ses dépenses filtrée par période ou catégorie
- **FR15 :** Un utilisateur peut définir un budget mensuel par catégorie de dépenses
- **FR16 :** Le système calcule et affiche l'écart entre dépenses réelles et budget défini
- **FR17 :** Le système alerte l'utilisateur quand une catégorie de budget atteint 90% de son seuil
- **FR18 :** Un utilisateur peut consulter son tableau de bord santé financière (solde, tendances, score)

### 4. Simulation & Projection Financière

- **FR19 :** Un utilisateur peut configurer une simulation avec montant initial, taux de rendement, durée et apport périodique
- **FR20 :** Le système calcule et affiche une projection financière avec courbe d'évolution et montant final
- **FR21 :** Un utilisateur peut modifier les paramètres d'une simulation et voir le résultat recalculé instantanément
- **FR22 :** Le système compare la projection avec l'inflation UEMOA pour afficher le rendement réel
- **FR23 :** Un utilisateur peut sauvegarder un scénario de simulation pour y revenir ultérieurement
- **FR24 :** Un utilisateur non-inscrit peut accéder à 1 simulation complète sans compte (sans sauvegarde ni comparaison de scénarios)
- **FR25 :** Le système propose des taux de référence UEMOA (épargne, bons du Trésor, BRVM) comme valeurs par défaut
- **FR57 :** Un utilisateur peut partager une capture visuelle de sa simulation ou projection

### 5. Gestion des Dettes

- **FR26 :** Un utilisateur peut ajouter une dette avec nom, montant total, taux d'intérêt, mensualité et date d'échéance
- **FR27 :** Un utilisateur peut modifier ou supprimer une dette existante
- **FR28 :** Un utilisateur peut consulter la liste consolidée de ses dettes avec solde restant
- **FR29 :** Le système génère un plan de remboursement automatique selon la méthode avalanche ou boule de neige
- **FR30 :** Le système affiche une date estimée de libération totale des dettes
- **FR31 :** Un utilisateur peut enregistrer un remboursement effectué et voir le solde mis à jour

### 6. Objectifs d'Épargne

- **FR32 :** Un utilisateur peut créer un objectif d'épargne avec nom, montant cible et date d'échéance
- **FR33 :** Un utilisateur peut enregistrer un versement vers un objectif
- **FR34 :** Le système calcule et affiche la progression et le montant mensuel recommandé pour atteindre l'objectif
- **FR35 :** Le système projette si l'objectif sera atteint à la date cible au rythme actuel
- **FR36 :** Un utilisateur peut modifier ou archiver un objectif existant

### 7. Abonnement & Paiement

- **FR37 :** Un utilisateur peut consulter la comparaison des plans Gratuit et Premium
- **FR38 :** Un utilisateur peut souscrire au plan Premium via Wave ou Orange Money
- **FR39 :** Le système active les fonctionnalités Premium après confirmation de paiement
- **FR40 :** Un utilisateur peut basculer entre facturation mensuelle et annuelle
- **FR41 :** Un utilisateur peut consulter l'état de son abonnement et sa date de renouvellement
- **FR42 :** Un utilisateur peut annuler son abonnement Premium à tout moment

### 8. Notifications & Communication

- **FR43 :** Un utilisateur peut activer ou désactiver les notifications par catégorie
- **FR44 :** Le système envoie une notification quand un seuil de budget est atteint
- **FR45 :** Le système envoie une notification de rappel avant une échéance de dette
- **FR46 :** Le système envoie un résumé financier mensuel à l'utilisateur

### 9. Expérience & Pédagogie

- **FR51 :** Le système affiche un contenu d'orientation pédagogique quand une section est vide
- **FR52 :** Le système fournit des explications contextuelles sur les notions financières affichées
- **FR53 :** Le système suggère une action corrective quand le score de santé financière se dégrade
- **FR54 :** Le système n'affiche jamais de recommandations de produits ou services financiers tiers

### 10. Fiabilité & Gestion des Erreurs

- **FR56 :** Le système informe l'utilisateur de l'indisponibilité d'un service externe avec un message clair et une action alternative

### 11. Administration & Monitoring

- **FR47 :** Un administrateur peut consulter les métriques clés de la plateforme (inscriptions, conversions, rétention)
- **FR48 :** Un administrateur peut gérer les abonnements (consultation, remboursement manuel)
- **FR49 :** Le système génère des alertes automatiques en cas d'indisponibilité des APIs tierces
- **FR50 :** Le système expose des taux de référence UEMOA configurables via fichier de configuration

---

## Exigences Non-Fonctionnelles

### Performance

| NFR | Critère mesurable |
|-----|------------------|
| Calcul simulation | Résultat affiché ≤ 2s sur réseau 3G (débit ≥ 1 Mbps) |
| Chargement tableau de bord | Données affichées ≤ 3s au démarrage sur réseau 3G |
| Recalcul instantané | Mise à jour paramètre de simulation ≤ 500ms (calcul local) |
| Taille de l'app | APK/IPA ≤ 30MB |
| Démarrage à froid | App prête ≤ 4s sur Android 8, 2GB RAM |
| Actions critiques | Saisie dépense, création objectif ≤ 1s de feedback visuel |

### Sécurité

| NFR | Critère mesurable |
|-----|------------------|
| Chiffrement at-rest | AES-256 pour toutes les données financières |
| Chiffrement in-transit | TLS 1.3 obligatoire |
| Authentification | JWT + refresh tokens, session expirée après 15 min d'inactivité |
| Credentials tiers | Aucun credential Wave/MoMo stocké — OAuth ou deep link uniquement |
| Logs | Zéro donnée financière dans les logs applicatifs |
| Isolation | Toutes les queries filtrées par user_id vérifié côté serveur |
| Biométrie | Traitement local OS uniquement — jamais transmis |

### Fiabilité

| NFR | Critère mesurable |
|-----|------------------|
| Disponibilité | ≥ 99% uptime mensuel (maintenance planifiée notifiée 24h à l'avance) |
| Offline | App utilisable en lecture et saisie sans connexion |
| Perte de données | Zéro perte lors d'une coupure réseau pendant une saisie |
| Crash rate | < 0.5% des sessions Android, < 0.3% iOS |
| Dégradation | Si API externe indisponible → features core non bloquées, message d'état clair |
| Recovery | Après crash, l'utilisateur retrouve son dernier état sans perte |

### Scalabilité

| NFR | Critère mesurable |
|-----|------------------|
| Charge initiale | ≥ 1 000 utilisateurs actifs simultanés sans dégradation |
| Croissance | Extensible horizontalement — pas de refactoring majeur à 50 000 utilisateurs |
| Données par compte | Aucune dégradation jusqu'à 10 000 transactions |
| Multi-user | Schéma préparé dès le MVP — activation sans migration destructive |

### Accessibilité Pratique

| NFR | Critère mesurable |
|-----|------------------|
| Zones tactiles | Éléments tactiles ≥ 44×44pt |
| Contraste | Ratio ≥ 4.5:1 pour tout texte (WCAG AA) |
| Scaling texte | Support jusqu'à 150% sans casse de layout |
| Réseau dégradé | UX fonctionnelle sur 2G/Edge |

### Intégrations

| NFR | Critère mesurable |
|-----|------------------|
| Wave / Orange Money | Timeout confirmation ≤ 30s — au-delà, état "en attente" avec retry |
| BRVM | Délai J-1 acceptable — fraîcheur affichée ("données du JJ/MM/AAAA") |
| Webhooks | Idempotence garantie — webhook dupliqué ≠ double activation Premium |
| Découplage | Toute intégration externe encapsulée derrière une interface interne |
