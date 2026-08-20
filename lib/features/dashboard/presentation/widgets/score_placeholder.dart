import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../../../core/theme/app_icons.dart';

/// Emplacement réservé du score de santé financière.
///
/// Le score se calcule à partir des dépenses réelles ; il arrive avec la
/// story 2.7. En attendant, cette carte occupe sa place et annonce sa venue.
///
/// Volontairement aucune jauge grisée ni valeur par défaut : sur un chiffre
/// financier, ne rien afficher vaut mieux qu'afficher du faux.
class ScorePlaceholder extends StatelessWidget {
  const ScorePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          Text(
            'Santé financière',
            style: AppTypography.headingXxs.copyWith(
              color: AppColors.neutral500,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                AppIcons.gauge,
                size: 28,
                color: AppColors.neutral300,
              ),
              const SizedBox(width: AppSpacing.sm),
              Flexible(
                child: Text(
                  'Ton score apparaîtra dès tes premières dépenses.',
                  style: AppTypography.headingXs.copyWith(
                    color: AppColors.neutral700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
