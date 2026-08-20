/// Taux de référence UEMOA — FR50 : configurables, jamais codés en dur
/// dans les calculs du moteur de simulation.
///
/// Sources : BCEAO, BRVM, données publiques.
/// Ces valeurs alimentent les champs du simulateur par défaut.
abstract final class UemoaRates {
  /// Épargne classique — comptes rémunérés et livrets.
  static const savingsAccount = 0.035;

  /// Bons du Trésor UEMOA à court terme (≈ 3 mois).
  static const treasuryBills3m = 0.055;

  /// Bons du Trésor UEMOA à moyen terme (≈ 1 an).
  static const treasuryBills1y = 0.065;

  /// Obligations d'État UEMOA à long terme.
  static const governmentBonds = 0.075;

  /// BRVM — rendement historique moyen.
  static const brvmAverage = 0.085;

  /// Inflation de référence BCEAO.
  static const inflation = 0.030;

  /// Crédit à la consommation — référence pour les plans de remboursement.
  static const consumerCredit = 0.150;

  /// Libellés affichables des placements proposés dans le simulateur.
  static const Map<String, ({String label, double rate})> instruments = {
    'savings': (label: 'Épargne classique', rate: savingsAccount),
    'treasury_3m': (label: 'Bons du Trésor 3 mois', rate: treasuryBills3m),
    'treasury_1y': (label: 'Bons du Trésor 1 an', rate: treasuryBills1y),
    'bonds': (label: "Obligations d'État", rate: governmentBonds),
    'brvm': (label: 'Actions BRVM', rate: brvmAverage),
  };
}
