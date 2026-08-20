import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import 'primary_button.dart';
import 'secondary_button.dart';

/// État vide — jamais une page blanche.
///
/// Le ton célèbre le point de départ plutôt que de constater une absence :
/// « Pas encore de dépenses ce mois — beau début ! »
/// Design System `components/empty-state.component.md`.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.title,
    required this.subtitle,
    required this.ctaLabel,
    required this.onCtaPressed,
    this.illustration,
    this.useSecondaryCta = false,
  });

  final String title;
  final String subtitle;
  final String ctaLabel;
  final VoidCallback onCtaPressed;

  /// Illustration ou pictogramme, 120 × 120.
  final Widget? illustration;

  final bool useSecondaryCta;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.xl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (illustration != null) ...[
              SizedBox(height: 120, child: Center(child: illustration)),
              const SizedBox(height: AppSpacing.md),
            ],
            Text(
              title,
              style: AppTypography.headingSm,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              subtitle,
              style: AppTypography.headingXxs
                  .copyWith(color: AppColors.neutral500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            if (useSecondaryCta)
              SecondaryButton(label: ctaLabel, onPressed: onCtaPressed)
            else
              PrimaryButton(label: ctaLabel, onPressed: onCtaPressed),
          ],
        ),
      ),
    );
  }
}
