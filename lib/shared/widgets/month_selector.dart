import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_icons.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

/// Navigation d'un mois à l'autre — spécification 02.2, `OBJ-08-2`.
///
/// Le chevron avant se désactive quand il n'y a rien devant : mieux vaut un
/// bouton visiblement inerte qu'un bouton qui ne répond pas sans expliquer
/// pourquoi.
class MonthSelector extends StatelessWidget {
  const MonthSelector({
    super.key,
    required this.label,
    required this.onPrevious,
    this.onNext,
  });

  /// Mois affiché, déjà mis en forme — « Août 2026 ».
  final String label;

  final VoidCallback onPrevious;

  /// `null` désactive la navigation vers l'avant.
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _Chevron(
          icon: AppIcons.chevronLeft,
          semanticLabel: 'Mois précédent',
          onPressed: onPrevious,
        ),
        Expanded(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: AppTypography.headingXs.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        _Chevron(
          icon: AppIcons.chevronRight,
          semanticLabel: 'Mois suivant',
          onPressed: onNext,
        ),
      ],
    );
  }
}

class _Chevron extends StatelessWidget {
  const _Chevron({
    required this.icon,
    required this.semanticLabel,
    required this.onPressed,
  });

  final IconData icon;
  final String semanticLabel;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null;

    return Semantics(
      button: true,
      enabled: isEnabled,
      label: semanticLabel,
      child: GestureDetector(
        onTap: onPressed,
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          width: AppSizes.minTouchTarget,
          height: AppSizes.minTouchTarget,
          child: Icon(
            icon,
            size: 22,
            color: isEnabled ? AppColors.onSurface : AppColors.neutral300,
          ),
        ),
      ),
    );
  }
}
