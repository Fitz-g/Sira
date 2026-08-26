import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/currency.dart';
import '../../../core/utils/dates.dart';
import '../../../shared/widgets/widgets.dart';
import '../../onboarding/domain/onboarding_options.dart';
import '../../onboarding/providers/onboarding_provider.dart';
import '../../transactions/providers/transactions_provider.dart';
import 'widgets/goal_advice.dart';
import 'widgets/score_placeholder.dart';
import '../../../core/theme/app_icons.dart';

/// 01.6 — Tableau de bord.
///
/// Le moment de vérité du parcours : l'utilisateur vient de donner ses
/// informations, l'application doit montrer qu'elle en a fait quelque chose.
///
/// Story 1.9. Le score de santé financière n'y figure pas encore — il se
/// calcule sur les dépenses réelles et arrive avec la story 2.7.
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final draft = ref.watch(onboardingProvider);
    final month = Dates.monthYear(DateTime.now());

    return Scaffold(
      backgroundColor: AppColors.surfacePage,
      body: SafeArea(
        child: Column(
          children: [
            // S1 — Salutation
            const PageHeader(
              title: 'Bonjour',
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
                    // S2 — Score, à venir
                    const ScorePlaceholder(),
                    const SizedBox(height: AppSpacing.lg),

                    // S3 — Situation déclarée et résumé du mois
                    Text(
                      'Ta situation',
                      style: AppTypography.headingXs.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _DeclaredSituation(
                      incomeRange: draft.incomeRange,
                      hasDebts: draft.hasDebts,
                      debtAmount: draft.debtAmount,
                      hasSavings: draft.hasSavings,
                      savingsAmount: draft.savingsAmount,
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    Text(
                      month,
                      style: AppTypography.headingXs.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    ref.watch(currentMonthTotalProvider).when(
                          // Tant que la lecture n'a pas abouti, une carte vide
                          // tient la place : jamais de saut de mise en page.
                          loading: () => const _MonthTotalLoading(),
                          error: (_, __) => _NoExpensesYet(
                            onAddExpense: () => _openExpenses(context),
                          ),
                          data: (total) => total > 0
                              ? _MonthTotal(total: total)
                              : _NoExpensesYet(
                                  onAddExpense: () => _openExpenses(context),
                                ),
                        ),
                    const SizedBox(height: AppSpacing.lg),

                    // S4 — Actions rapides
                    _QuickActions(
                      onExpense: () => _openExpenses(context),
                      onGoal: () => _openGoals(context),
                      onSimulate: () => context.push(Routes.simulator),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // S5 — Conseil tiré de l'objectif choisi
                    AppCard(
                      variant: AppCardVariant.info,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const IconPill(icon: AppIcons.lightbulb, size: 34),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              adviceForGoal(draft.primaryGoal),
                              style: AppTypography.headingXs,
                            ),
                          ),
                        ],
                      ),
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

  void _openExpenses(BuildContext context) =>
      context.push(Routes.expenseNew);

  // L'écran des objectifs n'existe pas encore. Plutôt qu'un bouton mort, on
  // annonce ce qui vient — l'utilisateur sait où il en est.

  void _openGoals(BuildContext context) => AppToast.show(
        context,
        'Les objectifs d’épargne arrivent bientôt.',
        type: ToastType.info,
      );
}

/// Restitue ce que l'utilisateur a déclaré pendant l'onboarding.
class _DeclaredSituation extends StatelessWidget {
  const _DeclaredSituation({
    required this.incomeRange,
    required this.hasDebts,
    required this.debtAmount,
    required this.hasSavings,
    required this.savingsAmount,
  });

  final String? incomeRange;
  final bool hasDebts;
  final int debtAmount;
  final bool hasSavings;
  final int savingsAmount;

  String get _incomeLabel {
    for (final option in incomeRanges) {
      if (option.id == incomeRange) return option.label;
    }
    return 'Non renseignés';
  }

  @override
  Widget build(BuildContext context) {
    // Des lignes plutôt que des colonnes : une fourchette de revenus
    // (« 150 000 – 300 000 F ») serait tronquée dans un tiers de largeur.
    return AppCard(
      child: Column(
        children: [
          RecapRow(label: 'Revenus mensuels', value: _incomeLabel),
          RecapRow(
            label: 'Épargne déclarée',
            value: hasSavings ? Currency.format(savingsAmount) : 'Aucune',
          ),
          RecapRow(
            label: 'Dettes déclarées',
            value: hasDebts ? Currency.format(debtAmount) : 'Aucune',
            isLast: true,
          ),
        ],
      ),
    );
  }
}

/// État vide du résumé mensuel — FR51, UX-DR1.
class _NoExpensesYet extends StatelessWidget {
  const _NoExpensesYet({required this.onAddExpense});

  final VoidCallback onAddExpense;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pas encore de dépenses ce mois — beau début !',
            style: AppTypography.headingXs.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Note ta première dépense pour voir où part ton argent.',
            style: AppTypography.headingXxs.copyWith(
              color: AppColors.neutral500,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          SecondaryButton(
            label: 'Noter une dépense',
            icon: AppIcons.plus,
            onPressed: onAddExpense,
          ),
        ],
      ),
    );
  }
}

/// S4 — trois actions au tiers de largeur, libellés courts.
///
/// Le bouton « Simuler » est la correction apportée à la spécification 01.6 :
/// le simulateur n'avait aucune porte d'entrée dans l'application.
class _QuickActions extends StatelessWidget {
  const _QuickActions({
    required this.onExpense,
    required this.onGoal,
    required this.onSimulate,
  });

  final VoidCallback onExpense;
  final VoidCallback onGoal;
  final VoidCallback onSimulate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _QuickAction(
            icon: AppIcons.plus,
            label: 'Dépense',
            onPressed: onExpense,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _QuickAction(
            icon: AppIcons.target,
            label: 'Objectif',
            onPressed: onGoal,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _QuickAction(
            icon: AppIcons.trendingUp,
            label: 'Simuler',
            onPressed: onSimulate,
          ),
        ),
      ],
    );
  }
}

/// Action rapide : pictogramme au-dessus du libellé.
///
/// La disposition verticale est ce qui permet aux trois libellés de tenir
/// entiers dans un tiers de largeur — côte à côte, l'icône les tronquait.
class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      onTap: onPressed,
      semanticLabel: label,
      child: Container(
        height: 88,
        decoration: BoxDecoration(
          color: AppColors.surfaceCard,
          borderRadius: BorderRadius.circular(AppSizes.radiusCard),
          boxShadow: AppElevation.card,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconPill(icon: icon, size: 34),
            const SizedBox(height: 6),
            Text(
              label,
              style: AppTypography.headingXxs.copyWith(
                color: AppColors.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Total dépensé ce mois-ci.
class _MonthTotal extends StatelessWidget {
  const _MonthTotal({required this.total});

  final int total;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dépensé ce mois',
            style: AppTypography.headingXxs.copyWith(
              color: AppColors.neutral500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            Currency.format(total),
            style: AppTypography.tabular(AppTypography.headingLg),
          ),
        ],
      ),
    );
  }
}

/// Occupe la place du total pendant la lecture de la base.
class _MonthTotalLoading extends StatelessWidget {
  const _MonthTotalLoading();

  @override
  Widget build(BuildContext context) {
    return const AppCard(
      child: SizedBox(
        height: 52,
        child: Center(
          child: SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(AppColors.neutral300),
            ),
          ),
        ),
      ),
    );
  }
}
