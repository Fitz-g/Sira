import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import 'pressable_scale.dart';

/// Bouton d'action principal — pleine largeur, 56 px, vert profond.
///
/// Un seul par page : c'est lui qui porte l'action attendue.
/// Design System `components/primary-button.component.md`.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  final String label;

  /// `null` désactive le bouton (opacité 0.4, non tappable).
  final VoidCallback? onPressed;

  /// Remplace le libellé par un indicateur de chargement.
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null && !isLoading;

    return PressableScale(
      enabled: isEnabled,
      onTap: onPressed,
      semanticLabel: isLoading ? 'Chargement en cours' : label,
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(
          minHeight: AppSizes.buttonPrimaryHeight,
        ),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(AppSizes.radiusCard),
        ),
        alignment: Alignment.center,
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation(AppColors.onPrimary),
                ),
              )
            : Text(
                label,
                style: AppTypography.headingSm.copyWith(
                  color: AppColors.onPrimary,
                ),
                textAlign: TextAlign.center,
              ),
      ),
    );
  }
}
