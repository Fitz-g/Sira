import 'dart:math' as math;

import 'simulation_models.dart';

/// Moteur de projection d'épargne — calcul pur, local, sans effet de bord.
///
/// Aucun appel réseau, aucun accès à un provider, aucune navigation :
/// ces fonctions sont testables isolément et tournent hors ligne, ce qui
/// permet de tenir la contrainte de recalcul sous 500 ms (NFR-P3).
///
/// **Convention de taux :** le taux mensuel vaut le taux annuel divisé par 12.
/// C'est la convention des produits d'épargne courants — et non la conversion
/// actuarielle `(1 + annuel)^(1/12) - 1`, qui donnerait un résultat légèrement
/// inférieur et surprendrait un utilisateur comparant avec son relevé bancaire.
///
/// **Versements en fin de période :** on considère que le versement du mois
/// intervient après que les intérêts du mois ont couru. C'est l'hypothèse
/// prudente : elle ne surestime jamais le capital atteint.
abstract final class SimulationEngine {
  /// Calcule la projection complète pour [params].
  ///
  /// Détermine d'abord le versement mensuel nécessaire pour atteindre
  /// `targetAmount`, puis déroule la courbe mois par mois avec ce versement.
  static SimulationResult project(SimulationParams params) {
    assert(params.durationMonths > 0, 'La durée doit être positive.');
    assert(params.annualRate >= 0, 'Le taux ne peut pas être négatif.');

    final monthlyContribution = requiredMonthlyContribution(
      targetAmount: params.targetAmount,
      initialAmount: params.initialAmount,
      durationMonths: params.durationMonths,
      annualRate: params.annualRate,
    );

    final points = _buildCurve(
      initialAmount: params.initialAmount,
      monthlyContribution: monthlyContribution,
      durationMonths: params.durationMonths,
      annualRate: params.annualRate,
    );

    final finalAmount = points.last.amount;
    final totalContributed =
        params.initialAmount + monthlyContribution * params.durationMonths;

    return SimulationResult(
      monthlyContribution: monthlyContribution,
      finalAmount: finalAmount,
      totalContributed: totalContributed,
      interestEarned: math.max(0, finalAmount - totalContributed),
      realFinalAmount: adjustForInflation(
        amount: finalAmount,
        annualInflation: params.inflationRate,
        durationMonths: params.durationMonths,
      ),
      points: points,
    );
  }

  /// Versement mensuel nécessaire pour atteindre [targetAmount].
  ///
  /// Retourne 0 si l'apport initial suffit à lui seul.
  /// Le résultat est arrondi à l'entier supérieur.
  static int requiredMonthlyContribution({
    required int targetAmount,
    required int initialAmount,
    required int durationMonths,
    required double annualRate,
  }) {
    if (durationMonths <= 0) return 0;

    final monthlyRate = annualRate / 12;
    final growth = math.pow(1 + monthlyRate, durationMonths).toDouble();

    // Ce que l'apport initial vaudra à l'échéance, sans aucun versement.
    final initialGrown = initialAmount * growth;
    final gap = targetAmount - initialGrown;

    // L'apport initial couvre déjà l'objectif.
    if (gap <= 0) return 0;

    // Taux nul : la cible se répartit simplement sur la durée.
    if (monthlyRate == 0) return (gap / durationMonths).ceil();

    // Valeur acquise d'une suite de versements de 1 F par mois.
    final annuityFactor = (growth - 1) / monthlyRate;
    return (gap / annuityFactor).ceil();
  }

  /// Capital atteint après [durationMonths] pour un versement donné.
  static int projectedAmount({
    required int initialAmount,
    required int monthlyContribution,
    required int durationMonths,
    required double annualRate,
  }) {
    final curve = _buildCurve(
      initialAmount: initialAmount,
      monthlyContribution: monthlyContribution,
      durationMonths: durationMonths,
      annualRate: annualRate,
    );
    return curve.last.amount;
  }

  /// Exprime [amount] en pouvoir d'achat d'aujourd'hui (FR22).
  ///
  /// Sans inflation renseignée, retourne [amount] inchangé.
  static int adjustForInflation({
    required int amount,
    required double annualInflation,
    required int durationMonths,
  }) {
    if (annualInflation <= 0) return amount;
    final years = durationMonths / 12;
    final erosion = math.pow(1 + annualInflation, years).toDouble();
    return (amount / erosion).round();
  }

  /// Déroule la courbe mois par mois.
  ///
  /// Le calcul est itératif plutôt que fermé : c'est la même boucle qui produit
  /// le montant final et les points du graphique, ce qui évite qu'un arrondi
  /// fasse diverger la courbe affichée du chiffre annoncé.
  static List<SimulationPoint> _buildCurve({
    required int initialAmount,
    required int monthlyContribution,
    required int durationMonths,
    required double annualRate,
  }) {
    final monthlyRate = annualRate / 12;
    final points = <SimulationPoint>[
      SimulationPoint(month: 0, amount: initialAmount),
    ];

    var balance = initialAmount.toDouble();
    for (var month = 1; month <= durationMonths; month++) {
      balance = balance * (1 + monthlyRate) + monthlyContribution;
      points.add(SimulationPoint(month: month, amount: balance.round()));
    }

    return points;
  }
}
