import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sira/data/local/app_database.dart';
import 'package:sira/data/models/result.dart';
import 'package:sira/data/services/transactions_service.dart';
import 'package:sira/features/transactions/domain/expense_grouping.dart';

void main() {
  late AppDatabase db;
  late TransactionsService service;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    service = TransactionsService(db);
  });

  tearDown(() => db.close());

  /// Enregistre des dépenses puis renvoie leur regroupement par journée.
  Future<List<ExpenseDay>> grouped(List<(int, DateTime)> entries) async {
    for (final (amount, date) in entries) {
      await service.add(amount: amount, categoryId: 'food', date: date);
    }
    final result = await service.forMonth(entries.first.$2);
    return groupByDay((result as Success<List<Transaction>>).data);
  }

  test('réunit les dépenses d’une même journée', () async {
    final days = await grouped([
      (1000, DateTime(2026, 8, 15, 9)),
      (2000, DateTime(2026, 8, 15, 18)),
      (3000, DateTime(2026, 8, 16, 12)),
    ]);

    expect(days, hasLength(2));
    expect(days.first.expenses, hasLength(1)); // le 16
    expect(days.last.expenses, hasLength(2)); // le 15
  });

  test('place la journée la plus récente en premier', () async {
    final days = await grouped([
      (1000, DateTime(2026, 8, 10)),
      (2000, DateTime(2026, 8, 20)),
      (3000, DateTime(2026, 8, 15)),
    ]);

    expect(days.map((d) => d.date.day), [20, 15, 10]);
  });

  test('ordonne aussi les dépenses au sein d’une journée', () async {
    final days = await grouped([
      (1000, DateTime(2026, 8, 15, 8)),
      (2000, DateTime(2026, 8, 15, 20)),
      (3000, DateTime(2026, 8, 15, 14)),
    ]);

    // La plus récente d'abord, comme dans la liste générale.
    expect(days.single.expenses.map((e) => e.amount), [2000, 3000, 1000]);
  });

  test('totalise la journée', () async {
    final days = await grouped([
      (1500, DateTime(2026, 8, 15, 9)),
      (2500, DateTime(2026, 8, 15, 18)),
    ]);

    expect(days.single.total, 4000);
  });

  test('ne rend aucune journée sans dépense', () {
    expect(groupByDay([]), isEmpty);
  });
}
