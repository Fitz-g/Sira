import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/widgets.dart';

/// 01.2 — Inscription.
///
/// Écran encore à construire : Google SSO, séparateur, puis trois champs
/// (nom, email, mot de passe). Il n'y a rien à authentifier tant qu'aucun
/// backend n'est branché ; le bouton laisse simplement continuer vers
/// l'onboarding, pour que le parcours soit praticable de bout en bout.
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            const PageHeader(
              title: 'Créer un compte',
              variant: PageHeaderVariant.hero,
              leading: HeaderLeadingAction.back,
            ),
            const Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(AppSizes.paddingPage),
                  child: AppCard(
                    variant: AppCardVariant.info,
                    child: Text(
                      'Formulaire d’inscription à construire — '
                      'spécification 01.2.\n\n'
                      'Il demandera la création d’un projet Supabase pour '
                      'authentifier réellement.',
                      style: AppTypography.headingXs,
                    ),
                  ),
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
                label: 'Continuer vers l’onboarding  →',
                // TODO(auth): remplacer par la vraie création de compte.
                onPressed: () => context.push(Routes.onboardingProfile),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
