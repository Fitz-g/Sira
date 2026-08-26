import '../../../data/local/app_database.dart';

/// Les dépenses d'une même journée.
class ExpenseDay {
  const ExpenseDay({required this.date, required this.expenses});

  /// Jour concerné, ramené à minuit.
  final DateTime date;

  final List<Transaction> expenses;

  /// Somme dépensée ce jour-là, en FCFA entiers.
  int get total => expenses.fold(0, (sum, e) => sum + e.amount);
}

/// Regroupe des dépenses par journée, du jour le plus récent au plus ancien.
///
/// Calcul pur : aucune dépendance à Flutter ni à la base, donc testable seul.
List<ExpenseDay> groupByDay(List<Transaction> expenses) {
  final parJour = <DateTime, List<Transaction>>{};

  for (final expense in expenses) {
    final jour = DateTime(
      expense.date.year,
      expense.date.month,
      expense.date.day,
    );
    parJour.putIfAbsent(jour, () => []).add(expense);
  }

  final jours = parJour.keys.toList()..sort((a, b) => b.compareTo(a));

  return [
    for (final jour in jours)
      ExpenseDay(
        date: jour,
        // À l'intérieur d'une journée, la dépense la plus récente d'abord.
        expenses: parJour[jour]!..sort((a, b) => b.date.compareTo(a.date)),
      ),
  ];
}
