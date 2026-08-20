# Product Backlog — Idées à analyser

> Idées de features capturées en cours de route, à analyser et prioriser plus tard.
> Ne pas implémenter sans passage par une analyse (valeur utilisateur, effort, positionnement).

**Dernière mise à jour :** 2026-08-20

---

## Décisions en attente

### DEC-01 — Par où entre-t-on dans le simulateur sans compte ? (FR24)

**Ouverte le :** 2026-08-20
**Bloque :** rien pour l'instant — le simulateur est joignable depuis le
dashboard une fois l'utilisateur inscrit (correction apportée à la spec 01.6).

**Le FR24 dit :** « Un utilisateur non-inscrit peut accéder à 1 simulation
complète sans compte, sans sauvegarde ni comparaison de scénarios. »

**Ce qui manque :** aucune spécification d'écran ne dit d'où part ce parcours.
L'architecture a prévu une route `/simulateur-decouverte` sans jamais désigner
le lien qui y mène.

**Le seul endroit possible est l'écran d'accueil 01.1**, puisque c'est le seul
écran vu par un visiteur non inscrit. Or cet écran porte un objectif chiffré :
70 % de conversion vers l'inscription. Y ajouter une sortie concurrente n'est
pas un détail d'implémentation.

**À trancher :**

| Question | Enjeu |
|----------|-------|
| Ajouter un lien sur l'accueil, ou renoncer au FR24 au MVP ? | Acquisition contre conversion |
| Si on l'ajoute : lien discret sous le CTA, ou choix mis en avant ? | Le CTA doit rester l'inscription |
| Que se passe-t-il après la simulation ? | Le FR24 suppose une bascule vers l'inscription au moment où la valeur vient d'être démontrée |
| Comment limiter à 1 simulation sans compte ? | Sans compte, pas d'identité — stockage local contournable |

**Argument pour :** le simulateur est le différenciateur. Le faire essayer avant
l'inscription est le meilleur argument de conversion possible.

**Argument contre :** un visiteur qui simule et repart sans compte est perdu, et
l'écran d'accueil est mesuré sur sa conversion.

**Prochaine étape :** décider avec Fitz avant de construire le lot Inscription.

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
