import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

/// Dépenses saisies par l'utilisateur.
///
/// Seule table créée à ce stade : chaque story n'ajoute que ce dont elle a
/// besoin. Budgets, dettes et objectifs viendront avec les leurs.
class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Montant en FCFA. **Entier**, jamais un réel : un `REAL` introduirait des
  /// arrondis invisibles jusqu'au jour où un total serait faux.
  IntColumn get amount => integer()();

  /// Identifiant de catégorie — voir `core/constants/expense_categories.dart`.
  TextColumn get categoryId => text().withLength(min: 1, max: 32)();

  TextColumn get note => text().withLength(max: 60).nullable()();

  /// Date de la dépense, distincte de sa date de saisie.
  DateTimeColumn get date => dateTime()();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(tables: [Transactions])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_open());

  /// Constructeur destiné aux tests : base en mémoire, isolée et jetable.
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;
}

/// Ouvre le fichier de base dans le répertoire de documents de l'application.
LazyDatabase _open() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'sira.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
