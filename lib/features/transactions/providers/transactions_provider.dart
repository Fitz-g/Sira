import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/local/app_database.dart';
import '../../../data/models/result.dart';
import '../../../data/services/transactions_service.dart';

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
