/**
 * Utilitaires de dates — formatage fr-CI / fr-FR.
 */

/**
 * Formate une date en mois + année lisible.
 * @example formatMonthYear(new Date('2026-04-01')) → "Avril 2026"
 */
export function formatMonthYear(date: Date): string {
  return date.toLocaleDateString('fr-FR', { month: 'long', year: 'numeric' });
}

/**
 * Formate une date courte.
 * @example formatDate(new Date('2026-04-06')) → "06/04/2026"
 */
export function formatDate(date: Date): string {
  return date.toLocaleDateString('fr-FR');
}

/**
 * Retourne le premier et dernier jour du mois d'une date donnée.
 */
export function getMonthBounds(date: Date): { start: Date; end: Date } {
  const start = new Date(date.getFullYear(), date.getMonth(), 1);
  const end = new Date(date.getFullYear(), date.getMonth() + 1, 0);
  return { start, end };
}

/**
 * Nombre de mois entre deux dates (arrondi supérieur).
 */
export function monthsBetween(from: Date, to: Date): number {
  const months =
    (to.getFullYear() - from.getFullYear()) * 12 +
    (to.getMonth() - from.getMonth());
  return Math.max(1, months);
}
