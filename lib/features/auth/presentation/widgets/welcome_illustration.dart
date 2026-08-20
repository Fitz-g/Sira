import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// Illustration d'accueil — provisoire.
///
/// Évoque une trajectoire financière ascendante aux couleurs de la marque.
///
/// À remplacer par l'illustration définitive prévue par la spécification 01.1
/// (`OBJ-01-1`) : personnage local en style illustré, courbe de projection,
/// couleurs chaudes, ancrage culturel africain.
class WelcomeIllustration extends StatelessWidget {
  const WelcomeIllustration({super.key});

  /// Hauteurs relatives des barres — progression volontairement irrégulière
  /// puis franchement ascendante.
  static const _bars = <double>[0.26, 0.40, 0.34, 0.56, 0.72, 1.0];

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Illustration : une courbe financière ascendante',
      excludeSemantics: true,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final height = constraints.maxHeight;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (var i = 0; i < _bars.length; i++) ...[
                if (i > 0) const SizedBox(width: 12),
                Container(
                  width: 32,
                  height: height * _bars[i],
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(
                      // La dernière barre est pleinement opaque : c'est le cap visé.
                      alpha: i == _bars.length - 1 ? 1.0 : 0.15 + i * 0.13,
                    ),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(8),
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
