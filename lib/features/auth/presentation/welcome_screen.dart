import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/widgets.dart';
import 'widgets/welcome_illustration.dart';

/// 01.1 — Splash / Welcome.
///
/// Objectif : rassurer en trois secondes, pas convaincre en trente.
/// L'utilisateur arrive souvent d'une recommandation ; il scanne, il ne lit pas.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingPage,
          ),
          child: Column(
            children: [
              // S1 — Illustration, environ 45 % de la hauteur.
              const Expanded(
                flex: 45,
                child: Padding(
                  padding: EdgeInsets.only(top: AppSpacing.lg),
                  child: WelcomeIllustration(),
                ),
              ),

              // S2 — Message de valeur.
              // Aucun espace avant le titre : il forme une unité avec l'illustration.
              Expanded(
                flex: 55,
                child: Column(
                  children: [
                    const Text(
                      'Ton argent, maîtrisé.',
                      style: AppTypography.heading2xl,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'Planifie, épargne et projette ton avenir financier — '
                      'adapté à ta réalité.',
                      style: AppTypography.headingXs.copyWith(
                        fontWeight: FontWeight.w300,
                        color: AppColors.neutral700,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const Spacer(),

                    // S3 — Action principale.
                    PrimaryButton(
                      label: "C'est parti  →",
                      onPressed: () => context.push(Routes.register),
                    ),
                    const SizedBox(height: AppSpacing.sm),

                    // S4 — Sortie pour les comptes existants.
                    TextLink(
                      label: "J'ai déjà un compte",
                      onPressed: () => context.push(Routes.login),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
