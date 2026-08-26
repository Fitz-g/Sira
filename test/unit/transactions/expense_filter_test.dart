import 'package:flutter_test/flutter_test.dart';
import 'package:sira/features/transactions/domain/expense_filter.dart';

void main() {
  test('démarre sur le mois en cours', () {
    final filter = ExpenseFilter.thisMonth();
    final now = DateTime.now();

    expect(filter.month.year, now.year);
    expect(filter.month.month, now.month);
    expect(filter.month.day, 1); // ramené au premier jour
    expect(filter.isCurrentMonth, isTrue);
  });

  test('recule d’un mois', () {
    final filter = ExpenseFilter(month: DateTime(2026, 8));
    expect(filter.previousMonth().month, DateTime(2026, 7));
  });

  test('franchit correctement le passage d’année', () {
    final janvier = ExpenseFilter(month: DateTime(2026, 1));
    expect(janvier.previousMonth().month, DateTime(2025, 12));

    final decembre = ExpenseFilter(month: DateTime(2025, 12));
    expect(decembre.nextMonth().month, DateTime(2026, 1));
  });

  test('interdit d’aller au-delà du mois en cours', () {
    // Une dépense ne se saisit pas dans le futur : un mois vide par nature
    // n'apprendrait rien.
    expect(ExpenseFilter.thisMonth().canGoForward, isFalse);
  });

  test('autorise l’avance depuis un mois passé', () {
    final filter = ExpenseFilter(month: DateTime(2020, 3));
    expect(filter.canGoForward, isTrue);
  });
}
