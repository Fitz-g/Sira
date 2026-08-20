import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sira/core/theme/app_theme.dart';
import 'package:sira/core/utils/currency_input_formatter.dart';
import 'package:sira/data/local/app_database.dart';
import 'package:sira/data/models/result.dart';
import 'package:sira/data/services/transactions_service.dart';
import 'package:sira/features/transactions/presentation/expense_entry_screen.dart';
import 'package:sira/features/transactions/providers/transactions_provider.dart';
import 'package:sira/shared/widgets/widgets.dart';

late AppDatabase db;

Future<void> _pumpScreen(WidgetTester tester) async {
  await tester.pumpWidget(
    ProviderScope(
      // La base réelle écrirait un fichier sur le disque ; en test elle vit
      // en mémoire et disparaît avec le cas.
      overrides: [appDatabaseProvider.overrideWithValue(db)],
      child: MaterialApp(
        theme: AppTheme.light,
        home: const ExpenseEntryScreen(),
      ),
    ),
  );
  await tester.pump();
}

bool _isSaveEnabled(WidgetTester tester) =>
    tester.widget<PrimaryButton>(find.byType(PrimaryButton)).onPressed != null;

void main() {
  setUp(() => db = AppDatabase.forTesting(NativeDatabase.memory()));
  tearDown(() => db.close());

  testWidgets('ouvre le clavier sur le montant', (tester) async {
    await _pumpScreen(tester);

    // Le champ du montant a le focus dès l'ouverture : c'est ce qui fait
    // gagner le premier geste, et le cœur de la promesse des 15 secondes.
    final amountField = tester.widget<TextField>(find.byType(TextField).first);
    expect(amountField.autofocus, isTrue);
  });

  testWidgets('le bouton reste inactif tant que le montant est nul',
      (tester) async {
    await _pumpScreen(tester);
    expect(_isSaveEnabled(tester), isFalse);

    await tester.enterText(find.byType(TextField).first, '2500');
    await tester.pump();
    expect(_isSaveEnabled(tester), isTrue);
  });

  testWidgets('applique le formateur de montant au champ', (tester) async {
    await _pumpScreen(tester);

    // Le formatage lui-même est couvert par currency_input_formatter_test ;
    // ici on vérifie seulement que le champ le porte bien.
    final amountField = tester.widget<TextField>(find.byType(TextField).first);
    expect(
      amountField.inputFormatters,
      contains(isA<CurrencyInputFormatter>()),
    );
  });

  testWidgets('propose les huit catégories', (tester) async {
    await _pumpScreen(tester);

    // Les chips défilent horizontalement : celles hors écran ne sont pas
    // construites. On interroge donc le widget, pas le rendu.
    final chips = tester.widget<SelectionChips>(find.byType(SelectionChips));

    expect(chips.options, hasLength(8));
    expect(
      chips.options.map((o) => o.id),
      containsAll(['food', 'transport', 'housing', 'other']),
    );
    expect(find.text('Alimentation'), findsOneWidget);
  });

  testWidgets('enregistre la dépense saisie', (tester) async {
    await _pumpScreen(tester);

    await tester.enterText(find.byType(TextField).first, '7500');
    await tester.pump();
    await tester.tap(find.text('Transport'));
    await tester.pump();

    await tester.tap(find.byType(PrimaryButton));
    await tester.pumpAndSettle();

    final rows = (await TransactionsService(db).forMonth(DateTime.now()))
        as Success<List<Transaction>>;

    expect(rows.data, hasLength(1));
    expect(rows.data.single.amount, 7500);
    expect(rows.data.single.categoryId, 'transport');
  });

  testWidgets('classe dans « Autre » quand aucune catégorie n’est choisie',
      (tester) async {
    await _pumpScreen(tester);

    await tester.enterText(find.byType(TextField).first, '3000');
    await tester.pump();
    await tester.tap(find.byType(PrimaryButton));
    await tester.pumpAndSettle();

    final rows = (await TransactionsService(db).forMonth(DateTime.now()))
        as Success<List<Transaction>>;

    // Mieux vaut une dépense mal classée qu'une dépense jamais saisie.
    expect(rows.data.single.categoryId, 'other');
  });
}
