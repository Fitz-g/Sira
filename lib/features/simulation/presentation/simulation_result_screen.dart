import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/currency.dart';
import '../../../core/utils/dates.dart';
import '../../../shared/widgets/widgets.dart';
import '../domain/simulation_engine.dart';
import '../domain/simulation_models.dart';

/// 03.2 — Résultat de simulation.
///
/// Version intermédiaire : les chiffres sont exacts, mais la courbe de
/// projection et la mise en page définitive restent à construire.
class SimulationResultScreen extends StatelessWidget {
  const SimulationResultScreen({super.key, required this.params});

  final SimulationParams params;

  @override
  Widget build(BuildContext context) {
    final result = SimulationEngine.project(params);

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            const PageHeader(
              title: 'Ta projection',
              leading: HeaderLeadingAction.back,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingPage,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      Currency.format(result.monthlyContribution),
                      style: AppTypography.heading3xl.copyWith(
                        color: AppColors.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      'à épargner chaque mois pour atteindre ton objectif',
                      style: AppTypography.headingXxs,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    AppCard(
                      child: Column(
                        children: [
                          RecapRow(
                            label: 'Objectif',
                            value: Currency.format(params.targetAmount),
                          ),
                          RecapRow(
                            label: 'Durée',
                            value: Dates.durationLabel(params.durationMonths),
                          ),
                          RecapRow(
                            label: 'Total versé',
                            value: Currency.format(result.totalContributed),
                          ),
                          RecapRow(
                            label: 'Intérêts gagnés',
                            value: Currency.format(result.interestEarned),
                          ),
                          RecapRow(
                            label: 'Valeur réelle après inflation',
                            value: Currency.format(result.realFinalAmount),
                            isLast: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      'Estimation indicative — ce n’est pas un conseil '
                      'financier. Les rendements passés ne garantissent pas '
                      'les rendements futurs.',
                      style: AppTypography.headingXxs.copyWith(
                        color: AppColors.neutral500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
