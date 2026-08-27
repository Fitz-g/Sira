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

/// Enveloppe mensuelle attribuée à une catégorie.
///
/// Une ligne par catégorie et par mois : c'est ce qui permet de changer de
/// budget d'un mois à l'autre sans réécrire l'historique.
class Budgets extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Identifiant de catégorie — voir `core/constants/expense_categories.dart`.
  TextColumn get categoryId => text().withLength(min: 1, max: 32)();

  /// Enveloppe en FCFA. Entier, comme tout montant.
  IntColumn get monthlyLimit => integer()();

  /// Mois concerné, ramené à son premier jour.
  DateTimeColumn get month => dateTime()();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
        // Une seule enveloppe par catégorie et par mois : sans cette
        // contrainte, deux enregistrements successifs en créeraient deux.
        {categoryId, month},
      ];
}

@DriftDatabase(tables: [Transactions, Budgets])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_open());

  /// Constructeur destiné aux tests : base en mémoire, isolée et jetable.
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (m, from, to) async {
          // Une base v1 existe déjà sur les appareils : la table des budgets
          // s'ajoute sans toucher aux dépenses déjà saisies.
          if (from < 2) await m.createTable(budgets);
        },
      );
}

/// Ouvre le fichier de base dans le répertoire de documents de l'application.
LazyDatabase _open() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'sira.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
