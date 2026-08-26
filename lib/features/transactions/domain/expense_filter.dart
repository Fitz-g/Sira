/// Ce que l'utilisateur regarde dans la liste des dépenses.
class ExpenseFilter {
  const ExpenseFilter({required this.month});

  /// Mois consulté, ramené à son premier jour.
  final DateTime month;

  /// Le mois en cours — état de départ de la liste.
  factory ExpenseFilter.thisMonth() {
    final now = DateTime.now();
    return ExpenseFilter(month: DateTime(now.year, now.month));
  }

  ExpenseFilter previousMonth() =>
      ExpenseFilter(month: DateTime(month.year, month.month - 1));

  ExpenseFilter nextMonth() =>
      ExpenseFilter(month: DateTime(month.year, month.month + 1));

  /// Peut-on avancer d'un mois ?
  ///
  /// Non au-delà du mois courant : une dépense ne se saisit pas dans le futur,
  /// et un mois vide par nature n'apprendrait rien à l'utilisateur.
  bool get canGoForward {
    final now = DateTime.now();
    return month.isBefore(DateTime(now.year, now.month));
  }

  bool get isCurrentMonth {
    final now = DateTime.now();
    return month.year == now.year && month.month == now.month;
  }
}
