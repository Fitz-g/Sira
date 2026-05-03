/**
 * Utilitaires monétaires — FCFA uniquement.
 * Règle absolue : tous les montants sont des entiers (jamais de float).
 */

/**
 * Formate un montant entier en FCFA lisible.
 * @example formatCurrency(50000) → "50 000 FCFA"
 * @example formatCurrency(1250000) → "1 250 000 FCFA"
 */
export function formatCurrency(amount: number): string {
  if (!Number.isInteger(amount)) {
    console.warn('[formatCurrency] Montant non entier reçu :', amount);
    amount = Math.round(amount);
  }
  return `${amount.toLocaleString('fr-FR')} FCFA`;
}

/**
 * Formate un montant sans le suffixe FCFA (pour les displays compacts).
 * @example formatAmount(50000) → "50 000"
 */
export function formatAmount(amount: number): string {
  if (!Number.isInteger(amount)) {
    amount = Math.round(amount);
  }
  return amount.toLocaleString('fr-FR');
}

/**
 * Parse une saisie textuelle en entier FCFA.
 * Supprime espaces, virgules, points et le suffixe "FCFA".
 * @example parseCurrency("50 000 FCFA") → 50000
 * @example parseCurrency("1,250,000") → 1250000
 */
export function parseCurrency(input: string): number {
  const cleaned = input.replace(/[^\d]/g, '');
  const parsed = parseInt(cleaned, 10);
  return isNaN(parsed) ? 0 : parsed;
}

/**
 * Formate un taux en pourcentage lisible.
 * @example formatRate(0.065) → "6,5%"
 */
export function formatRate(rate: number): string {
  return `${(rate * 100).toLocaleString('fr-FR', { maximumFractionDigits: 2 })}%`;
}
