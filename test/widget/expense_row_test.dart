import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sira/core/constants/expense_categories.dart';
import 'package:sira/core/theme/app_theme.dart';
import 'package:sira/core/utils/currency.dart';
import 'package:sira/features/transactions/presentation/widgets/expense_row.dart';
import 'package:sira/shared/widgets/widgets.dart';

Future<void> _pumpRow(
  WidgetTester tester, {
  String categoryId = 'food',
  int amount = 12500,
  String? note,
}) {
  return tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light,
      home: Scaffold(
        body: ExpenseRow(categoryId: categoryId, amount: amount, note: note),
      ),
    ),
  );
}

void main() {
  testWidgets('affiche la catégorie et le montant', (tester) async {
    await _pumpRow(tester, categoryId: 'transport', amount: 12500);

    expect(find.text('Transport'), findsOneWidget);
    expect(find.text(Currency.format(12500)), findsOneWidget);
  });

  testWidgets('affiche la note quand elle existe', (tester) async {
    await _pumpRow(tester, note: 'Déjeuner avec des collègues');
    expect(find.text('Déjeuner avec des collègues'), findsOneWidget);
  });

  testWidgets('n’affiche rien à la place d’une note vide', (tester) async {
    await _pumpRow(tester, note: '   ');

    // Une note faite d'espaces ne doit pas créer une ligne vide sous le
    // libellé, qui décalerait la hauteur sans rien apporter.
    final texts = tester.widgetList<Text>(find.byType(Text));
    expect(texts.where((t) => (t.data ?? '').trim().isEmpty), isEmpty);
  });

  testWidgets('porte la couleur de sa catégorie', (tester) async {
    await _pumpRow(tester, categoryId: 'health');

    final pill = tester.widget<IconPill>(find.byType(IconPill));
    expect(pill.color, categoryById('health').color);
  });

  testWidgets('chaque catégorie a sa propre teinte', (tester) async {
    // Deux catégories de même couleur rendraient la pastille inutile.
    final couleurs = expenseCategories.map((c) => c.color).toSet();
    expect(couleurs, hasLength(expenseCategories.length));
  });

  testWidgets('un identifiant inconnu retombe sur « Autre »', (tester) async {
    // Une base d'une version antérieure peut contenir une catégorie retirée
    // depuis : l'affichage ne doit pas échouer pour autant.
    await _pumpRow(tester, categoryId: 'categorie_disparue');
    expect(find.text('Autre'), findsOneWidget);
  });
}
