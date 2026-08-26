import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sira/core/theme/app_theme.dart';
import 'package:sira/core/utils/currency.dart';
import 'package:sira/core/utils/dates.dart';
import 'package:sira/data/local/app_database.dart';
import 'package:sira/data/services/transactions_service.dart';
import 'package:sira/features/transactions/presentation/expense_list_screen.dart';
import 'package:sira/features/transactions/presentation/widgets/expense_row.dart';
import 'package:sira/features/transactions/providers/transactions_provider.dart';
import 'package:sira/shared/widgets/widgets.dart';

late AppDatabase db;

Future<void> _pumpList(WidgetTester tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
      child: MaterialApp(
        theme: AppTheme.light,
        home: const ExpenseListScreen(),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

/// Touche un chip de filtrage par son libellé.
///
/// Nécessaire car les libellés de catégorie apparaissent aussi dans les
/// lignes de dépense : `find.text('Transport')` en trouverait plusieurs.
Future<void> _tapFilter(WidgetTester tester, String label) async {
  await tester.tap(
    find.descendant(
      of: find.byType(SelectionChips),
      matching: find.text(label),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(() => initializeDateFormatting('fr_FR'));
  setUp(() => db = AppDatabase.forTesting(NativeDatabase.memory()));
  tearDown(() => db.close());

  testWidgets('accueille une liste vide par une invitation', (tester) async {
    await _pumpList(tester);

    expect(find.textContaining('Beau début'), findsOneWidget);
    expect(find.text('Noter une dépense'), findsOneWidget);
    expect(find.byType(ExpenseRow), findsNothing);
  });

  testWidgets('affiche les dépenses du mois', (tester) async {
    final service = TransactionsService(db);
    await service.add(amount: 12500, categoryId: 'food');
    await service.add(amount: 3000, categoryId: 'transport');

    await _pumpList(tester);

    expect(find.byType(ExpenseRow), findsNWidgets(2));

    // Les libellés existent aussi dans les chips de filtrage : on vise donc
    // l'intérieur des lignes, pas l'écran entier.
    expect(
      find.descendant(
        of: find.byType(ExpenseRow),
        matching: find.text('Alimentation'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byType(ExpenseRow),
        matching: find.text('Transport'),
      ),
      findsOneWidget,
    );
  });

  testWidgets('regroupe les dépenses sous leur journée', (tester) async {
    final service = TransactionsService(db);
    final now = DateTime.now();
    await service.add(amount: 1000, categoryId: 'food', date: now);
    await service.add(amount: 2000, categoryId: 'food', date: now);

    await _pumpList(tester);

    // Deux dépenses du jour, un seul en-tête de journée.
    expect(find.byType(ExpenseRow), findsNWidgets(2));
    expect(find.text('Aujourd’hui'), findsOneWidget);

    // Le montant apparaît deux fois : total du mois en tête d'écran, et total
    // de la journée dans son en-tête. Les deux valent 3 000 ici.
    expect(find.text(Currency.format(3000)), findsNWidgets(2));
  });

  testWidgets('sépare les journées distinctes', (tester) async {
    final service = TransactionsService(db);
    final now = DateTime.now();
    await service.add(amount: 1000, categoryId: 'food', date: now);
    await service.add(
      amount: 2000,
      categoryId: 'food',
      date: now.subtract(const Duration(days: 1)),
    );

    await _pumpList(tester);

    expect(find.text('Aujourd’hui'), findsOneWidget);
    expect(find.text('Hier'), findsOneWidget);
  });

  testWidgets('affiche le mois consulté et son total', (tester) async {
    final service = TransactionsService(db);
    await service.add(amount: 4500, categoryId: 'food');

    await _pumpList(tester);

    expect(find.text(Dates.monthYear(DateTime.now())), findsOneWidget);
    expect(find.text('Dépensé ce mois'), findsOneWidget);
  });

  testWidgets('recule d’un mois et vide la liste', (tester) async {
    final service = TransactionsService(db);
    await service.add(amount: 4500, categoryId: 'food');

    await _pumpList(tester);
    expect(find.byType(ExpenseRow), findsOneWidget);

    await tester.tap(find.bySemanticsLabel('Mois précédent'));
    await tester.pumpAndSettle();

    // Le mois précédent n'a aucune dépense : l'invitation reprend sa place.
    expect(find.byType(ExpenseRow), findsNothing);
    expect(find.textContaining('Beau début'), findsOneWidget);
    expect(find.text('Dépensé ce mois-là'), findsOneWidget);
  });

  testWidgets('n’avance pas au-delà du mois en cours', (tester) async {
    await _pumpList(tester);

    // Rien à consulter dans le futur : le chevron avant n'a pas d'action.
    final selecteur = tester.widget<MonthSelector>(find.byType(MonthSelector));
    expect(selecteur.onNext, isNull);
  });

  testWidgets('revient au mois en cours après un aller-retour',
      (tester) async {
    final service = TransactionsService(db);
    await service.add(amount: 4500, categoryId: 'food');
    await _pumpList(tester);

    await tester.tap(find.bySemanticsLabel('Mois précédent'));
    await tester.pumpAndSettle();
    await tester.tap(find.bySemanticsLabel('Mois suivant'));
    await tester.pumpAndSettle();

    expect(find.byType(ExpenseRow), findsOneWidget);
    expect(find.text('Dépensé ce mois'), findsOneWidget);
  });

  testWidgets('ne garde que la catégorie choisie', (tester) async {
    final service = TransactionsService(db);
    await service.add(amount: 1000, categoryId: 'food');
    await service.add(amount: 2000, categoryId: 'transport');
    await service.add(amount: 3000, categoryId: 'transport');

    await _pumpList(tester);
    expect(find.byType(ExpenseRow), findsNWidgets(3));

    await _tapFilter(tester, 'Transport');

    expect(find.byType(ExpenseRow), findsNWidgets(2));
  });

  testWidgets('le total suit le filtre et dit ce qu’il compte',
      (tester) async {
    final service = TransactionsService(db);
    await service.add(amount: 1000, categoryId: 'food');
    await service.add(amount: 2000, categoryId: 'transport');

    await _pumpList(tester);
    expect(find.text(Currency.format(3000)), findsWidgets);

    await _tapFilter(tester, 'Transport');

    // Un total filtré doit nommer ce qu'il compte : « Dépensé ce mois » sur un
    // chiffre qui n'inclut que le transport serait un mensonge.
    expect(find.text('Transport ce mois'), findsOneWidget);
    expect(find.text(Currency.format(2000)), findsWidgets);
  });

  testWidgets('« Toutes » rétablit la liste complète', (tester) async {
    final service = TransactionsService(db);
    await service.add(amount: 1000, categoryId: 'food');
    await service.add(amount: 2000, categoryId: 'transport');

    await _pumpList(tester);
    await _tapFilter(tester, 'Transport');
    expect(find.byType(ExpenseRow), findsOneWidget);

    await _tapFilter(tester, 'Toutes');
    expect(find.byType(ExpenseRow), findsNWidgets(2));
  });

  testWidgets('une catégorie sans dépense le dit sans décourager',
      (tester) async {
    final service = TransactionsService(db);
    await service.add(amount: 1000, categoryId: 'food');

    await _pumpList(tester);
    await _tapFilter(tester, 'Santé');

    // Message distinct du mois vide : ici l'utilisateur a peut-être
    // simplement mal filtré.
    expect(find.text('Rien en Santé ce mois'), findsOneWidget);
    expect(find.textContaining('Toutes'), findsWidgets);
  });

  testWidgets('changer de mois conserve la catégorie', (tester) async {
    final service = TransactionsService(db);
    await service.add(amount: 2000, categoryId: 'transport');

    await _pumpList(tester);
    await _tapFilter(tester, 'Transport');

    await tester.tap(find.bySemanticsLabel('Mois précédent'));
    await tester.pumpAndSettle();

    // On suit une dépense dans le temps : le filtre ne se remet pas à zéro.
    expect(find.text('Transport ce mois-là'), findsOneWidget);
  });
}
