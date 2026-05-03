/**
 * Taux de référence UEMOA — configurables, jamais codés en dur dans les calculs.
 * Source : BCEAO / BRVM / données publiques 2025.
 * FR50 : ces valeurs sont les défauts affichés dans le simulateur.
 */
export const UEMOA_RATES = {
  // Épargne classique (comptes rémunérés, livrets)
  SAVINGS_ACCOUNT:     0.035,  // 3.5%
  // Bons du Trésor UEMOA (court terme ~3 mois)
  TREASURY_BILLS_3M:   0.055,  // 5.5%
  // Bons du Trésor UEMOA (moyen terme ~1 an)
  TREASURY_BILLS_1Y:   0.065,  // 6.5%
  // Obligations d'État UEMOA (long terme)
  GOVERNMENT_BONDS:    0.075,  // 7.5%
  // BRVM — rendement historique moyen
  BRVM_AVERAGE:        0.085,  // 8.5%
  // Inflation UEMOA (référence BCEAO)
  INFLATION:           0.030,  // 3.0%
  // Taux de crédit à la consommation (référence remboursement dettes)
  CONSUMER_CREDIT:     0.150,  // 15%
} as const;

export type UEMOARateKey = keyof typeof UEMOA_RATES;
