import 'package:intl/intl.dart';

/// Utilitaires de dates — formatage francophone.
abstract final class Dates {
  /// `Avril 2026`
  static String monthYear(DateTime date) {
    final text = DateFormat.yMMMM('fr_FR').format(date);
    return text[0].toUpperCase() + text.substring(1);
  }

  /// `06/04/2026`
  static String short(DateTime date) =>
      DateFormat('dd/MM/yyyy', 'fr_FR').format(date);

  /// `6 avril 2026`
  static String long(DateTime date) =>
      DateFormat('d MMMM yyyy', 'fr_FR').format(date);

  /// Premier et dernier jour du mois contenant [date].
  static ({DateTime start, DateTime end}) monthBounds(DateTime date) => (
        start: DateTime(date.year, date.month, 1),
        end: DateTime(date.year, date.month + 1, 0),
      );

  /// Nombre de mois entre deux dates, minimum 1.
  static int monthsBetween(DateTime from, DateTime to) {
    final months =
        (to.year - from.year) * 12 + (to.month - from.month);
    return months < 1 ? 1 : months;
  }
}
