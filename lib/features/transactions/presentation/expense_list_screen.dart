import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/currency.dart';
import '../../../core/utils/dates.dart';
import '../../../shared/widgets/widgets.dart';
import '../domain/expense_grouping.dart';
import '../providers/transactions_provider.dart';
import 'widgets/expense_row.dart';

/// 02.2 — Liste des dépenses.
///
/// Étapes 2 et 3 : la liste groupée par jour, l'état vide, la navigation d'un
/// mois à l'autre et le total du mois consulté. La suppression par balayage et
/// le lien vers le budget viennent ensuite.
class ExpenseListScreen extends ConsumerWidget {
  const ExpenseListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(expenseFilterProvider);
    final expenses = ref.watch(filteredExpensesProvider);
    final total = ref.watch(filteredTotalProvider);

    return Scaffold(
      backgroundColor: AppColors.surfacePage,
      body: SafeArea(
        child: Column(
          children: [
            PageHeader(
              title: 'Mes dépenses',
              leading: HeaderLeadingAction.back,
              action: HeaderAction(
                icon: AppIcons.plus,
                label: 'Ajouter une dépense',
                onPressed: () => context.push(Routes.expenseNew),
              ),
            ),
            // S2 — Navigation d'un mois à l'autre.
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingPage,
              ),
              child: MonthSelector(
                label: Dates.monthYear(filter.month),
                onPrevious:
                    ref.read(expenseFilterProvider.notifier).goToPreviousMonth,
                // Rien à consulter au-delà du mois en cours.
                onNext: filter.canGoForward
                    ? ref.read(expenseFilterProvider.notifier).goToNextMonth
                    : null,
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // S3 — Total du mois consulté.
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingPage,
              ),
              child: _MonthTotal(
                total: total.valueOrNull,
                isCurrentMonth: filter.isCurrentMonth,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            Expanded(
              child: expenses.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(AppColors.neutral300),
                  ),
                ),
                error: (_, __) => _Problem(
                  onRetry: () => ref.invalidate(filteredExpensesProvider),
                ),
                data: (items) => items.isEmpty
                    ? _NothingYet(
                        onAdd: () => context.push(Routes.expenseNew),
                      )
                    : _GroupedList(days: groupByDay(items)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// La liste, groupée par journée.
class _GroupedList extends StatelessWidget {
  const _GroupedList({required this.days});

  final List<ExpenseDay> days;

  @override
  Widget build(BuildContext context) {
    // Construction paresseuse : la spécification exige que le défilement
    // tienne à 10 000 dépenses (NFR-SC3). Un Column les bâtirait toutes.
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.paddingPage,
        AppSpacing.sm,
        AppSizes.paddingPage,
        AppSpacing.xl,
      ),
      itemCount: days.length,
      itemBuilder: (context, index) => _DaySection(day: days[index]),
    );
  }
}

/// Une journée : son en-tête, puis ses dépenses dans une carte.
class _DaySection extends StatelessWidget {
  const _DaySection({required this.day});

  final ExpenseDay day;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Dates.relativeDay(day.date),
                  style: AppTypography.headingXs.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  Currency.format(day.total),
                  style: AppTypography.tabular(
                    AppTypography.headingXxs.copyWith(
                      color: AppColors.neutral500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          AppCard(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.paddingCard,
              vertical: AppSpacing.sm,
            ),
            child: Column(
              children: [
                for (var i = 0; i < day.expenses.length; i++) ...[
                  if (i > 0)
                    const Divider(
                      height: 1,
                      color: AppColors.neutral100,
                    ),
                  ExpenseRow(
                    categoryId: day.expenses[i].categoryId,
                    amount: day.expenses[i].amount,
                    note: day.expenses[i].note,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Aucune dépense ce mois — FR51, UX-DR1.
class _NothingYet extends StatelessWidget {
  const _NothingYet({required this.onAdd});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      illustration: const IconPill(icon: AppIcons.package, size: 72),
      title: 'Pas encore de dépenses ce mois',
      subtitle: 'Beau début ! Note la première pour voir où part ton argent.',
      ctaLabel: 'Noter une dépense',
      onCtaPressed: onAdd,
    );
  }
}

/// La lecture a échoué — on le dit, et on propose de réessayer.
class _Problem extends StatelessWidget {
  const _Problem({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      illustration: const IconPill(
        icon: AppIcons.circleX,
        color: AppColors.error,
        size: 72,
      ),
      title: 'Impossible de charger tes dépenses',
      subtitle: 'Rien n’est perdu — réessaie dans un instant.',
      ctaLabel: 'Réessayer',
      onCtaPressed: onRetry,
      useSecondaryCta: true,
    );
  }
}

/// Total du mois consulté — `OBJ-08-3`.
class _MonthTotal extends StatelessWidget {
  const _MonthTotal({required this.total, required this.isCurrentMonth});

  /// `null` tant que la lecture n'a pas abouti.
  final int? total;

  final bool isCurrentMonth;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isCurrentMonth ? 'Dépensé ce mois' : 'Dépensé ce mois-là',
            style: AppTypography.headingXxs.copyWith(
              color: AppColors.neutral500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            // Un tiret plutôt qu'un zéro pendant la lecture : afficher « 0 »
            // ferait croire un instant qu'il n'y a rien.
            total == null ? '—' : Currency.format(total!),
            style: AppTypography.tabular(AppTypography.headingLg),
          ),
        ],
      ),
    );
  }
}
