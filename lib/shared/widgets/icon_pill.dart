import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// Pictogramme posé dans une pastille teintée.
///
/// Sans elle, une liste d'icônes grises sur fond blanc n'a ni rythme ni
/// couleur : tout se vaut et l'œil ne s'accroche à rien. La pastille donne à
/// chaque ligne un point d'ancrage.
class IconPill extends StatelessWidget {
  const IconPill({
    super.key,
    required this.icon,
    this.color = AppColors.primary,
    this.size = 40,
  });

  final IconData icon;

  /// Couleur du pictogramme. Le fond en reprend une version très diluée.
  final Color color;

  /// Diamètre de la pastille.
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: size * 0.5, color: color),
    );
  }
}
