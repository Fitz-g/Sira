import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

/// Option proposée dans un groupe de chips.
class ChipOption {
  const ChipOption({required this.id, required this.label, this.icon});

  final String id;
  final String label;

  /// Emoji ou pictogramme affiché avant le libellé.
  final String? icon;
}

/// Disposition du groupe de chips.
enum ChipsLayout {
  /// Grille à deux colonnes — libellés longs, 4 à 6 options.
  grid,

  /// Défilement horizontal — nombreuses options sur une seule ligne.
  scroll,
}

/// Sélection exclusive parmi un ensemble d'options.
///
/// Remplace les boutons radio : plus tactile, plus lisible sur mobile.
/// Design System `components/selection-chips.component.md`.
class SelectionChips extends StatelessWidget {
  const SelectionChips({
    super.key,
    required this.options,
    required this.selectedId,
    required this.onSelected,
    this.layout = ChipsLayout.grid,
  });

  final List<ChipOption> options;
  final String? selectedId;
  final ValueChanged<String> onSelected;
  final ChipsLayout layout;

  @override
  Widget build(BuildContext context) {
    if (layout == ChipsLayout.scroll) {
      return SizedBox(
        height: AppSizes.chipHeight,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: options.length,
          separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
          itemBuilder: (context, index) => _Chip(
            option: options[index],
            isSelected: options[index].id == selectedId,
            onTap: () => onSelected(options[index].id),
          ),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = (constraints.maxWidth - AppSpacing.sm) / 2;
        return Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final option in options)
              SizedBox(
                width: itemWidth,
                child: _Chip(
                  option: option,
                  isSelected: option.id == selectedId,
                  onTap: () => onSelected(option.id),
                  expand: true,
                ),
              ),
          ],
        );
      },
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.option,
    required this.isSelected,
    required this.onTap,
    this.expand = false,
  });

  final ChipOption option;
  final bool isSelected;
  final VoidCallback onTap;
  final bool expand;

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
          height: AppSizes.chipHeight,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryLight : AppColors.neutral100,
            borderRadius: BorderRadius.circular(AppSizes.radiusChip),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.neutral300,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (option.icon != null) ...[
                Text(option.icon!, style: const TextStyle(fontSize: 16)),
                const SizedBox(width: 6),
              ],
              Flexible(
                child: Text(
                  option.label,
                  style: AppTypography.headingXxs.copyWith(
                    fontWeight: FontWeight.w500,
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.neutral700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
