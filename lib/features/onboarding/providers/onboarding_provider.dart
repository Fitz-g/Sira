import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/onboarding_draft.dart';

/// Porte les réponses de l'onboarding d'un écran à l'autre.
class OnboardingNotifier extends Notifier<OnboardingDraft> {
  @override
  OnboardingDraft build() => const OnboardingDraft();

  void setIncomeRange(String id) =>
      state = state.copyWith(incomeRange: id);

  void setFamilySituation(String id) =>
      state = state.copyWith(familySituation: id);

  /// Désactiver l'interrupteur remet le montant à zéro : une valeur saisie
  /// puis masquée ne doit pas ressurgir dans le profil.
  void setHasDebts({required bool value}) => state = state.copyWith(
        hasDebts: value,
        debtAmount: value ? state.debtAmount : 0,
      );

  void setDebtAmount(int amount) => state = state.copyWith(debtAmount: amount);

  void setHasSavings({required bool value}) => state = state.copyWith(
        hasSavings: value,
        savingsAmount: value ? state.savingsAmount : 0,
      );

  void setSavingsAmount(int amount) =>
      state = state.copyWith(savingsAmount: amount);

  void setPrimaryGoal(String id) => state = state.copyWith(primaryGoal: id);

  /// Repart d'un brouillon vierge — utilisé si l'utilisateur recommence.
  void reset() => state = const OnboardingDraft();
}

final onboardingProvider =
    NotifierProvider<OnboardingNotifier, OnboardingDraft>(
  OnboardingNotifier.new,
);
