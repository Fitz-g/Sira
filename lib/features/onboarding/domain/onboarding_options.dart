import '../../../shared/widgets/selection_card_grid.dart';
import '../../../shared/widgets/selection_chips.dart';

/// Fourchettes de revenus mensuels — spécification 01.3, `OBJ-03-5`.
const incomeRanges = <ChipOption>[
  ChipOption(id: 'under_150k', label: 'Moins de 150 000 F'),
  ChipOption(id: 'from_150k_to_300k', label: '150 000 – 300 000 F'),
  ChipOption(id: 'from_300k_to_500k', label: '300 000 – 500 000 F'),
  ChipOption(id: 'from_500k_to_1m', label: '500 000 – 1 000 000 F'),
  ChipOption(id: 'over_1m', label: 'Plus de 1 000 000 F'),
];

/// Situations familiales — spécification 01.3, `OBJ-03-7`.
///
/// « Chef de famille élargie » n'a pas d'équivalent dans les apps
/// occidentales : c'est une réalité courante en zone UEMOA, où un revenu
/// soutient souvent plusieurs foyers.
const familySituations = <ChipOption>[
  ChipOption(id: 'single', label: 'Célibataire'),
  ChipOption(id: 'couple', label: 'En couple'),
  ChipOption(id: 'married_children', label: 'Marié(e) avec enfants'),
  ChipOption(id: 'extended_family', label: 'Chef de famille élargie'),
];

/// Objectifs principaux — spécification 01.5, `OBJ-05-4` à `OBJ-05-8`.
const primaryGoals = <SelectionCardOption>[
  SelectionCardOption(id: 'budget', label: 'Maîtriser mon budget', icon: '📊'),
  SelectionCardOption(id: 'debts', label: 'Rembourser mes dettes', icon: '💳'),
  SelectionCardOption(id: 'save', label: 'Épargner pour un projet', icon: '🎯'),
  SelectionCardOption(
    id: 'invest',
    label: 'Investir en bourse (BRVM)',
    icon: '📈',
  ),
  SelectionCardOption(
    id: 'learn',
    label: 'Mieux comprendre mes finances',
    icon: '💡',
  ),
];
