import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/uemoa_rates.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/currency.dart';
import '../../../shared/widgets/widgets.dart';
import '../domain/simulation_engine.dart';
import '../domain/simulation_models.dart';
import '../../../core/theme/app_icons.dart';

/// Types d'objectif proposés — spécification 03.1, `OBJ-10-3`.
const _goalTypes = <ChipOption>[
  ChipOption(id: 'travel', label: 'Voyager', icon: AppIcons.plane),
  ChipOption(id: 'buy', label: 'Acheter', icon: AppIcons.shoppingCart),
  ChipOption(id: 'save', label: 'Épargner', icon: AppIcons.piggyBank),
  ChipOption(id: 'invest', label: 'Investir', icon: AppIcons.trendingUp),
  ChipOption(id: 'other', label: 'Autre', icon: AppIcons.target),
];

/// Taux retenu par défaut pour l'aperçu.
///
/// Volontairement le plus prudent des taux UEMOA : mieux vaut une estimation
/// que l'utilisateur dépasse qu'une promesse qu'il ne tiendra pas. Le choix du
/// placement viendra sur l'écran de résultat.
const _defaultRate = UemoaRates.savingsAccount;

/// 03.1 — Simulateur.
///
/// L'aperçu se recalcule à chaque frappe et à chaque mouvement du curseur :
/// c'est ce retour immédiat qui rend la projection tangible.
class SimulatorScreen extends StatefulWidget {
  const SimulatorScreen({super.key});

  @override
  State<SimulatorScreen> createState() => _SimulatorScreenState();
}

class _SimulatorScreenState extends State<SimulatorScreen> {
  final _amountController = TextEditingController();

  String? _goalType;
  int _months = 24;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  int get _targetAmount => Currency.parse(_amountController.text);

  bool get _isValid => _targetAmount > 0 && _months >= 1;

  SimulationParams get _params => SimulationParams(
        targetAmount: _targetAmount,
        durationMonths: _months,
        annualRate: _defaultRate,
        inflationRate: UemoaRates.inflation,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            const PageHeader(
              title: 'Simulateur',
              leading: HeaderLeadingAction.back,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingPage,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // S2 — Type d'objectif
                    Text(
                      'Je veux…',
                      style: AppTypography.headingXs.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    SelectionChips(
                      options: _goalTypes,
                      selectedId: _goalType,
                      onSelected: (id) => setState(() => _goalType = id),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // S3 — Montant cible
                    AppInput(
                      label: 'Montant à atteindre',
                      controller: _amountController,
                      variant: AppInputVariant.number,
                      hint: '2 000 000',
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // S4 — Durée
                    DurationSlider(
                      label: 'Dans combien de temps ?',
                      months: _months,
                      onChanged: (value) => setState(() => _months = value),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // S5 — Aperçu, visible dès que la saisie est exploitable
                    if (_isValid) _Preview(params: _params),

                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
            ),

            // S6 — Action
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSizes.paddingPage,
                0,
                AppSizes.paddingPage,
                AppSpacing.md,
              ),
              child: PrimaryButton(
                label: 'Voir ma projection  →',
                onPressed: _isValid
                    ? () => context.push(Routes.simulationResult, extra: _params)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Aperçu recalculé à chaque changement — `OBJ-10-6`.
class _Preview extends StatelessWidget {
  const _Preview({required this.params});

  final SimulationParams params;

  @override
  Widget build(BuildContext context) {
    final monthly = SimulationEngine.requiredMonthlyContribution(
      targetAmount: params.targetAmount,
      initialAmount: params.initialAmount,
      durationMonths: params.durationMonths,
      annualRate: params.annualRate,
    );

    return AppCard(
      variant: AppCardVariant.info,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              text: 'Tu dois épargner environ ',
              style: AppTypography.headingSm.copyWith(
                fontWeight: FontWeight.w400,
              ),
              children: [
                TextSpan(
                  text: Currency.format(monthly),
                  style: AppTypography.headingSm.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                const TextSpan(text: ' par mois.'),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          // Un chiffre financier ne s'affiche jamais sans son hypothèse.
          Text(
            'Estimation sur la base d’une épargne rémunérée à '
            '${Currency.formatRate(params.annualRate)} par an.',
            style: AppTypography.headingXxs.copyWith(
              color: AppColors.neutral700,
            ),
          ),
        ],
      ),
    );
  }
}
