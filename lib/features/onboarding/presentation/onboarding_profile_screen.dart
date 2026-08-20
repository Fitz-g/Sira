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

/// 01.3 — Onboarding, étape 1 : profil.
///
/// Deux questions, des fourchettes plutôt que des montants exacts : à ce stade
/// l'utilisateur vient de créer son compte, il coopère tant que ça reste rapide
/// et qu'on ne lui demande pas son salaire au franc près.
class OnboardingProfileScreen extends ConsumerWidget {
  const OnboardingProfileScreen({super.key});

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
                currentStep: 1,
                totalSteps: 3,
                label: 'Étape 1 sur 3',
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
                      'Parle-nous de toi',
                      style: AppTypography.headingXl,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Ces infos restent privées et nous aident à personnaliser '
                      'ton tableau de bord.',
                      style: AppTypography.headingXs.copyWith(
                        fontWeight: FontWeight.w300,
                        color: AppColors.neutral700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // S3 — Revenus
                    Text(
                      'Tes revenus mensuels (environ)',
                      style: AppTypography.headingXs.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    SelectionChips(
                      options: incomeRanges,
                      selectedId: draft.incomeRange,
                      onSelected: notifier.setIncomeRange,
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // S4 — Situation familiale
                    Text(
                      'Ta situation familiale',
                      style: AppTypography.headingXs.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    SelectionChips(
                      options: familySituations,
                      selectedId: draft.familySituation,
                      onSelected: notifier.setFamilySituation,
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
                label: 'Continuer  →',
                onPressed: draft.isProfileComplete
                    ? () => context.push(Routes.onboardingSituation)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
