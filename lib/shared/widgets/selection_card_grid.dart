import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

/// Option présentée sous forme de card cliquable.
class SelectionCardOption {
  const SelectionCardOption({
    required this.id,
    required this.label,
    required this.icon,
  });

  final String id;
  final String label;

  /// Pictogramme affiché au-dessus du libellé.
  final IconData icon;
}

/// Grille de cards à sélection exclusive, deux par ligne.
///
/// Quand le nombre d'options est impair, la dernière occupe toute la largeur
/// plutôt que de laisser un trou. Spécification 01.5 — `OBJ-05-4` à `OBJ-05-8`.
class SelectionCardGrid extends StatelessWidget {
  const SelectionCardGrid({
    super.key,
    required this.options,
    required this.selectedId,
    required this.onSelected,
  });

  final List<SelectionCardOption> options;
  final String? selectedId;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final half = (constraints.maxWidth - AppSpacing.sm) / 2;

        return Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (var i = 0; i < options.length; i++)
              SizedBox(
                width: _isLonelyLast(i) ? constraints.maxWidth : half,
                child: _Card(
                  option: options[i],
                  isSelected: options[i].id == selectedId,
                  onTap: () => onSelected(options[i].id),
                ),
              ),
          ],
        );
      },
    );
  }

  bool _isLonelyLast(int index) =>
      index == options.length - 1 && options.length.isOdd;
}

class _Card extends StatelessWidget {
  const _Card({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  final SelectionCardOption option;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      inMutuallyExclusiveGroup: true,
      selected: isSelected,
      button: true,
      label: option.label,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          constraints: const BoxConstraints(minHeight: 96),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryLight : AppColors.surfaceCard,
            borderRadius: BorderRadius.circular(AppSizes.radiusCard),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.neutral300,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                option.icon,
                size: 26,
                color: isSelected ? AppColors.primary : AppColors.neutral700,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                option.label,
                style: AppTypography.headingXxs.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
