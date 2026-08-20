import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sira/core/theme/app_theme.dart';
import 'package:sira/features/onboarding/presentation/onboarding_profile_screen.dart';
import 'package:sira/features/onboarding/presentation/onboarding_situation_screen.dart';
import 'package:sira/features/onboarding/providers/onboarding_provider.dart';
import 'package:sira/shared/widgets/widgets.dart';

Widget _wrap(Widget screen) => ProviderScope(
      child: MaterialApp(theme: AppTheme.light, home: screen),
    );

/// Le bouton principal est-il actionnable ?
bool _isCtaEnabled(WidgetTester tester) {
  final button = tester.widget<PrimaryButton>(find.byType(PrimaryButton));
  return button.onPressed != null;
}

void main() {
  group('01.3 — Profil', () {
    testWidgets('le bouton reste inactif tant qu’une question est sans réponse',
        (tester) async {
      await tester.pumpWidget(_wrap(const OnboardingProfileScreen()));

      expect(_isCtaEnabled(tester), isFalse);

      // Une seule des deux questions renseignée.
      await tester.tap(find.text('Célibataire'));
      await tester.pump();
      expect(_isCtaEnabled(tester), isFalse);

      await tester.tap(find.text('Moins de 150 000 F'));
      await tester.pump();
      expect(_isCtaEnabled(tester), isTrue);
    });

    testWidgets('la sélection des revenus est exclusive', (tester) async {
      late WidgetRef capturedRef;
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.light,
            home: Consumer(
              builder: (context, ref, _) {
                capturedRef = ref;
                return const OnboardingProfileScreen();
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Moins de 150 000 F'));
      await tester.pump();
      expect(
        capturedRef.read(onboardingProvider).incomeRange,
        'under_150k',
      );

      await tester.tap(find.text('Plus de 1 000 000 F'));
      await tester.pump();
      expect(capturedRef.read(onboardingProvider).incomeRange, 'over_1m');
    });
  });

  group('01.4 — Situation', () {
    testWidgets('le champ montant n’apparaît qu’une fois l’interrupteur activé',
        (tester) async {
      await tester.pumpWidget(_wrap(const OnboardingSituationScreen()));

      expect(find.text('Montant total estimé'), findsNothing);

      await tester.tap(find.text('J’ai des dettes en cours'));
      await tester.pumpAndSettle();

      expect(find.text('Montant total estimé'), findsOneWidget);
    });

    testWidgets('activer sans renseigner le montant bloque la suite',
        (tester) async {
      await tester.pumpWidget(_wrap(const OnboardingSituationScreen()));

      // Sans rien déclarer, l'étape est valide : elle est facultative.
      expect(_isCtaEnabled(tester), isTrue);

      await tester.tap(find.text('J’ai déjà de l’épargne'));
      await tester.pumpAndSettle();
      expect(_isCtaEnabled(tester), isFalse);

      await tester.enterText(find.byType(TextField), '200000');
      await tester.pump();
      expect(_isCtaEnabled(tester), isTrue);
    });

    testWidgets('désactiver l’interrupteur remet le montant à zéro',
        (tester) async {
      late WidgetRef capturedRef;
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.light,
            home: Consumer(
              builder: (context, ref, _) {
                capturedRef = ref;
                return const OnboardingSituationScreen();
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('J’ai des dettes en cours'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), '500000');
      await tester.pump();
      expect(capturedRef.read(onboardingProvider).debtAmount, 500000);

      // Un montant saisi puis masqué ne doit pas ressurgir dans le profil.
      await tester.tap(find.text('J’ai des dettes en cours'));
      await tester.pumpAndSettle();
      expect(capturedRef.read(onboardingProvider).debtAmount, 0);
      expect(capturedRef.read(onboardingProvider).hasDebts, isFalse);
    });
  });
}
