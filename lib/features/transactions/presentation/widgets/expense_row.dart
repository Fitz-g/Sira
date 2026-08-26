import 'package:flutter/material.dart';

import '../../../../core/constants/expense_categories.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/currency.dart';
import '../../../../shared/widgets/widgets.dart';

/// Une dépense dans la liste — spécification 02.2, `OBJ-08-4`.
///
/// La pastille porte la couleur de la catégorie : c'est ce qui permet de
/// parcourir une liste sans lire chaque libellé.
class ExpenseRow extends StatelessWidget {
  const ExpenseRow({
    super.key,
    required this.categoryId,
    required this.amount,
    this.note,
    this.onTap,
  });

  final String categoryId;

  /// Montant en FCFA entiers.
  final int amount;

  /// Précision facultative saisie par l'utilisateur.
  final String? note;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final category = categoryById(categoryId);
    final hasNote = note != null && note!.trim().isNotEmpty;

    final row = Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          IconPill(icon: category.icon, color: category.color),
          const SizedBox(width: AppSpacing.md),

          // Le libellé cède la place en premier : c'est le montant qui compte.
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  category.label,
                  style: AppTypography.headingXxs.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (hasNote) ...[
                  const SizedBox(height: 2),
                  Text(
                    note!,
                    style: AppTypography.headingXxs.copyWith(
                      color: AppColors.neutral500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),

          Text(
            Currency.format(amount),
            style: AppTypography.tabular(
              AppTypography.headingXs.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );

    if (onTap == null) return row;

    return PressableScale(onTap: onTap, semanticLabel: category.label, child: row);
  }
}
