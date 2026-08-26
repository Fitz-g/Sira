import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sira/core/theme/app_icons.dart';
import 'package:sira/core/theme/app_theme.dart';
import 'package:sira/core/utils/currency.dart';
import 'package:sira/core/utils/dates.dart';
import 'package:sira/data/local/app_database.dart';
import 'package:sira/data/services/transactions_service.dart';
import 'package:sira/features/transactions/presentation/expense_list_screen.dart';
import 'package:sira/features/transactions/presentation/widgets/expense_row.dart';
import 'package:sira/features/transactions/providers/transactions_provider.dart';

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
    expect(find.text('Alimentation'), findsOneWidget);
    expect(find.text('Transport'), findsOneWidget);
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

    final suivant = tester.widget<Semantics>(
      find.ancestor(
        of: find.byIcon(AppIcons.chevronRight),
        matching: find.byType(Semantics),
      ).first,
    );

    // Rien à consulter dans le futur : le chevron est inerte, et le dit.
    expect(suivant.properties.enabled, isFalse);
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
}
