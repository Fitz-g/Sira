import 'package:flutter/widgets.dart';
import '../../core/theme/app_icons.dart';

/// Catégorie de dépense — contexte UEMOA.
class ExpenseCategory {
  const ExpenseCategory({
    required this.id,
    required this.label,
    required this.icon,
  });

  final String id;
  final String label;
  final IconData icon;
}

/// Catégories de dépenses, ordonnées par fréquence d'usage décroissante
/// (spécification 02.1 — Saisie dépense).
const expenseCategories = <ExpenseCategory>[
  ExpenseCategory(
    id: 'food',
    label: 'Alimentation',
    icon: AppIcons.utensils,
  ),
  ExpenseCategory(id: 'transport', label: 'Transport', icon: AppIcons.bus),
  ExpenseCategory(id: 'housing', label: 'Logement', icon: AppIcons.house),
  ExpenseCategory(id: 'health', label: 'Santé', icon: AppIcons.pill),
  ExpenseCategory(id: 'leisure', label: 'Loisirs', icon: AppIcons.partyPopper),
  ExpenseCategory(
    id: 'family',
    label: 'Famille',
    icon: AppIcons.users,
  ),
  ExpenseCategory(
    id: 'savings',
    label: 'Épargne',
    icon: AppIcons.piggyBank,
  ),
  ExpenseCategory(id: 'other', label: 'Autre', icon: AppIcons.package),
];
