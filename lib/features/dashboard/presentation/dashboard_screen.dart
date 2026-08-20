import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/currency.dart';
import '../../../shared/widgets/widgets.dart';
import '../../onboarding/domain/onboarding_options.dart';
import '../../onboarding/providers/onboarding_provider.dart';

/// 01.6 — Tableau de bord.
///
/// Écran encore à construire : score de santé financière, résumé du mois,
/// actions rapides, insight et barre de navigation. Pour l'instant il restitue
/// le profil collecté, ce qui suffit à vérifier que l'onboarding aboutit.
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final draft = ref.watch(onboardingProvider);

    String? labelOf(List<dynamic> options, String? id) {
      if (id == null) return null;
      for (final option in options) {
        if (option.id == id) return option.label as String;
      }
      return null;
    }

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            const PageHeader(
              title: 'Ton profil',
              variant: PageHeaderVariant.primary,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingPage,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppCard(
                      child: Column(
                        children: [
                          RecapRow(
                            label: 'Revenus',
                            value: labelOf(incomeRanges, draft.incomeRange) ??
                                'Non renseigné',
                          ),
                          RecapRow(
                            label: 'Situation',
                            value: labelOf(
                                  familySituations,
                                  draft.familySituation,
                                ) ??
                                'Non renseignée',
                          ),
                          RecapRow(
                            label: 'Dettes',
                            value: draft.hasDebts
                                ? Currency.format(draft.debtAmount)
                                : 'Aucune',
                          ),
                          RecapRow(
                            label: 'Épargne',
                            value: draft.hasSavings
                                ? Currency.format(draft.savingsAmount)
                                : 'Aucune',
                          ),
                          RecapRow(
                            label: 'Objectif',
                            value: labelOf(primaryGoals, draft.primaryGoal) ??
                                'Non défini',
                            isLast: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    const AppCard(
                      variant: AppCardVariant.info,
                      child: Text(
                        'Le tableau de bord complet — score de santé '
                        'financière, résumé du mois, actions rapides — arrive '
                        'au prochain lot.',
                        style: AppTypography.headingXs,
                      ),
                    ),
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
