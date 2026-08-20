# Dialog Log — Step 10a: Stratégie de Plateforme

## Décision

**Plateforme principale :** Cross-platform — React Native / Expo
**Codebase :** Unique → génère Web + Android + iOS
**Priorité device :** Mobile-first (majorité des utilisateurs sur mobile)

## Rationale

Flutter envisagé initialement, écarté pour :
- Dart = langage à apprendre, courbe d'apprentissage pour un dev solo
- Support web expérimental et limité
- Moins bien supporté par Claude Code (partenaire de dev principal)

React Native / Expo retenu car :
- TypeScript — cohérent avec les règles du projet (CLAUDE.md)
- Web support mature
- Optimal pour duo solo dev + Claude Code
- NPM / écosystème JS immense
- Expo simplifie le build et la publication Play Store / App Store

## Paramètres plateforme

| Paramètre | Valeur |
|-----------|--------|
| Framework | React Native + Expo |
| Langage | TypeScript (strict) |
| Cibles | Android (priorité), iOS, Web |
| Device priority | Mobile-first |
| Interaction principale | Touch |
| Offline | À évaluer (souhaitable pour projection sans connexion) |

## Implications design
- Tous les écrans pensés mobile-first, adaptés web ensuite
- Navigation mobile native (bottom tabs, stack navigation)
- UX pensée pour des sessions courtes et fréquentes (consultation rapide)
