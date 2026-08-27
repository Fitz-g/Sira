import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/expense_categories.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/currency.dart';
import '../../../core/utils/currency_input_formatter.dart';
import '../../../core/utils/dates.dart';
import '../../../data/models/result.dart';
import '../../../shared/widgets/widgets.dart';
import '../providers/budget_provider.dart';

/// 02.3 — Budget mensuel, définition des enveloppes.
///
/// Story 2.4. La comparaison avec les dépenses réelles — barres de progression
/// et alertes — appartient à la story 2.5.
class BudgetScreen extends ConsumerStatefulWidget {
  const BudgetScreen({super.key});

  @override
  ConsumerState<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends ConsumerState<BudgetScreen> {
  /// Un contrôleur par catégorie, créé une fois pour toutes.
  late final Map<String, TextEditingController> _controllers = {
    for (final c in expenseCategories) c.id: TextEditingController(),
  };

  bool _isSaving = false;
  bool _isPrefilled = false;

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  /// Reporte les enveloppes déjà enregistrées dans les champs.
  ///
  /// Une seule fois : réappliquer à chaque rendu écraserait ce que
  /// l'utilisateur est en train de taper.
  void _prefill(Map<String, int> budget) {
    if (_isPrefilled) return;
    _isPrefilled = true;

    for (final entry in budget.entries) {
      _controllers[entry.key]?.text = Currency.formatAmount(entry.value);
    }
  }

  /// Somme de ce qui est actuellement saisi, sans attendre l'enregistrement.
  int get _typedTotal => _controllers.values
      .map((c) => Currency.parse(c.text))
      .fold<int>(0, (sum, amount) => sum + amount);

  Future<void> _save() async {
    if (_isSaving) return;
    setState(() => _isSaving = true);

    final service = ref.read(budgetsServiceProvider);
    final month = DateTime.now();
    String? erreur;

    for (final entry in _controllers.entries) {
      // Un montant nul retire l'enveloppe — le service s'en charge.
      final result = await service.setLimit(
        categoryId: entry.key,
        month: month,
        amount: Currency.parse(entry.value.text),
      );
      if (result case Failure(:final message)) {
        erreur = message;
        break;
      }
    }

    if (!mounted) return;
    setState(() => _isSaving = false);

    if (erreur != null) {
      AppToast.show(context, erreur, type: ToastType.error);
      return;
    }

    ref.invalidate(currentBudgetProvider);
    AppToast.show(context, 'Budget enregistré');
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final budget = ref.watch(currentBudgetProvider);

    return Scaffold(
      backgroundColor: AppColors.surfacePage,
      body: SafeArea(
        child: Column(
          children: [
            const PageHeader(
              title: 'Mon budget',
              leading: HeaderLeadingAction.back,
            ),
            Expanded(
              child: budget.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(AppColors.neutral300),
                  ),
                ),
                error: (_, __) => EmptyState(
                  title: 'Impossible de charger ton budget',
                  subtitle: 'Rien n’est perdu — réessaie dans un instant.',
                  ctaLabel: 'Réessayer',
                  onCtaPressed: () => ref.invalidate(currentBudgetProvider),
                  useSecondaryCta: true,
                ),
                data: (data) {
                  _prefill(data);
                  return _Form(
                    controllers: _controllers,
                    total: _typedTotal,
                    onChanged: () => setState(() {}),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSizes.paddingPage,
                0,
                AppSizes.paddingPage,
                AppSpacing.md,
              ),
              child: PrimaryButton(
                label: 'Enregistrer mon budget',
                isLoading: _isSaving,
                onPressed: budget.hasValue ? _save : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Le mois, le total alloué, puis une ligne par catégorie.
class _Form extends StatelessWidget {
  const _Form({
    required this.controllers,
    required this.total,
    required this.onChanged,
  });

  final Map<String, TextEditingController> controllers;
  final int total;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.paddingPage,
        0,
        AppSizes.paddingPage,
        AppSpacing.xl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Dates.monthYear(DateTime.now()),
            style: AppTypography.headingXs.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total alloué',
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
          ),
          const SizedBox(height: AppSpacing.lg),

          Text(
            'Par catégorie',
            style: AppTypography.headingXs.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Laisse vide une catégorie que tu ne veux pas encadrer.',
            style: AppTypography.headingXxs.copyWith(
              color: AppColors.neutral500,
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          AppCard(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.paddingCard,
              vertical: AppSpacing.sm,
            ),
            child: Column(
              children: [
                for (var i = 0; i < expenseCategories.length; i++) ...[
                  if (i > 0)
                    const Divider(height: 1, color: AppColors.neutral100),
                  _CategoryLimit(
                    category: expenseCategories[i],
                    controller: controllers[expenseCategories[i].id]!,
                    onChanged: onChanged,
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

/// Une catégorie et son enveloppe.
class _CategoryLimit extends StatelessWidget {
  const _CategoryLimit({
    required this.category,
    required this.controller,
    required this.onChanged,
  });

  final ExpenseCategory category;
  final TextEditingController controller;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          IconPill(icon: category.icon, color: category.color, size: 34),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              category.label,
              style: AppTypography.headingXxs.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.onSurface,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: 110,
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.right,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                const CurrencyInputFormatter(),
              ],
              onChanged: (_) => onChanged(),
              style: AppTypography.tabular(
                AppTypography.headingXs.copyWith(fontWeight: FontWeight.w600),
              ),
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                // Un tiret plutôt qu'un zéro : ne rien allouer n'est pas
                // allouer zéro.
                hintText: '—',
                hintStyle: AppTypography.headingXs.copyWith(
                  color: AppColors.neutral300,
                ),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          const SizedBox(width: 4),
          Text(
            'F',
            style: AppTypography.headingXxs.copyWith(
              color: AppColors.neutral500,
            ),
          ),
        ],
      ),
    );
  }
}
