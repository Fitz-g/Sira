import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/result.dart';
import '../../../data/services/budgets_service.dart';
import '../../transactions/providers/transactions_provider.dart';

final budgetsServiceProvider = Provider<BudgetsService>(
  (ref) => BudgetsService(ref.watch(appDatabaseProvider)),
);

/// Enveloppes du mois en cours, par identifiant de catégorie.
///
/// Une catégorie absente de la carte n'a pas d'enveloppe — ce n'est pas une
/// enveloppe à zéro.
final currentBudgetProvider = FutureProvider<Map<String, int>>((ref) async {
  final service = ref.watch(budgetsServiceProvider);
  final result = await service.forMonth(DateTime.now());

  return switch (result) {
    Success(:final data) => data,
    Failure(:final message) => throw Exception(message),
  };
});

/// Total alloué ce mois-ci, toutes catégories confondues.
final currentBudgetTotalProvider = FutureProvider<int>((ref) async {
  final budget = await ref.watch(currentBudgetProvider.future);
  return budget.values.fold<int>(0, (sum, amount) => sum + amount);
});
