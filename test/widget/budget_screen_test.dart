import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sira/core/constants/expense_categories.dart';
import 'package:sira/core/theme/app_theme.dart';
import 'package:sira/core/utils/currency.dart';
import 'package:sira/data/local/app_database.dart';
import 'package:sira/data/models/result.dart';
import 'package:sira/data/services/budgets_service.dart';
import 'package:sira/features/budget/presentation/budget_screen.dart';
import 'package:sira/features/transactions/providers/transactions_provider.dart';
import 'package:sira/shared/widgets/widgets.dart';

late AppDatabase db;

Future<void> _pumpBudget(WidgetTester tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
      child: MaterialApp(theme: AppTheme.light, home: const BudgetScreen()),
    ),
  );
  await tester.pumpAndSettle();
}

/// Saisit un montant dans la ligne d'une catégorie.
Future<void> _enterLimit(
  WidgetTester tester,
  String label,
  String amount,
) async {
  final row = find.ancestor(of: find.text(label), matching: find.byType(Row));
  await tester.enterText(
    find.descendant(of: row.first, matching: find.byType(TextField)),
    amount,
  );
  await tester.pump();
}

Future<Map<String, int>> _saved() async =>
    (await BudgetsService(db).forMonth(DateTime.now())
        as Success<Map<String, int>>)
        .data;

void main() {
  setUpAll(() => initializeDateFormatting('fr_FR'));
  setUp(() => db = AppDatabase.forTesting(NativeDatabase.memory()));
  tearDown(() => db.close());

  testWidgets('présente toutes les catégories', (tester) async {
    await _pumpBudget(tester);

    for (final category in expenseCategories) {
      expect(find.text(category.label), findsOneWidget, reason: category.label);
    }
  });

  testWidgets('les enveloppes vides s’affichent par un tiret', (tester) async {
    await _pumpBudget(tester);

    // Ne rien allouer n'est pas allouer zéro : le champ reste vide, il
    // n'affiche pas « 0 ».
    expect(find.text('—'), findsNWidgets(expenseCategories.length));
    expect(find.text('0'), findsNothing);
  });

  testWidgets('reprend les enveloppes déjà enregistrées', (tester) async {
    await BudgetsService(db).setLimit(
      categoryId: 'food',
      month: DateTime.now(),
      amount: 150000,
    );

    await _pumpBudget(tester);

    expect(find.text(Currency.formatAmount(150000)), findsOneWidget);
  });

  testWidgets('enregistre les montants saisis', (tester) async {
    await _pumpBudget(tester);

    await _enterLimit(tester, 'Alimentation', '150000');
    await _enterLimit(tester, 'Transport', '50000');
    await tester.tap(find.byType(PrimaryButton));
    await tester.pumpAndSettle();

    expect(await _saved(), {'food': 150000, 'transport': 50000});
  });

  testWidgets('une catégorie laissée vide n’est pas enregistrée',
      (tester) async {
    await _pumpBudget(tester);

    await _enterLimit(tester, 'Alimentation', '150000');
    await tester.tap(find.byType(PrimaryButton));
    await tester.pumpAndSettle();

    final budget = await _saved();
    expect(budget, hasLength(1));
    expect(budget.containsKey('transport'), isFalse);
  });

  testWidgets('vider une enveloppe la retire', (tester) async {
    await BudgetsService(db).setLimit(
      categoryId: 'food',
      month: DateTime.now(),
      amount: 150000,
    );
    await _pumpBudget(tester);

    await _enterLimit(tester, 'Alimentation', '');
    await tester.tap(find.byType(PrimaryButton));
    await tester.pumpAndSettle();

    // L'utilisateur doit pouvoir revenir en arrière sur une enveloppe.
    expect(await _saved(), isEmpty);
  });

  testWidgets('le total suit la saisie sans attendre l’enregistrement',
      (tester) async {
    await _pumpBudget(tester);
    expect(find.text(Currency.format(0)), findsOneWidget);

    await _enterLimit(tester, 'Alimentation', '150000');
    await _enterLimit(tester, 'Transport', '50000');

    expect(find.text(Currency.format(200000)), findsOneWidget);
  });
}
