import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

/// Interrupteur précédé de son libellé, tappable sur toute sa largeur.
///
/// Spécification 01.4 — `OBJ-04-4` et `OBJ-04-6`.
class LabeledSwitch extends StatelessWidget {
  const LabeledSwitch({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      toggled: value,
      label: label,
      child: InkWell(
        onTap: () => onChanged(!value),
        borderRadius: BorderRadius.circular(AppSizes.radiusInput),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: AppTypography.headingXs.copyWith(
                    color: AppColors.onSurface,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              // Le Switch ne reçoit pas le geste : c'est la ligne entière qui
              // bascule, ce qui élargit la zone tactile (NFR-A1).
              IgnorePointer(
                child: Switch(
                  value: value,
                  onChanged: (_) {},
                  activeTrackColor: AppColors.primary,
                  inactiveTrackColor: AppColors.neutral300,
                  inactiveThumbColor: AppColors.surface,
                  trackOutlineColor:
                      const WidgetStatePropertyAll(Colors.transparent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
