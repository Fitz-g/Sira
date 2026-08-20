import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/currency.dart';
import '../../../core/utils/dates.dart';
import '../../../shared/widgets/widgets.dart';
import '../domain/simulation_engine.dart';
import '../domain/simulation_models.dart';
import 'widgets/projection_chart.dart';

/// 03.2 — Résultat de simulation.
///
/// Le moment de vérité du parcours : l'utilisatrice découvre si son projet est
/// à sa portée. Le chiffre mensuel arrive donc en premier, avant la courbe et
/// avant le détail.
class SimulationResultScreen extends StatelessWidget {
  const SimulationResultScreen({super.key, required this.params});

  final SimulationParams params;

  @override
  Widget build(BuildContext context) {
    final result = SimulationEngine.project(params);
    final duration = Dates.durationLabel(params.durationMonths);

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            PageHeader(
              title: 'Ta projection',
              leading: HeaderLeadingAction.back,
              onLeadingPressed: () => Navigator.of(context).maybePop(),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingPage,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // S2 — Le chiffre qui répond à la question posée.
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

                    // S3 — Courbe de projection.
                    ProjectionChart(points: result.points),
                    const SizedBox(height: AppSpacing.lg),

                    // S4 — Détail des paramètres et du résultat.
                    AppCard(
                      child: Column(
                        children: [
                          RecapRow(
                            label: 'Objectif',
                            value: Currency.format(params.targetAmount),
                          ),
                          RecapRow(label: 'Durée', value: duration),
                          RecapRow(
                            label: 'Total que tu verses',
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
                    const SizedBox(height: AppSpacing.md),

                    // FR22 — le rendement nominal ne dit pas tout.
                    AppCard(
                      variant: AppCardVariant.info,
                      child: Text(
                        'Dans $duration, ces '
                        '${Currency.format(result.finalAmount)} auront le '
                        'pouvoir d’achat de '
                        '${Currency.format(result.realFinalAmount)} '
                        'd’aujourd’hui — l’inflation ronge une partie du gain.',
                        style: AppTypography.headingXs,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
            ),

            // S5 — Actions.
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSizes.paddingPage,
                0,
                AppSizes.paddingPage,
                AppSpacing.sm,
              ),
              child: Column(
                children: [
                  PrimaryButton(
                    label: 'Créer cet objectif',
                    // TODO(objectifs): router vers 05.2 quand le module
                    // Objectifs d'épargne existera.
                    onPressed: () => AppToast.show(
                      context,
                      'La création d’objectifs arrive bientôt.',
                      type: ToastType.info,
                    ),
                  ),
                  TextLink(
                    label: 'Modifier les paramètres',
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),

                  // Mention légale obligatoire sur toute simulation (UX-DR3).
                  Text(
                    'Estimation indicative, pas un conseil financier. '
                    'Les rendements passés ne garantissent pas les rendements '
                    'futurs.',
                    style: AppTypography.headingXxs.copyWith(
                      fontSize: 11,
                      color: AppColors.neutral500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
