/**
 * Catégories de dépenses — contextualisées UEMOA.
 * Ordre : fréquence d'usage décroissante (UX spec 02.1).
 */
export const EXPENSE_CATEGORIES = [
  { id: 'food',      label: 'Alimentation', labelEn: 'Food',      icon: '🍽' },
  { id: 'transport', label: 'Transport',    labelEn: 'Transport', icon: '🚌' },
  { id: 'housing',   label: 'Logement',     labelEn: 'Housing',   icon: '🏠' },
  { id: 'health',    label: 'Santé',        labelEn: 'Health',    icon: '💊' },
  { id: 'leisure',   label: 'Loisirs',      labelEn: 'Leisure',   icon: '🎉' },
  { id: 'family',    label: 'Famille',      labelEn: 'Family',    icon: '👨‍👩‍👧' },
  { id: 'savings',   label: 'Épargne',      labelEn: 'Savings',   icon: '💰' },
  { id: 'other',     label: 'Autre',        labelEn: 'Other',     icon: '📦' },
] as const;

export type ExpenseCategoryId = typeof EXPENSE_CATEGORIES[number]['id'];
