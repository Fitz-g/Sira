import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sira/core/theme/app_theme.dart';
import 'package:sira/core/utils/currency.dart';
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

    // Deux dépenses du jour, un seul en-tête, et le total de la journée.
    expect(find.byType(ExpenseRow), findsNWidgets(2));
    expect(find.text('Aujourd’hui'), findsOneWidget);
    expect(find.text(Currency.format(3000)), findsOneWidget);
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
}
