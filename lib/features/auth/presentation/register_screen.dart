import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/widgets.dart';

/// 01.2 — Inscription.
///
/// Écran encore vide : la spécification prévoit Google SSO, un séparateur,
/// puis un formulaire à trois champs (nom, email, mot de passe).
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
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.paddingPage),
                  child: Text(
                    'Formulaire d’inscription — à construire\n(spécification 01.2)',
                    style: AppTypography.headingXxs
                        .copyWith(color: AppColors.neutral500),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
