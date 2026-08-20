import 'package:intl/intl.dart';

/// Utilitaires monétaires — FCFA uniquement.
///
/// Règle absolue du projet : tout montant est un entier.
/// Le franc CFA n'a pas de subdivision en circulation.
abstract final class Currency {
  static final _formatter = NumberFormat.decimalPattern('fr_FR');

  /// Formate un montant avec le suffixe de devise.
  ///
  /// `format(50000)` → `50 000 FCFA`
  static String format(int amount) => '${formatAmount(amount)} FCFA';

  /// Formate un montant sans suffixe, pour les affichages compacts.
  ///
  /// `formatAmount(1250000)` → `1 250 000`
  static String formatAmount(int amount) =>
      _formatter.format(amount).replaceAll(' ', ' ');

  /// Format abrégé pour les axes de graphique, où la place manque.
  ///
  /// `compact(2000000)` → `2 M` · `compact(500000)` → `500 k`
  static String compact(int amount) =>
      NumberFormat.compact(locale: 'fr_FR').format(amount);

  /// Convertit une saisie libre en entier FCFA.
  ///
  /// Retire espaces, séparateurs et suffixes.
  /// `parse('50 000 FCFA')` → `50000`
  static int parse(String input) {
    final digits = input.replaceAll(RegExp(r'[^\d]'), '');
    return int.tryParse(digits) ?? 0;
  }

  /// Formate un taux exprimé en fraction décimale.
  ///
  /// `formatRate(0.065)` → `6,5 %`
  static String formatRate(double rate) {
    final percent = rate * 100;
    final text = NumberFormat('0.##', 'fr_FR').format(percent);
    return '$text %';
  }
}
