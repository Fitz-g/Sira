import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sira/data/local/app_database.dart';
import 'package:sira/data/models/result.dart';
import 'package:sira/data/services/budgets_service.dart';

void main() {
  late AppDatabase db;
  late BudgetsService service;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    service = BudgetsService(db);
  });

  tearDown(() => db.close());

  Future<Map<String, int>> budgetOf(DateTime month) async =>
      (await service.forMonth(month) as Success<Map<String, int>>).data;

  group('setLimit', () {
    test('enregistre une enveloppe et la relit', () async {
      await service.setLimit(
        categoryId: 'food',
        month: DateTime(2026, 8),
        amount: 150000,
      );

      expect(await budgetOf(DateTime(2026, 8)), {'food': 150000});
    });

    test('range l’enveloppe sur le premier du mois', () async {
      // Sans normalisation, deux enregistrements à des jours différents du
      // même mois créeraient deux lignes.
      await service.setLimit(
        categoryId: 'food',
        month: DateTime(2026, 8, 3),
        amount: 100000,
      );
      await service.setLimit(
        categoryId: 'food',
        month: DateTime(2026, 8, 17),
        amount: 150000,
      );

      expect(await budgetOf(DateTime(2026, 8)), {'food': 150000});
    });

    test('remplace une enveloppe existante sans la dupliquer', () async {
      final month = DateTime(2026, 8);
      await service.setLimit(
        categoryId: 'food',
        month: month,
        amount: 100000,
      );
      await service.setLimit(
        categoryId: 'food',
        month: month,
        amount: 200000,
      );

      expect(await budgetOf(month), {'food': 200000});
    });

    test('un montant nul retire l’enveloppe', () async {
      final month = DateTime(2026, 8);
      await service.setLimit(
        categoryId: 'food',
        month: month,
        amount: 100000,
      );

      await service.setLimit(categoryId: 'food', month: month, amount: 0);

      // Ne rien allouer est une réponse valable : la catégorie disparaît de la
      // carte plutôt que d'y figurer à zéro.
      expect(await budgetOf(month), isEmpty);
    });

    test('les mois sont indépendants', () async {
      await service.setLimit(
        categoryId: 'food',
        month: DateTime(2026, 7),
        amount: 100000,
      );
      await service.setLimit(
        categoryId: 'food',
        month: DateTime(2026, 8),
        amount: 150000,
      );

      expect(await budgetOf(DateTime(2026, 7)), {'food': 100000});
      expect(await budgetOf(DateTime(2026, 8)), {'food': 150000});
    });
  });

  group('forMonth', () {
    test('rend une carte vide quand rien n’est alloué', () async {
      expect(await budgetOf(DateTime(2026, 8)), isEmpty);
    });

    test('omet les catégories sans enveloppe', () async {
      await service.setLimit(
        categoryId: 'food',
        month: DateTime(2026, 8),
        amount: 100000,
      );

      final budget = await budgetOf(DateTime(2026, 8));

      // Absente, et non présente à zéro : ne rien avoir alloué et avoir alloué
      // zéro ne sont pas la même chose.
      expect(budget.containsKey('transport'), isFalse);
    });
  });

  group('mostRecentBefore', () {
    test('rend les enveloppes du dernier mois renseigné', () async {
      await service.setLimit(
        categoryId: 'food',
        month: DateTime(2026, 6),
        amount: 90000,
      );
      await service.setLimit(
        categoryId: 'food',
        month: DateTime(2026, 7),
        amount: 120000,
      );

      final result = await service.mostRecentBefore(DateTime(2026, 8));

      // Juillet, pas juin : c'est le plus récent qui fait foi.
      expect((result as Success<Map<String, int>>).data, {'food': 120000});
    });

    test('ignore les mois postérieurs', () async {
      await service.setLimit(
        categoryId: 'food',
        month: DateTime(2026, 9),
        amount: 200000,
      );

      final result = await service.mostRecentBefore(DateTime(2026, 8));
      expect((result as Success<Map<String, int>>).data, isEmpty);
    });

    test('rend une carte vide sans historique', () async {
      final result = await service.mostRecentBefore(DateTime(2026, 8));
      expect((result as Success<Map<String, int>>).data, isEmpty);
    });
  });

  group('totalForMonth', () {
    test('additionne toutes les enveloppes', () async {
      final month = DateTime(2026, 8);
      await service.setLimit(
        categoryId: 'food',
        month: month,
        amount: 150000,
      );
      await service.setLimit(
        categoryId: 'transport',
        month: month,
        amount: 50000,
      );

      final total = await service.totalForMonth(month);
      expect((total as Success<int>).data, 200000);
    });

    test('vaut zéro sans aucune enveloppe', () async {
      final total = await service.totalForMonth(DateTime(2026, 8));
      expect((total as Success<int>).data, 0);
    });
  });
}
