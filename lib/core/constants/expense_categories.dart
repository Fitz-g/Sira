import 'package:flutter/widgets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_icons.dart';

/// Catégorie de dépense — contexte UEMOA.
class ExpenseCategory {
  const ExpenseCategory({
    required this.id,
    required this.label,
    required this.icon,
    required this.color,
  });

  final String id;
  final String label;
  final IconData icon;

  /// Teinte propre à la catégorie.
  ///
  /// Elle donne son rythme à la liste des dépenses : l'œil distingue une ligne
  /// « Transport » d'une ligne « Alimentation » sans avoir à lire le libellé.
  ///
  /// Aucune n'est le rouge des erreurs — un pictogramme rouge dans une liste ne
  /// doit pas se lire comme une alerte. « Santé » prend donc un rose soutenu.
  final Color color;
}

/// Catégories de dépenses, ordonnées par fréquence d'usage décroissante
/// (spécification 02.1 — Saisie dépense).
const expenseCategories = <ExpenseCategory>[
  ExpenseCategory(
    id: 'food',
    label: 'Alimentation',
    icon: AppIcons.utensils,
    color: Color(0xFFEA580C), // orange
  ),
  ExpenseCategory(
    id: 'transport',
    label: 'Transport',
    icon: AppIcons.bus,
    color: Color(0xFF2563EB), // bleu
  ),
  ExpenseCategory(
    id: 'housing',
    label: 'Logement',
    icon: AppIcons.house,
    color: Color(0xFF7C3AED), // violet
  ),
  ExpenseCategory(
    id: 'health',
    label: 'Santé',
    icon: AppIcons.pill,
    color: Color(0xFFE11D48), // rose
  ),
  ExpenseCategory(
    id: 'leisure',
    label: 'Loisirs',
    icon: AppIcons.partyPopper,
    color: Color(0xFFC026D3), // fuchsia
  ),
  ExpenseCategory(
    id: 'family',
    label: 'Famille',
    icon: AppIcons.users,
    color: Color(0xFF0D9488), // sarcelle
  ),
  ExpenseCategory(
    id: 'savings',
    label: 'Épargne',
    icon: AppIcons.piggyBank,
    color: AppColors.primary, // le vert de la marque
  ),
  ExpenseCategory(
    id: 'other',
    label: 'Autre',
    icon: AppIcons.package,
    color: Color(0xFF64748B), // ardoise
  ),
];

/// Retrouve une catégorie par son identifiant.
///
/// Une dépense enregistrée sous un identifiant devenu inconnu — catégorie
/// retirée depuis, base d'une ancienne version — retombe sur « Autre » plutôt
/// que de faire échouer l'affichage.
ExpenseCategory categoryById(String id) {
  for (final category in expenseCategories) {
    if (category.id == id) return category;
  }
  return expenseCategories.last;
}
