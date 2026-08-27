import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sira/data/local/app_database.dart';
import 'package:sira/data/models/result.dart';
import 'package:sira/data/services/transactions_service.dart';
import 'package:sira/features/transactions/providers/transactions_provider.dart';

/// Vérifie que ce qui dépend d'une dépense suit ses changements.
///
/// La liste et le tableau de bord lisent des providers distincts : rien ne
/// garantit qu'ils se rafraîchissent tous les deux, sinon un test.
void main() {
  late AppDatabase db;
  late ProviderContainer container;
  late TransactionsService service;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
    );
    service = container.read(transactionsServiceProvider);
  });

  tearDown(() {
    container.dispose();
    db.close();
  });

  /// Total du mois en cours, tel que l'affiche le tableau de bord.
  Future<int> dashboardTotal() =>
      container.read(currentMonthTotalProvider.future);

  /// Total du mois consulté, tel que l'affiche la liste.
  Future<int> listTotal() => container.read(filteredTotalProvider.future);

  Future<int> seed({required int amount, String category = 'food'}) async {
    final added = await service.add(amount: amount, categoryId: category);
    return (added as Success<int>).data;
  }

  group('après une suppression', () {
    test('le total de la liste est recalculé', () async {
      await seed(amount: 5000);
      final id = await seed(amount: 3000);
      expect(await listTotal(), 8000);

      await service.remove(id);
      container.invalidate(filteredExpensesProvider);

      expect(await listTotal(), 5000);
    });

    test('le total du tableau de bord suit aussi', () async {
      final id = await seed(amount: 5000);
      expect(await dashboardTotal(), 5000);

      await service.remove(id);
      container.invalidate(currentMonthExpensesProvider);

      // Le tableau de bord lit son propre provider : sans cette invalidation
      // il afficherait encore un total qui n'existe plus.
      expect(await dashboardTotal(), 0);
    });
  });

  group('après une modification', () {
    test('le total reflète le nouveau montant', () async {
      final id = await seed(amount: 5000);
      expect(await listTotal(), 5000);

      await service.update(id: id, amount: 12000, categoryId: 'food');
      container
        ..invalidate(filteredExpensesProvider)
        ..invalidate(currentMonthExpensesProvider);

      expect(await listTotal(), 12000);
      expect(await dashboardTotal(), 12000);
    });

    test('changer de catégorie ne change pas le total', () async {
      final id = await seed(amount: 5000, category: 'food');

      await service.update(id: id, amount: 5000, categoryId: 'transport');
      container.invalidate(filteredExpensesProvider);

      expect(await listTotal(), 5000);
    });
  });

  group('filtrage', () {
    test('le total ne compte que la catégorie retenue', () async {
      await seed(amount: 5000, category: 'food');
      await seed(amount: 3000, category: 'transport');
      expect(await listTotal(), 8000);

      container.read(expenseFilterProvider.notifier).setCategory('transport');

      expect(await listTotal(), 3000);
    });

    test('le tableau de bord ignore le filtre de la liste', () async {
      await seed(amount: 5000, category: 'food');
      await seed(amount: 3000, category: 'transport');

      container.read(expenseFilterProvider.notifier).setCategory('transport');

      // Parcourir ou filtrer depuis la liste ne doit pas changer ce que
      // l'utilisateur voit en arrivant sur l'accueil.
      expect(await dashboardTotal(), 8000);
    });

    test('le tableau de bord ignore le mois consulté', () async {
      await seed(amount: 5000);

      container.read(expenseFilterProvider.notifier).goToPreviousMonth();

      expect(await listTotal(), 0);
      expect(await dashboardTotal(), 5000);
    });
  });
}
