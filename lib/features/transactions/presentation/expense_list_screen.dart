import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/constants/expense_categories.dart';
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

/// Identifiant du chip « Toutes » — ne correspond à aucune catégorie réelle.
const _allCategories = '__toutes__';

/// 02.2 — Liste des dépenses.
///
/// Étapes 2 et 3 : la liste groupée par jour, l'état vide, la navigation d'un
/// mois à l'autre et le total du mois consulté. La suppression par balayage et
/// le lien vers le budget viennent ensuite.
class ExpenseListScreen extends ConsumerStatefulWidget {
  const ExpenseListScreen({super.key, this.justAdded = false});

  /// Vrai quand on arrive juste d'avoir enregistré une dépense — la liste le
  /// confirme alors par un toast (`OBJ-08-5`).
  final bool justAdded;

  @override
  ConsumerState<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends ConsumerState<ExpenseListScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.justAdded) {
      // Après le premier rendu : un toast s'appuie sur l'Overlay, qui n'existe
      // pas encore pendant initState.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) AppToast.show(context, 'Dépense ajoutée');
      });
    }
  }

  /// Ouvre la saisie, et confirme si une dépense en revient.
  Future<void> _addExpense() async {
    final added = await context.push<bool>(Routes.expenseNew);
    if (!mounted || added != true) return;

    ref.invalidate(filteredExpensesProvider);
    AppToast.show(context, 'Dépense ajoutée');
  }

  @override
  Widget build(BuildContext context) {
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
                onPressed: _addExpense,
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
                categoryId: filter.categoryId,
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Filtrage par catégorie, juste au-dessus de ce qu'il restreint.
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingPage,
              ),
              child: SelectionChips(
                layout: ChipsLayout.scroll,
                options: [
                  const ChipOption(id: _allCategories, label: 'Toutes'),
                  for (final c in expenseCategories)
                    ChipOption(id: c.id, label: c.label, icon: c.icon),
                ],
                selectedId: filter.categoryId ?? _allCategories,
                onSelected: (id) => ref
                    .read(expenseFilterProvider.notifier)
                    .setCategory(id == _allCategories ? null : id),
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
                        categoryId: filter.categoryId,
                        onAdd: _addExpense,
                      )
                    : _GroupedList(days: groupByDay(items)),
              ),
            ),
            // S5 — Passage au budget.
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSizes.paddingPage,
                0,
                AppSizes.paddingPage,
                AppSpacing.md,
              ),
              child: SecondaryButton(
                label: 'Voir mon budget',
                // TODO(budget): router vers 02.3 quand la story 2.4 existera.
                onPressed: () => AppToast.show(
                  context,
                  'Le budget mensuel arrive au prochain lot.',
                  type: ToastType.info,
                ),
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
  const _NothingYet({required this.onAdd, this.categoryId});

  final VoidCallback onAdd;
  final String? categoryId;

  @override
  Widget build(BuildContext context) {
    // Un mois vide et une catégorie vide n'appellent pas le même message :
    // dans le second cas, l'utilisateur a peut-être simplement mal filtré.
    if (categoryId != null) {
      final categorie = categoryById(categoryId!);
      return EmptyState(
        illustration: IconPill(
          icon: categorie.icon,
          color: categorie.color,
          size: 72,
        ),
        title: 'Rien en ${categorie.label} ce mois',
        subtitle: 'Choisis « Toutes » pour revoir l’ensemble de tes dépenses.',
        ctaLabel: 'Noter une dépense',
        onCtaPressed: onAdd,
        useSecondaryCta: true,
      );
    }

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
  const _MonthTotal({
    required this.total,
    required this.isCurrentMonth,
    this.categoryId,
  });

  /// `null` tant que la lecture n'a pas abouti.
  final int? total;

  final bool isCurrentMonth;

  /// Catégorie retenue, s'il y en a une.
  final String? categoryId;

  /// Un total filtré doit dire ce qu'il compte.
  ///
  /// « Dépensé ce mois » sur un chiffre qui n'inclut que l'alimentation serait
  /// un mensonge — et sur une app financière, un chiffre mal nommé fait plus de
  /// dégâts qu'un chiffre absent.
  String get _label {
    if (categoryId != null) {
      final categorie = categoryById(categoryId!).label;
      return isCurrentMonth ? '$categorie ce mois' : '$categorie ce mois-là';
    }
    return isCurrentMonth ? 'Dépensé ce mois' : 'Dépensé ce mois-là';
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _label,
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
