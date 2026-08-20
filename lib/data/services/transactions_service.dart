import 'package:drift/drift.dart';

import '../local/app_database.dart';
import '../models/result.dart';

/// Accès aux dépenses. Seule porte d'entrée vers la table `transactions` :
/// aucun widget ne touche la base directement.
class TransactionsService {
  const TransactionsService(this._db);

  final AppDatabase _db;

  /// Enregistre une dépense.
  ///
  /// [amount] est en FCFA entiers. [categoryId] vide retombe sur « Autre » :
  /// mieux vaut une dépense mal classée qu'une dépense non saisie.
  Future<Result<int>> add({
    required int amount,
    required String categoryId,
    String? note,
    DateTime? date,
  }) async {
    if (amount <= 0) {
      return const Failure('Entre un montant supérieur à zéro.');
    }

    try {
      final id = await _db.into(_db.transactions).insert(
            TransactionsCompanion.insert(
              amount: amount,
              categoryId: categoryId.isEmpty ? 'other' : categoryId,
              note: Value(note?.trim().isEmpty ?? true ? null : note!.trim()),
              date: date ?? DateTime.now(),
            ),
          );
      return Success(id);
    } catch (_) {
      // La trace technique partira vers Sentry ; l'utilisateur reçoit une
      // phrase qu'il comprend.
      return const Failure(
        'Hmm, la sauvegarde a échoué. Réessaie dans un instant.',
      );
    }
  }

  /// Dépenses d'un mois donné, de la plus récente à la plus ancienne.
  Future<Result<List<Transaction>>> forMonth(DateTime month) async {
    try {
      final start = DateTime(month.year, month.month);
      final end = DateTime(month.year, month.month + 1);

      final rows = await (_db.select(_db.transactions)
            ..where((t) => t.date.isBiggerOrEqualValue(start))
            ..where((t) => t.date.isSmallerThanValue(end))
            ..orderBy([
              (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
            ]))
          .get();

      return Success(rows);
    } catch (_) {
      return const Failure('Impossible de charger tes dépenses.');
    }
  }

  /// Total dépensé sur un mois, en FCFA entiers.
  Future<Result<int>> totalForMonth(DateTime month) async {
    final result = await forMonth(month);
    return switch (result) {
      Success(:final data) => Success(
          data.fold<int>(0, (sum, t) => sum + t.amount),
        ),
      Failure(:final message) => Failure(message),
    };
  }

  /// Supprime une dépense. Retourne `true` si une ligne a bien été retirée.
  Future<Result<bool>> remove(int id) async {
    try {
      final count = await (_db.delete(_db.transactions)
            ..where((t) => t.id.equals(id)))
          .go();
      return Success(count > 0);
    } catch (_) {
      return const Failure('La suppression a échoué.');
    }
  }
}
