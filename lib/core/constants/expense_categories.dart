/// Catégorie de dépense — contexte UEMOA.
class ExpenseCategory {
  const ExpenseCategory({
    required this.id,
    required this.label,
    required this.icon,
  });

  final String id;
  final String label;
  final String icon;
}

/// Catégories de dépenses, ordonnées par fréquence d'usage décroissante
/// (spécification 02.1 — Saisie dépense).
const expenseCategories = <ExpenseCategory>[
  ExpenseCategory(id: 'food', label: 'Alimentation', icon: '🍽'),
  ExpenseCategory(id: 'transport', label: 'Transport', icon: '🚌'),
  ExpenseCategory(id: 'housing', label: 'Logement', icon: '🏠'),
  ExpenseCategory(id: 'health', label: 'Santé', icon: '💊'),
  ExpenseCategory(id: 'leisure', label: 'Loisirs', icon: '🎉'),
  ExpenseCategory(id: 'family', label: 'Famille', icon: '👨‍👩‍👧'),
  ExpenseCategory(id: 'savings', label: 'Épargne', icon: '💰'),
  ExpenseCategory(id: 'other', label: 'Autre', icon: '📦'),
];
