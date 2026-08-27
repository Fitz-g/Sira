import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sira/data/local/app_database.dart';
import 'package:sira/data/models/result.dart';
import 'package:sira/data/services/transactions_service.dart';

void main() {
  late AppDatabase db;
  late TransactionsService service;

  setUp(() {
    // Base en mémoire : isolée, jetable, aucun fichier laissé derrière.
    db = AppDatabase.forTesting(NativeDatabase.memory());
    service = TransactionsService(db);
  });

  tearDown(() => db.close());

  group('add', () {
    test('enregistre une dépense et la relit à l’identique', () async {
      final added = await service.add(
        amount: 12500,
        categoryId: 'food',
        note: 'Déjeuner',
        date: DateTime(2026, 8, 15),
      );
      expect(added.isSuccess, isTrue);

      final result = await service.forMonth(DateTime(2026, 8));
      final rows = (result as Success<List<Transaction>>).data;

      expect(rows, hasLength(1));
      expect(rows.single.amount, 12500);
      expect(rows.single.categoryId, 'food');
      expect(rows.single.note, 'Déjeuner');
    });

    test('le montant reste un entier de bout en bout', () async {
      await service.add(amount: 999999999, categoryId: 'other');

      final result = await service.forMonth(DateTime.now());
      final rows = (result as Success<List<Transaction>>).data;

      // Un REAL en base introduirait un arrondi ; le type doit rester int.
      expect(rows.single.amount, isA<int>());
      expect(rows.single.amount, 999999999);
    });

    test('refuse un montant nul ou négatif', () async {
      final zero = await service.add(amount: 0, categoryId: 'food');
      final negatif = await service.add(amount: -100, categoryId: 'food');

      expect(zero.isSuccess, isFalse);
      expect(negatif.isSuccess, isFalse);

      final result = await service.forMonth(DateTime.now());
      expect((result as Success<List<Transaction>>).data, isEmpty);
    });

    test('sans catégorie, classe la dépense dans « Autre »', () async {
      await service.add(amount: 5000, categoryId: '');

      final result = await service.forMonth(DateTime.now());
      final rows = (result as Success<List<Transaction>>).data;

      expect(rows.single.categoryId, 'other');
    });

    test('une note vide est enregistrée comme absente', () async {
      await service.add(amount: 5000, categoryId: 'food', note: '   ');

      final result = await service.forMonth(DateTime.now());
      expect((result as Success<List<Transaction>>).data.single.note, isNull);
    });
  });

  group('forMonth', () {
    test('ne retient que le mois demandé', () async {
      await service.add(
        amount: 1000,
        categoryId: 'food',
        date: DateTime(2026, 7, 31),
      );
      await service.add(
        amount: 2000,
        categoryId: 'food',
        date: DateTime(2026, 8, 1),
      );
      await service.add(
        amount: 3000,
        categoryId: 'food',
        date: DateTime(2026, 9, 1),
      );

      final result = await service.forMonth(DateTime(2026, 8));
      final rows = (result as Success<List<Transaction>>).data;

      expect(rows, hasLength(1));
      expect(rows.single.amount, 2000);
    });

    test('rend les dépenses de la plus récente à la plus ancienne', () async {
      await service.add(
        amount: 1000,
        categoryId: 'food',
        date: DateTime(2026, 8, 5),
      );
      await service.add(
        amount: 2000,
        categoryId: 'food',
        date: DateTime(2026, 8, 20),
      );

      final result = await service.forMonth(DateTime(2026, 8));
      final rows = (result as Success<List<Transaction>>).data;

      expect(rows.map((t) => t.amount), [2000, 1000]);
    });
  });

  group('totalForMonth', () {
    test('additionne les dépenses du mois', () async {
      for (final amount in [1500, 2500, 6000]) {
        await service.add(
          amount: amount,
          categoryId: 'food',
          date: DateTime(2026, 8, 10),
        );
      }

      final total = await service.totalForMonth(DateTime(2026, 8));
      expect((total as Success<int>).data, 10000);
    });

    test('vaut zéro sur un mois sans dépense', () async {
      final total = await service.totalForMonth(DateTime(2026, 8));
      expect((total as Success<int>).data, 0);
    });
  });

  group('remove', () {
    test('supprime la dépense et met le total à jour', () async {
      final added = await service.add(amount: 5000, categoryId: 'food');
      final id = (added as Success<int>).data;

      expect(((await service.remove(id)) as Success<bool>).data, isTrue);

      final total = await service.totalForMonth(DateTime.now());
      expect((total as Success<int>).data, 0);
    });

    test('signale l’absence quand l’identifiant n’existe pas', () async {
      expect(((await service.remove(999)) as Success<bool>).data, isFalse);
    });
  });

  group('update', () {
    test('remplace montant, catégorie et note', () async {
      final added = await service.add(
        amount: 5000,
        categoryId: 'food',
        note: 'Déjeuner',
        date: DateTime(2026, 8, 15),
      );
      final id = (added as Success<int>).data;

      final updated = await service.update(
        id: id,
        amount: 7500,
        categoryId: 'transport',
        note: 'Taxi',
        date: DateTime(2026, 8, 15),
      );
      expect((updated as Success<bool>).data, isTrue);

      final result = await service.forMonth(DateTime(2026, 8));
      final row = (result as Success<List<Transaction>>).data.single;

      expect(row.amount, 7500);
      expect(row.categoryId, 'transport');
      expect(row.note, 'Taxi');
    });

    test('ne crée pas de doublon', () async {
      final added = await service.add(amount: 5000, categoryId: 'food');
      final id = (added as Success<int>).data;

      await service.update(id: id, amount: 9000, categoryId: 'food');

      final result = await service.forMonth(DateTime.now());
      expect((result as Success<List<Transaction>>).data, hasLength(1));
    });

    test('refuse un montant nul', () async {
      final added = await service.add(amount: 5000, categoryId: 'food');
      final id = (added as Success<int>).data;

      final updated = await service.update(
        id: id,
        amount: 0,
        categoryId: 'food',
      );
      expect(updated.isSuccess, isFalse);

      // La dépense d'origine est intacte.
      final result = await service.forMonth(DateTime.now());
      expect(
        (result as Success<List<Transaction>>).data.single.amount,
        5000,
      );
    });

    test('signale un identifiant inconnu sans échouer', () async {
      final updated = await service.update(
        id: 999,
        amount: 1000,
        categoryId: 'food',
      );
      expect((updated as Success<bool>).data, isFalse);
    });

    test('vider la note la supprime', () async {
      final added = await service.add(
        amount: 5000,
        categoryId: 'food',
        note: 'À effacer',
      );
      final id = (added as Success<int>).data;

      await service.update(
        id: id,
        amount: 5000,
        categoryId: 'food',
        note: '',
      );

      final result = await service.forMonth(DateTime.now());
      expect((result as Success<List<Transaction>>).data.single.note, isNull);
    });
  });
}
