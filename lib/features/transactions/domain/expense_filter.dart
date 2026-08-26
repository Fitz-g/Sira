/// Ce que l'utilisateur regarde dans la liste des dépenses.
class ExpenseFilter {
  const ExpenseFilter({required this.month, this.categoryId});

  /// Mois consulté, ramené à son premier jour.
  final DateTime month;

  /// Catégorie retenue, ou `null` pour toutes.
  final String? categoryId;

  /// Le mois en cours, toutes catégories — état de départ de la liste.
  factory ExpenseFilter.thisMonth() {
    final now = DateTime.now();
    return ExpenseFilter(month: DateTime(now.year, now.month));
  }

  /// Changer de mois conserve la catégorie retenue : on suit une dépense dans
  /// le temps, on ne recommence pas son filtrage à chaque pas.
  ExpenseFilter previousMonth() => ExpenseFilter(
        month: DateTime(month.year, month.month - 1),
        categoryId: categoryId,
      );

  ExpenseFilter nextMonth() => ExpenseFilter(
        month: DateTime(month.year, month.month + 1),
        categoryId: categoryId,
      );

  ExpenseFilter withCategory(String? id) =>
      ExpenseFilter(month: month, categoryId: id);

  bool get hasCategory => categoryId != null;

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
