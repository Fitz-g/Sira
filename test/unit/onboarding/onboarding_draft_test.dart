import 'package:flutter_test/flutter_test.dart';
import 'package:sira/features/onboarding/domain/onboarding_draft.dart';

void main() {
  group('isProfileComplete', () {
    test('exige les deux réponses de l’étape 1', () {
      const vide = OnboardingDraft();
      expect(vide.isProfileComplete, isFalse);

      final partiel = vide.copyWith(incomeRange: 'under_150k');
      expect(partiel.isProfileComplete, isFalse);

      final complet = partiel.copyWith(familySituation: 'single');
      expect(complet.isProfileComplete, isTrue);
    });
  });

  group('isSituationValid', () {
    test('une étape 2 laissée vide reste valide', () {
      // L'étape est facultative : ne rien déclarer est une réponse.
      expect(const OnboardingDraft().isSituationValid, isTrue);
    });

    test('un interrupteur activé réclame un montant', () {
      const avecDettes = OnboardingDraft(hasDebts: true);
      expect(avecDettes.isSituationValid, isFalse);

      final renseigne = avecDettes.copyWith(debtAmount: 500000);
      expect(renseigne.isSituationValid, isTrue);
    });

    test('vaut aussi pour l’épargne', () {
      const avecEpargne = OnboardingDraft(hasSavings: true);
      expect(avecEpargne.isSituationValid, isFalse);

      final renseigne = avecEpargne.copyWith(savingsAmount: 200000);
      expect(renseigne.isSituationValid, isTrue);
    });
  });

  group('isGoalComplete', () {
    test('exige un objectif', () {
      expect(const OnboardingDraft().isGoalComplete, isFalse);
      expect(
        const OnboardingDraft(primaryGoal: 'budget').isGoalComplete,
        isTrue,
      );
    });
  });
}
