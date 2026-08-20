import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/dates.dart';

/// Sélecteur de durée en mois, avec libellé lisible.
///
/// L'unité bascule seule : « 8 mois », « 1 an », « 2 ans et 6 mois ».
/// Spécification 03.1 — `OBJ-10-5`.
class DurationSlider extends StatelessWidget {
  const DurationSlider({
    super.key,
    required this.label,
    required this.months,
    required this.onChanged,
    this.minMonths = 1,
    this.maxMonths = 120,
  });

  final String label;
  final int months;
  final ValueChanged<int> onChanged;
  final int minMonths;
  final int maxMonths;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              label,
              style: AppTypography.headingXxs.copyWith(
                color: AppColors.neutral700,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              Dates.durationLabel(months),
              style: AppTypography.headingSm.copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: AppColors.primary,
            inactiveTrackColor: AppColors.neutral300,
            thumbColor: AppColors.primary,
            overlayColor: AppColors.primary.withValues(alpha: 0.12),
            trackHeight: 4,
            // Le curseur ne montre pas d'étiquette flottante : la valeur est
            // déjà lisible au-dessus, et elle y reste visible pendant le geste.
            showValueIndicator: ShowValueIndicator.never,
          ),
          child: Slider(
            value: months.toDouble().clamp(
                  minMonths.toDouble(),
                  maxMonths.toDouble(),
                ),
            min: minMonths.toDouble(),
            max: maxMonths.toDouble(),
            divisions: maxMonths - minMonths,
            onChanged: (value) => onChanged(value.round()),
          ),
        ),
      ],
    );
  }
}
