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

  /// Libellé d'un jour, relatif quand c'est possible.
  ///
  /// « Aujourd'hui », « Hier », sinon « 15 août ». Un utilisateur qui relit ses
  /// dépenses du jour lit « Aujourd'hui » plus vite qu'une date.
  static String relativeDay(DateTime date, {DateTime? now}) {
    final today = now ?? DateTime.now();
    final jour = DateTime(date.year, date.month, date.day);
    final ceJour = DateTime(today.year, today.month, today.day);
    final ecart = ceJour.difference(jour).inDays;

    if (ecart == 0) return 'Aujourd’hui';
    if (ecart == 1) return 'Hier';

    // L'année n'apparaît que si elle diffère de l'année courante.
    final format = jour.year == ceJour.year ? 'd MMMM' : 'd MMMM yyyy';
    return DateFormat(format, 'fr_FR').format(jour);
  }

  /// Durée en toutes lettres : `8 mois`, `1 an`, `2 ans et 6 mois`.
  static String durationLabel(int months) {
    if (months < 12) return '$months mois';

    final years = months ~/ 12;
    final remainder = months % 12;
    final yearsLabel = years == 1 ? '1 an' : '$years ans';

    if (remainder == 0) return yearsLabel;
    return '$yearsLabel et $remainder mois';
  }

  /// Nombre de mois entre deux dates, minimum 1.
  static int monthsBetween(DateTime from, DateTime to) {
    final months =
        (to.year - from.year) * 12 + (to.month - from.month);
    return months < 1 ? 1 : months;
  }
}
