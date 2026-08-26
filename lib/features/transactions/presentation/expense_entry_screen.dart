import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/expense_categories.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/currency.dart';
import '../../../core/utils/currency_input_formatter.dart';
import '../../../data/models/result.dart';
import '../../../shared/widgets/widgets.dart';
import '../providers/transactions_provider.dart';

/// 02.1 — Saisie d'une dépense.
///
/// Conçue pour quinze secondes, debout, dehors : le clavier numérique s'ouvre
/// seul, les catégories défilent sous le pouce, la note est facultative. Chaque
/// geste économisé est une chance de plus que l'habitude tienne.
class ExpenseEntryScreen extends ConsumerStatefulWidget {
  const ExpenseEntryScreen({super.key});

  @override
  ConsumerState<ExpenseEntryScreen> createState() => _ExpenseEntryScreenState();
}

class _ExpenseEntryScreenState extends ConsumerState<ExpenseEntryScreen> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  String? _categoryId;
  bool _isSaving = false;

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  int get _amount => Currency.parse(_amountController.text);

  Future<void> _save() async {
    if (_amount <= 0 || _isSaving) return;
    setState(() => _isSaving = true);

    final result = await ref.read(transactionsServiceProvider).add(
          amount: _amount,
          // Sans choix explicite, la dépense atterrit dans « Autre » : mieux
          // vaut une dépense mal classée qu'une dépense jamais saisie.
          categoryId: _categoryId ?? 'other',
          note: _noteController.text,
        );

    if (!mounted) return;
    setState(() => _isSaving = false);

    switch (result) {
      case Success():
        // Le mois affiché ailleurs doit refléter la nouvelle dépense.
        ref.invalidate(currentMonthExpensesProvider);
        Navigator.of(context).pop(true);
      case Failure(:final message):
        AppToast.show(context, message, type: ToastType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfacePage,
      body: SafeArea(
        child: Column(
          children: [
            PageHeader(
              title: 'Nouvelle dépense',
              leading: HeaderLeadingAction.close,
              onLeadingPressed: () => Navigator.of(context).pop(),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingPage,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.lg),

                    // S2 — Le montant, seul champ qui compte vraiment.
                    _AmountField(
                      controller: _amountController,
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // S3 — Catégories, sous le pouce.
                    Text(
                      'Catégorie',
                      style: AppTypography.headingXs.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    SelectionChips(
                      layout: ChipsLayout.scroll,
                      options: [
                        for (final c in expenseCategories)
                          ChipOption(id: c.id, label: c.label, icon: c.icon),
                      ],
                      selectedId: _categoryId,
                      onSelected: (id) => setState(() => _categoryId = id),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // S4 — Note, facultative par conception.
                    AppInput(
                      label: 'Note',
                      controller: _noteController,
                      optional: true,
                      hint: 'Ex : déjeuner avec des collègues',
                      maxLength: 60,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
            ),

            // S5 — Enregistrement.
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSizes.paddingPage,
                0,
                AppSizes.paddingPage,
                AppSpacing.md,
              ),
              child: PrimaryButton(
                label: 'Enregistrer',
                isLoading: _isSaving,
                onPressed: _amount > 0 ? _save : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Affichage et saisie du montant — `OBJ-07-2`.
///
/// Le champ prend le focus à l'ouverture : c'est ce qui fait gagner le premier
/// geste, et c'est le cœur de la promesse des quinze secondes.
class _AmountField extends StatelessWidget {
  const _AmountField({required this.controller, required this.onChanged});

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            autofocus: true,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.right,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              const CurrencyInputFormatter(),
            ],
            onChanged: onChanged,
            style: AppTypography.tabular(AppTypography.heading4xl),
            decoration: InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
              hintText: '0',
              hintStyle: AppTypography.heading4xl.copyWith(
                color: AppColors.neutral300,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          'FCFA',
          style: AppTypography.headingMd.copyWith(
            color: AppColors.neutral500,
          ),
        ),
      ],
    );
  }
}
