import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/currency.dart';
import '../../../../core/utils/dates.dart';
import '../../domain/simulation_models.dart';

/// Courbe d'épargne cumulée — spécification 03.2, `OBJ-11-3`.
///
/// Volontairement dépouillée : trois repères en ordonnée, trois en abscisse.
/// L'écran doit se lire en trois secondes, pas se déchiffrer.
class ProjectionChart extends StatelessWidget {
  const ProjectionChart({super.key, required this.points});

  final List<SimulationPoint> points;

  static const _height = 200.0;

  @override
  Widget build(BuildContext context) {
    final lastMonth = points.last.month;
    final maxAmount = points.last.amount.toDouble();

    return SizedBox(
      height: _height,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: lastMonth.toDouble(),
          minY: 0,
          // 8 % de marge au-dessus pour que le point d'arrivée ne touche
          // pas le bord haut.
          maxY: maxAmount * 1.08,
          lineBarsData: [
            LineChartBarData(
              spots: [
                for (final point in points)
                  FlSpot(point.month.toDouble(), point.amount.toDouble()),
              ],
              isCurved: true,
              curveSmoothness: 0.2,
              color: AppColors.primary,
              barWidth: 3,
              belowBarData: BarAreaData(
                show: true,
                color: AppColors.primary.withValues(alpha: 0.10),
              ),
              // Un seul point marqué : la cible atteinte.
              dotData: FlDotData(
                show: true,
                checkToShowDot: (spot, _) => spot.x == lastMonth.toDouble(),
                getDotPainter: (_, __, ___, ____) => FlDotCirclePainter(
                  radius: 5,
                  color: AppColors.primary,
                  strokeWidth: 2.5,
                  strokeColor: AppColors.surface,
                ),
              ),
            ),
          ],
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: maxAmount / 2,
            getDrawingHorizontalLine: (_) => const FlLine(
              color: AppColors.neutral100,
              strokeWidth: 1,
            ),
          ),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(),
            rightTitles: const AxisTitles(),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 44,
                interval: maxAmount / 2,
                getTitlesWidget: (value, _) {
                  // La marge haute porterait une étiquette qui viendrait
                  // chevaucher celle du montant cible.
                  if (value > maxAmount) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Text(
                      Currency.compact(value.round()),
                      style: _axisStyle,
                      textAlign: TextAlign.right,
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 28,
                interval: lastMonth / 2,
                getTitlesWidget: (value, _) {
                  final month = value.round();
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      month == 0 ? 'Départ' : Dates.durationLabel(month),
                      style: _axisStyle,
                    ),
                  );
                },
              ),
            ),
          ),
          lineTouchData: const LineTouchData(enabled: false),
        ),
      ),
    );
  }

  static final _axisStyle = AppTypography.headingXxs.copyWith(
    fontSize: 11,
    color: AppColors.neutral500,
  );
}
