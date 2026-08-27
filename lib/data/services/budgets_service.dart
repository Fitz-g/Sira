import 'package:drift/drift.dart';

import '../local/app_database.dart';
import '../models/result.dart';

/// Accès aux enveloppes budgétaires. Seule porte d'entrée vers la table
/// `budgets` : aucun widget ne touche la base directement.
class BudgetsService {
  const BudgetsService(this._db);

  final AppDatabase _db;

  /// Ramène une date au premier jour de son mois.
  ///
  /// Toutes les enveloppes sont rangées sur cette date : sans normalisation,
  /// deux enregistrements le 3 et le 17 du même mois créeraient deux lignes.
  static DateTime monthKey(DateTime date) => DateTime(date.year, date.month);

  /// Fixe l'enveloppe d'une catégorie pour un mois.
  ///
  /// Un montant nul ou négatif retire l'enveloppe : ne rien allouer est une
  /// réponse valable, et l'utilisateur doit pouvoir revenir en arrière.
  Future<Result<void>> setLimit({
    required String categoryId,
    required DateTime month,
    required int amount,
  }) async {
    final key = monthKey(month);

    try {
      if (amount <= 0) {
        await (_db.delete(_db.budgets)
              ..where((b) => b.categoryId.equals(categoryId))
              ..where((b) => b.month.equals(key)))
            .go();
        return const Success(null);
      }

      await _db.into(_db.budgets).insert(
        BudgetsCompanion.insert(
          categoryId: categoryId,
          monthlyLimit: amount,
          month: key,
        ),
        // Le conflit visé est celui de la contrainte d'unicité, pas celui de
        // la clé primaire : chaque insertion produit un identifiant neuf, donc
        // la clé primaire n'entre jamais en conflit et l'ancienne enveloppe
        // resterait en place.
        onConflict: DoUpdate(
          (_) => BudgetsCompanion(monthlyLimit: Value(amount)),
          target: [_db.budgets.categoryId, _db.budgets.month],
        ),
      );
      return const Success(null);
    } catch (_) {
      return const Failure(
        'Hmm, l’enregistrement du budget a échoué. Réessaie dans un instant.',
      );
    }
  }

  /// Enveloppes d'un mois, par identifiant de catégorie.
  ///
  /// Une catégorie sans enveloppe est absente de la carte plutôt que présente à
  /// zéro : ne rien avoir alloué et avoir alloué zéro ne sont pas la même
  /// chose.
  Future<Result<Map<String, int>>> forMonth(DateTime month) async {
    try {
      final rows = await (_db.select(_db.budgets)
            ..where((b) => b.month.equals(monthKey(month))))
          .get();

      return Success({
        for (final row in rows) row.categoryId: row.monthlyLimit,
      });
    } catch (_) {
      return const Failure('Impossible de charger ton budget.');
    }
  }

  /// Enveloppes du mois le plus récent antérieur à [month], s'il en existe.
  ///
  /// Sert à reconduire un budget d'un mois sur l'autre sans rien recopier en
  /// base : le mois courant n'a d'enregistrement que si l'utilisateur y touche.
  Future<Result<Map<String, int>>> mostRecentBefore(DateTime month) async {
    try {
      final key = monthKey(month);

      final dernier = await (_db.select(_db.budgets)
            ..where((b) => b.month.isSmallerThanValue(key))
            ..orderBy([
              (b) => OrderingTerm(expression: b.month, mode: OrderingMode.desc),
            ])
            ..limit(1))
          .getSingleOrNull();

      if (dernier == null) return const Success({});
      return await forMonth(dernier.month);
    } catch (_) {
      return const Failure('Impossible de charger ton budget.');
    }
  }

  /// Total alloué sur un mois, toutes catégories confondues.
  Future<Result<int>> totalForMonth(DateTime month) async {
    final result = await forMonth(month);
    return switch (result) {
      Success(:final data) => Success(
          data.values.fold<int>(0, (sum, amount) => sum + amount),
        ),
      Failure(:final message) => Failure(message),
    };
  }
}
