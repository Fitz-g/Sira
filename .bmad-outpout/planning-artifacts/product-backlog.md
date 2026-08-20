# Product Backlog — Idées à analyser

> Idées de features capturées en cours de route, à analyser et prioriser plus tard.
> Ne pas implémenter sans passage par une analyse (valeur utilisateur, effort, positionnement).

**Dernière mise à jour :** 2026-08-20

---

## IDEA-01 — Décomposition et compréhension du salaire

**Capturé le :** 2026-08-20
**Statut :** À analyser
**Persona cible :** L'Actif en Progression (Kofi), Le Professionnel Débordé (Serge)

### Le besoin

Les salariés reçoivent leur bulletin de paie sans comprendre comment on arrive au net. Où part l'argent entre le brut et ce qui atterrit sur le compte ? Impôts, cotisations sociales, retenues — c'est opaque.

### Ce que ça pourrait être

Un module qui décompose le salaire et l'explique :

- Saisie du salaire brut → décomposition automatique (brut → cotisations → imposable → impôt → net)
- Visualisation de la répartition (graphique en cascade ou camembert)
- Explication pédagogique de chaque ligne : « L'ITS, c'est l'Impôt sur Traitements et Salaires. Il finance… »
- Simulation : « Si mon brut augmente de X, mon net augmente de combien ? »
- Comparaison avant/après une augmentation ou un changement de situation familiale

### Pourquoi ça colle au positionnement

- **Pédagogie honnête** — c'est exactement le rôle de mentor financier de l'app
- **UEMOA-first** — les barèmes fiscaux sont locaux (ITS, CNPS, IUTS selon les pays), aucune app occidentale ne fait ça
- **Neutralité** — on explique, on ne vend rien
- **Alimente les autres modules** — le net calculé devient l'input du budget et des simulations

### Questions ouvertes à trancher

| Question | Enjeu |
|----------|-------|
| Quels pays couvrir en premier ? | Les barèmes diffèrent : Côte d'Ivoire, Sénégal, Burkina, Mali, Bénin, Togo, Niger, Guinée-Bissau |
| Où trouver les barèmes officiels et fiables ? | Risque de donner une info fausse sur un sujet fiscal |
| À quelle fréquence les barèmes changent-ils ? | Coût de maintenance annuel |
| Gratuit ou Premium ? | Fort argument d'acquisition si gratuit, bon argument de conversion si Premium |
| Quelle responsabilité légale ? | Disclaimer obligatoire — « estimation indicative, pas un document officiel » |

### Impact sur l'existant

- Nouveau domaine fonctionnel (ni dans les 57 FRs, ni dans les 8 epics actuels)
- Nécessiterait des barèmes fiscaux configurables — même logique que `constants/uemoa-rates.ts`
- Probablement 1 à 2 nouvelles vues (saisie + résultat détaillé)
- Le net calculé pourrait pré-remplir le champ « revenus » de l'onboarding

### Prochaine étape

Analyse complète après le MVP — pas avant d'avoir validé le cœur du produit avec de vrais utilisateurs.

---
