import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import 'pressable_scale.dart';

enum AppCardVariant {
  /// Fond blanc, bordure légère — métriques, aperçus, listes.
  standard,

  /// Fond vert pâle et liseré coloré — insight IA, message d'encouragement.
  info,
}

/// Conteneur visuel regroupant des informations liées.
///
/// Design System `components/card.component.md`.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.variant = AppCardVariant.standard,
    this.onTap,
    this.padding,
  });

  final Widget child;
  final AppCardVariant variant;

  /// Rend la card tappable (variante liste).
  final VoidCallback? onTap;

  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final isInfo = variant == AppCardVariant.info;

    // Le liseré de la variante info est un élément posé à l'intérieur de la
    // card, et non une bordure : Flutter refuse une bordure aux côtés de
    // couleurs différentes dès qu'il y a des coins arrondis.
    final container = Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isInfo ? AppColors.primaryLight : AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(AppSizes.radiusCard),
        border: Border.all(color: _borderColor(isInfo)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.radiusCard - 1),
        // IntrinsicHeight donne au Row une hauteur bornée — sans quoi le
        // liseré, qui doit s'étirer, reçoit une contrainte infinie.
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (isInfo)
                const SizedBox(
                  width: 4,
                  child: ColoredBox(color: AppColors.primary),
                ),
              Expanded(
                child: Padding(
                  padding:
                      padding ?? const EdgeInsets.all(AppSizes.paddingCard),
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (onTap == null) return container;

    return PressableScale(onTap: onTap, child: container);
  }

  Color _borderColor(bool isInfo) =>
      isInfo ? AppColors.primary.withValues(alpha: 0.2) : AppColors.neutral300;
}

/// Une métrique : un libellé et sa valeur.
class Metric {
  const Metric({required this.label, required this.value, this.valueColor});

  final String label;
  final String value;
  final Color? valueColor;
}

/// Rangée de 2 à 4 métriques réparties en colonnes égales,
/// séparées par un filet vertical.
class MetricRow extends StatelessWidget {
  const MetricRow({super.key, required this.metrics});

  final List<Metric> metrics;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < metrics.length; i++) ...[
          if (i > 0)
            Container(
              width: 1,
              height: 36,
              color: AppColors.neutral300,
              margin: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
            ),
          Expanded(
            child: Column(
              children: [
                Text(
                  metrics[i].label,
                  style: AppTypography.headingXxs
                      .copyWith(color: AppColors.neutral500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  metrics[i].value,
                  style: AppTypography.headingSm.copyWith(
                    color: metrics[i].valueColor ?? AppColors.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

/// Ligne de récapitulatif : libellé à gauche, valeur à droite.
class RecapRow extends StatelessWidget {
  const RecapRow({
    super.key,
    required this.label,
    required this.value,
    this.isLast = false,
  });

  final String label;
  final String value;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(
                bottom: BorderSide(color: AppColors.neutral100),
              ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Le libellé cède la place en premier : c'est la valeur qui compte.
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(right: AppSpacing.sm),
              child: Text(
                label,
                style: AppTypography.headingXxs
                    .copyWith(color: AppColors.neutral500),
              ),
            ),
          ),
          Text(
            value,
            style: AppTypography.headingXs.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
