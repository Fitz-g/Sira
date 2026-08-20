import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import 'pressable_scale.dart';

/// Bouton d'action secondaire — bordure verte, fond transparent.
///
/// Peut cohabiter avec un [PrimaryButton] sur la même page.
/// Design System `components/secondary-actions.component.md`.
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;

  /// Icône optionnelle affichée avant le libellé.
  final IconData? icon;

  /// `false` pour un bouton qui s'ajuste à son contenu (mise en page côte à côte).
  final bool expand;

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      enabled: onPressed != null,
      onTap: onPressed,
      semanticLabel: label,
      child: Container(
        width: expand ? double.infinity : null,
        height: AppSizes.buttonSecondaryHeight,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary, width: 1.5),
          borderRadius: BorderRadius.circular(AppSizes.radiusCard),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18, color: AppColors.primary),
              const SizedBox(width: AppSpacing.sm),
            ],
            Flexible(
              child: Text(
                label,
                style: AppTypography.headingXs.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
