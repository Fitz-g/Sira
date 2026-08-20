/// Entrées et sorties du moteur de simulation.
///
/// Tous les montants sont des entiers FCFA. Les taux sont des fractions
/// décimales : 0.065 signifie 6,5 % par an.
library;

/// Paramètres d'une projection d'épargne.
class SimulationParams {
  const SimulationParams({
    required this.targetAmount,
    required this.durationMonths,
    required this.annualRate,
    this.initialAmount = 0,
    this.inflationRate = 0,
  });

  /// Montant visé à l'échéance.
  final int targetAmount;

  /// Horizon en mois. Doit être strictement positif.
  final int durationMonths;

  /// Rendement annuel attendu du placement (0.065 = 6,5 %).
  final double annualRate;

  /// Épargne déjà disponible au départ.
  final int initialAmount;

  /// Inflation annuelle, pour exprimer le résultat en pouvoir d'achat
  /// d'aujourd'hui (FR22). Zéro désactive le calcul.
  final double inflationRate;
}

/// Un point de la courbe de projection.
class SimulationPoint {
  const SimulationPoint({required this.month, required this.amount});

  /// 0 = aujourd'hui, 1 = après le premier versement, etc.
  final int month;

  /// Capital cumulé à ce mois, intérêts compris.
  final int amount;
}

/// Résultat d'une projection.
class SimulationResult {
  const SimulationResult({
    required this.monthlyContribution,
    required this.finalAmount,
    required this.totalContributed,
    required this.interestEarned,
    required this.realFinalAmount,
    required this.points,
  });

  /// Versement mensuel nécessaire pour atteindre la cible.
  ///
  /// Arrondi à l'entier supérieur : mieux vaut dépasser la cible de quelques
  /// francs que de l'atteindre à moitié.
  final int monthlyContribution;

  /// Capital atteint à l'échéance avec ce versement.
  final int finalAmount;

  /// Somme des versements, apport initial compris.
  final int totalContributed;

  /// Part du capital final produite par les intérêts.
  final int interestEarned;

  /// [finalAmount] exprimé en pouvoir d'achat d'aujourd'hui.
  ///
  /// Égal à [finalAmount] si aucune inflation n'a été fournie.
  final int realFinalAmount;

  /// Courbe mois par mois, de 0 à `durationMonths`.
  final List<SimulationPoint> points;
}
