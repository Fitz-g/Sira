import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/widgets.dart';
import '../domain/onboarding_options.dart';
import '../providers/onboarding_provider.dart';

/// 01.5 — Onboarding, étape 3 : objectif principal.
///
/// Dernière étape avant le tableau de bord. La barre de progression est pleine
/// et le libellé annonce la fin : c'est ce qui empêche l'abandon au dernier pas.
class OnboardingGoalScreen extends ConsumerWidget {
  const OnboardingGoalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final draft = ref.watch(onboardingProvider);
    final notifier = ref.read(onboardingProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.surface,
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
                currentStep: 3,
                totalSteps: 3,
                label: 'Dernière étape !',
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
                      'Quel est ton objectif principal ?',
                      style: AppTypography.headingXl,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Tu pourras en ajouter d’autres plus tard.',
                      style: AppTypography.headingXs.copyWith(
                        fontWeight: FontWeight.w300,
                        color: AppColors.neutral700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    SelectionCardGrid(
                      options: primaryGoals,
                      selectedId: draft.primaryGoal,
                      onSelected: notifier.setPrimaryGoal,
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
                AppSpacing.md,
              ),
              child: PrimaryButton(
                label: 'Voir mon tableau de bord  →',
                onPressed: draft.isGoalComplete
                    // `go` et non `push` : l'onboarding est terminé, on ne
                    // revient pas en arrière dessus.
                    ? () => context.go(Routes.dashboard)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
