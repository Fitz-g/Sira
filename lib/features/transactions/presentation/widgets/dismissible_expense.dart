import 'package:flutter/material.dart';

import '../../../../core/constants/expense_categories.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/currency.dart';
import '../../../../data/local/app_database.dart';
import 'expense_row.dart';

/// Une dépense qu'on peut effacer d'un balayage — spécification 02.2,
/// `OBJ-08-4`.
///
/// Le geste ne supprime jamais seul : une confirmation nomme ce qui va
/// disparaître. Effacer une dépense est irréversible, et un balayage part
/// facilement d'un simple défilement mal accroché.
class DismissibleExpense extends StatelessWidget {
  const DismissibleExpense({
    super.key,
    required this.expense,
    required this.onDelete,
    this.onTap,
  });

  final Transaction expense;

  /// Appelé une fois la suppression confirmée.
  final Future<bool> Function() onDelete;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(expense.id),
      // Vers la gauche seulement : le balayage inverse sert au retour arrière
      // sur iOS, on ne le détourne pas.
      direction: DismissDirection.endToStart,
      background: const _DeleteBackground(),
      // La suppression a lieu ici, et la réponse est toujours `false` : c'est
      // le rafraîchissement de la liste qui retire la ligne, pas le geste.
      //
      // Dismissible exige qu'une ligne écartée quitte l'arbre dans la même
      // frame ; notre effacement passe par la base et le provider, donc une
      // frame plus tard. Laisser le widget s'écarter lèverait une assertion.
      confirmDismiss: (_) async {
        if (!await _confirm(context)) return false;
        await onDelete();
        return false;
      },
      child: ExpenseRow(
        categoryId: expense.categoryId,
        amount: expense.amount,
        note: expense.note,
        onTap: onTap,
      ),
    );
  }

  /// Demande confirmation avant tout effacement.
  Future<bool> _confirm(BuildContext context) async {
    final categorie = categoryById(expense.categoryId).label;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusCard),
        ),
        title: const Text(
          'Supprimer cette dépense ?',
          style: AppTypography.headingSm,
        ),
        // Le rappel du montant et de la catégorie évite d'effacer la mauvaise
        // ligne quand plusieurs se ressemblent.
        content: Text(
          '$categorie — ${Currency.format(expense.amount)}\n\n'
          'Cette dépense sera définitivement effacée.',
          style: AppTypography.headingXs,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'Annuler',
              style: AppTypography.headingXs.copyWith(
                color: AppColors.neutral700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              'Supprimer',
              style: AppTypography.headingXs.copyWith(
                color: AppColors.error,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );

    return confirmed ?? false;
  }
}

/// Ce qui se découvre sous la ligne pendant le balayage.
class _DeleteBackground extends StatelessWidget {
  const _DeleteBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.error,
        borderRadius: BorderRadius.circular(AppSizes.radiusInput),
      ),
      child: const Icon(AppIcons.trash, color: AppColors.onPrimary, size: 22),
    );
  }
}
