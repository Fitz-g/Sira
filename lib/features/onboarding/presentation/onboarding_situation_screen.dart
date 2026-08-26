import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/currency.dart';
import '../../../shared/widgets/widgets.dart';
import '../providers/onboarding_provider.dart';

/// 01.4 — Onboarding, étape 2 : situation financière.
///
/// L'écran le plus délicat du parcours : on demande à quelqu'un d'avouer ses
/// dettes. D'où le ton du sous-titre, le caractère facultatif de l'étape et le
/// lien pour la passer.
class OnboardingSituationScreen extends ConsumerStatefulWidget {
  const OnboardingSituationScreen({super.key});

  @override
  ConsumerState<OnboardingSituationScreen> createState() =>
      _OnboardingSituationScreenState();
}

class _OnboardingSituationScreenState
    extends ConsumerState<OnboardingSituationScreen> {
  final _debtController = TextEditingController();
  final _savingsController = TextEditingController();

  @override
  void dispose() {
    _debtController.dispose();
    _savingsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final draft = ref.watch(onboardingProvider);
    final notifier = ref.read(onboardingProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.surfacePage,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(
                AppSizes.paddingPage,
                AppSpacing.md,
                AppSizes.paddingPage,
                0,
              ),
              child: StepProgressBar(
                currentStep: 2,
                totalSteps: 3,
                label: 'Étape 2 sur 3',
              ),
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
                    const Text(
                      'Ta situation aujourd’hui',
                      style: AppTypography.headingXl,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Pas de jugement ici. Ces infos nous aident à construire '
                      'ton plan personnalisé.',
                      style: AppTypography.headingXs.copyWith(
                        fontWeight: FontWeight.w300,
                        color: AppColors.neutral700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // S3 — Dettes
                    LabeledSwitch(
                      label: 'J’ai des dettes en cours',
                      value: draft.hasDebts,
                      onChanged: (value) {
                        notifier.setHasDebts(value: value);
                        if (!value) _debtController.clear();
                      },
                    ),
                    _RevealedField(
                      isVisible: draft.hasDebts,
                      child: Padding(
                        padding: const EdgeInsets.only(top: AppSpacing.md),
                        child: AppInput(
                          label: 'Montant total estimé',
                          controller: _debtController,
                          variant: AppInputVariant.number,
                          hint: '500 000',
                          onChanged: (text) =>
                              notifier.setDebtAmount(Currency.parse(text)),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // S4 — Épargne
                    LabeledSwitch(
                      label: 'J’ai déjà de l’épargne',
                      value: draft.hasSavings,
                      onChanged: (value) {
                        notifier.setHasSavings(value: value);
                        if (!value) _savingsController.clear();
                      },
                    ),
                    _RevealedField(
                      isVisible: draft.hasSavings,
                      child: Padding(
                        padding: const EdgeInsets.only(top: AppSpacing.md),
                        child: AppInput(
                          label: 'Montant épargné',
                          controller: _savingsController,
                          variant: AppInputVariant.number,
                          hint: '200 000',
                          onChanged: (text) =>
                              notifier.setSavingsAmount(Currency.parse(text)),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
            ),
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
                    label: 'Continuer  →',
                    onPressed: draft.isSituationValid
                        ? () => context.push(Routes.onboardingGoal)
                        : null,
                  ),
                  TextLink(
                    label: 'Passer cette étape',
                    onPressed: () => context.push(Routes.onboardingGoal),
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

/// Champ qui se déplie sous son interrupteur.
class _RevealedField extends StatelessWidget {
  const _RevealedField({required this.isVisible, required this.child});

  final bool isVisible;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      alignment: Alignment.topCenter,
      child: isVisible ? child : const SizedBox(width: double.infinity),
    );
  }
}
