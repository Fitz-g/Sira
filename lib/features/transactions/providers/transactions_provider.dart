import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/local/app_database.dart';
import '../../../data/models/result.dart';
import '../../../data/services/transactions_service.dart';
import '../domain/expense_filter.dart';

/// Instance unique de la base locale, fermée avec l'application.
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final transactionsServiceProvider = Provider<TransactionsService>(
  (ref) => TransactionsService(ref.watch(appDatabaseProvider)),
);

/// Dépenses du mois en cours.
///
/// Le service retourne un [Result] ; le provider le convertit en `AsyncValue`,
/// ce qui donne aux écrans les trois états — chargement, données, erreur —
/// sans booléen à gérer à la main. Le message d'erreur reste celui du service,
/// rédigé pour l'utilisateur.
final currentMonthExpensesProvider =
    FutureProvider<List<Transaction>>((ref) async {
  final service = ref.watch(transactionsServiceProvider);
  final result = await service.forMonth(DateTime.now());

  return switch (result) {
    Success(:final data) => data,
    Failure(:final message) => throw Exception(message),
  };
});

/// Total dépensé ce mois-ci, en FCFA entiers.
final currentMonthTotalProvider = FutureProvider<int>((ref) async {
  final expenses = await ref.watch(currentMonthExpensesProvider.future);
  return expenses.fold<int>(0, (sum, t) => sum + t.amount);
});

/// Mois actuellement consulté dans la liste des dépenses.
class ExpenseFilterNotifier extends Notifier<ExpenseFilter> {
  @override
  ExpenseFilter build() => ExpenseFilter.thisMonth();

  void goToPreviousMonth() => state = state.previousMonth();

  void goToNextMonth() {
    if (state.canGoForward) state = state.nextMonth();
  }

  /// `null` remet toutes les catégories.
  void setCategory(String? id) => state = state.withCategory(id);
}

final expenseFilterProvider =
    NotifierProvider<ExpenseFilterNotifier, ExpenseFilter>(
  ExpenseFilterNotifier.new,
);

/// Dépenses du mois consulté.
///
/// Distinct de [currentMonthExpensesProvider], qui reste sur le mois en cours :
/// parcourir l'historique depuis la liste ne doit pas changer le total affiché
/// sur le tableau de bord.
final filteredExpensesProvider =
    FutureProvider<List<Transaction>>((ref) async {
  final filter = ref.watch(expenseFilterProvider);
  final service = ref.watch(transactionsServiceProvider);
  final result = await service.forMonth(filter.month);

  return switch (result) {
    // Le filtrage par catégorie se fait en mémoire : les dépenses d'un mois
    // tiennent largement, et cela évite une requête par changement de chip.
    Success(:final data) => filter.categoryId == null
        ? data
        : data.where((t) => t.categoryId == filter.categoryId).toList(),
    Failure(:final message) => throw Exception(message),
  };
});

/// Total du mois consulté, en FCFA entiers.
final filteredTotalProvider = FutureProvider<int>((ref) async {
  final expenses = await ref.watch(filteredExpensesProvider.future);
  return expenses.fold<int>(0, (sum, t) => sum + t.amount);
});
