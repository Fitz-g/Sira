/// Réponses collectées pendant l'onboarding, avant enregistrement du profil.
///
/// Vit en mémoire le temps des trois étapes ; sera persistée à la dernière.
class OnboardingDraft {
  const OnboardingDraft({
    this.incomeRange,
    this.familySituation,
    this.hasDebts = false,
    this.debtAmount = 0,
    this.hasSavings = false,
    this.savingsAmount = 0,
    this.primaryGoal,
  });

  /// Fourchette de revenus — jamais un montant exact, pour ne pas braquer
  /// l'utilisateur dès la première question (spécification 01.3).
  final String? incomeRange;

  final String? familySituation;

  final bool hasDebts;

  /// Montant total des dettes, en FCFA. Nul tant que [hasDebts] est faux.
  final int debtAmount;

  final bool hasSavings;

  /// Épargne déjà constituée, en FCFA. Nulle tant que [hasSavings] est faux.
  final int savingsAmount;

  final String? primaryGoal;

  /// L'étape 1 exige une réponse aux deux questions.
  bool get isProfileComplete =>
      incomeRange != null && familySituation != null;

  /// L'étape 2 est facultative, mais un interrupteur activé réclame un montant.
  bool get isSituationValid =>
      (!hasDebts || debtAmount > 0) && (!hasSavings || savingsAmount > 0);

  /// L'étape 3 exige un objectif.
  bool get isGoalComplete => primaryGoal != null;

  OnboardingDraft copyWith({
    String? incomeRange,
    String? familySituation,
    bool? hasDebts,
    int? debtAmount,
    bool? hasSavings,
    int? savingsAmount,
    String? primaryGoal,
  }) {
    return OnboardingDraft(
      incomeRange: incomeRange ?? this.incomeRange,
      familySituation: familySituation ?? this.familySituation,
      hasDebts: hasDebts ?? this.hasDebts,
      debtAmount: debtAmount ?? this.debtAmount,
      hasSavings: hasSavings ?? this.hasSavings,
      savingsAmount: savingsAmount ?? this.savingsAmount,
      primaryGoal: primaryGoal ?? this.primaryGoal,
    );
  }
}
