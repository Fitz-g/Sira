import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/widgets.dart';

/// Connexion — scénario 09.
///
/// Écran encore vide : email, mot de passe, mot de passe oublié.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            const PageHeader(
              title: 'Se connecter',
              variant: PageHeaderVariant.hero,
              leading: HeaderLeadingAction.back,
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.paddingPage),
                  child: Text(
                    'Formulaire de connexion — à construire\n(scénario 09)',
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
