# Design Log — App Finance UEMOA

---

## Backlog

- [ ] Scénario 01 — Kofi Découvre et Configure son Tableau de Bord (6 vues)
- [ ] Scénario 02 — Kofi Suit ses Dépenses et Pilote son Budget (3 vues)
- [ ] Scénario 03 — Amina Lance sa Première Simulation (2 vues)
- [ ] Scénario 04 — Serge Cartographie ses Dettes et Crée son Plan (3 vues)
- [ ] Scénario 05 — Kofi Crée et Suit son Premier Objectif d'Épargne (3 vues)
- [ ] Scénario 06 — Kofi Consulte son Assistant Financier (1 vue)
- [ ] Scénario 07 — Kofi Suit ses Investissements BRVM (2 vues)
- [ ] Scénario 08 — Moussa Configure son Espace Entrepreneur (1 vue)
- [ ] Scénario 09 — Serge Gère son Compte et Souscrit (3 vues)

---

## Current

_(vide — prêt à démarrer)_

---

## Design Loop Status

| Scénario | Vue | Statut | Date |
|----------|-----|--------|------|
| 01 — Kofi Dashboard | 01.1 Splash / Welcome | spécifié | 2026-04-04 |
| 01 — Kofi Dashboard | 01.2 Inscription | spécifié | 2026-04-06 |
| 01 — Kofi Dashboard | 01.3 Onboarding E1 — Profil | spécifié | 2026-04-06 |
| 01 — Kofi Dashboard | 01.4 Onboarding E2 — Situation | spécifié | 2026-04-06 |
| 01 — Kofi Dashboard | 01.5 Onboarding E3 — Objectif | spécifié | 2026-04-06 |
| 01 — Kofi Dashboard | 01.6 Dashboard / Accueil | spécifié | 2026-04-06 |
| 02 — Dépenses Budget | 02.1 Saisie Dépense | spécifié | 2026-04-06 |
| 02 — Dépenses Budget | 02.2 Liste Dépenses | spécifié | 2026-04-06 |
| 02 — Dépenses Budget | 02.3 Budget Mensuel | spécifié | 2026-04-06 |
| 03 — Amina Simulation | 03.1 Simulateur | spécifié | 2026-04-06 |
| 03 — Amina Simulation | 03.2 Résultat Simulation | spécifié | 2026-04-06 |
| 04 — Serge Dettes | 04.1 Liste Dettes | spécifié | 2026-04-06 |
| 04 — Serge Dettes | 04.2 Ajouter Dette | spécifié | 2026-04-06 |
| 04 — Serge Dettes | 04.3 Plan Remboursement | spécifié | 2026-04-06 |
| 05 — Kofi Objectifs | 05.1 Liste Objectifs | spécifié | 2026-04-06 |
| 05 — Kofi Objectifs | 05.2 Créer Objectif | spécifié | 2026-04-06 |
| 05 — Kofi Objectifs | 05.3 Détail Objectif | spécifié | 2026-04-06 |
| 06 — Kofi Assistant | 06.1 Assistant Financier | spécifié | 2026-04-06 |
| 07 — Kofi Investissements | 07.1 Liste Investissements | spécifié | 2026-04-06 |
| 07 — Kofi Investissements | 07.2 Détail Investissement | spécifié | 2026-04-06 |
| 08 — Moussa Entrepreneur | 08.1 Espace Entrepreneur | spécifié | 2026-04-06 |
| 09 — Serge Compte | 09.1 Profil Utilisateur | spécifié | 2026-04-06 |
| 09 — Serge Compte | 09.2 Paramètres & Intégrations | spécifié | 2026-04-06 |
| 09 — Serge Compte | 09.3 Abonnement | spécifié | 2026-04-06 |

---

## Log

| Date | Action |
|------|--------|
| 2026-04-04 | Phase 1 Product Brief complété |
| 2026-04-04 | Phase 2 Trigger Map complété — 4 personas, 9 forces prioritaires |
| 2026-04-04 | Phase 3 UX Scenarios complété — 9 scénarios, 25 vues |
| 2026-04-04 | Phase 4 UX Design initialisé |
| 2026-05-01 | Design System [M] — Tokens extraits : typography (9), spacing (5), colors (14 rôles), interactions (6 patterns). 19 composants partagés identifiés, à extraire. |
| 2026-05-03 | Design System [M] — Composants Tier 1 extraits : PageHeader (3 variantes), PrimaryButton (4 états), Card (5 variantes : metric, info, preview, list-item, recap). |
| 2026-05-03 | Design System [M] — Composants Tier 2 extraits : Input (4 variantes), SecondaryButton + TextLink, SelectionChips (2 layouts), EmptyState, Toast. Design System fondation complète — prêt pour le coding. |
| 2026-08-20 | Bascule React Native → Flutter. Design System, specs et FRs conservés ; architecture technique, tokens et composants réécrits en Dart. Écran 01.1 Welcome implémenté. |
| 2026-08-20 | Moteur de simulation et écrans 03.1 / 03.2 implémentés. Correction spec 01.6 : ajout du bouton « Simuler » aux actions rapides — le scénario 03 le supposait, la spec de l'écran ne le portait pas, le simulateur était inatteignable. Décision DEC-01 ouverte : l'entrée du FR24 (simulation sans compte) n'a jamais été dessinée. |
