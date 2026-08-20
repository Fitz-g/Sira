import 'package:flutter/material.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sira/core/theme/app_theme.dart';
import 'package:sira/core/utils/currency.dart';
import 'package:sira/features/dashboard/presentation/dashboard_screen.dart';
import 'package:sira/data/local/app_database.dart';
import 'package:sira/features/onboarding/providers/onboarding_provider.dart';
import 'package:sira/features/transactions/providers/transactions_provider.dart';

/// Monte le tableau de bord sur un conteneur dont l'état est déjà posé.
///
/// Modifier un provider depuis un `builder` le ferait après le premier rendu :
/// l'écran lirait alors l'état vide.
Future<void> _pumpDashboard(
  WidgetTester tester, {
  void Function(OnboardingNotifier)? given,
}) async {
  // Le tableau de bord lit les dépenses du mois : sans base, son résumé
  // resterait indéfiniment en chargement.
  final db = AppDatabase.forTesting(NativeDatabase.memory());
  addTearDown(db.close);

  final container = ProviderContainer(
    overrides: [appDatabaseProvider.overrideWithValue(db)],
  );
  addTearDown(container.dispose);
  given?.call(container.read(onboardingProvider.notifier));

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp(theme: AppTheme.light, home: const DashboardScreen()),
    ),
  );
  // Laisse la lecture de la base aboutir.
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(() => initializeDateFormatting('fr_FR'));

  testWidgets('salue l’utilisateur', (tester) async {
    await _pumpDashboard(tester);
    expect(find.textContaining('Bonjour'), findsOneWidget);
  });

  testWidgets('réserve la place du score sans afficher de chiffre',
      (tester) async {
    await _pumpDashboard(tester);

    expect(find.text('Santé financière'), findsOneWidget);
    expect(
      find.textContaining('apparaîtra dès tes premières dépenses'),
      findsOneWidget,
    );
    // Un chiffre financier faux vaut moins que pas de chiffre : aucun score
    // sur 100 ne doit apparaître tant qu'il n'est pas calculable.
    expect(find.textContaining('/100'), findsNothing);
    expect(find.text('0'), findsNothing);
  });

  testWidgets('restitue la situation déclarée pendant l’onboarding',
      (tester) async {
    await _pumpDashboard(
      tester,
      given: (n) => n
        ..setIncomeRange('from_150k_to_300k')
        ..setHasDebts(value: true)
        ..setDebtAmount(500000)
        ..setHasSavings(value: true)
        ..setSavingsAmount(200000),
    );

    expect(find.text('150 000 – 300 000 F'), findsOneWidget);
    expect(find.text(Currency.format(500000)), findsOneWidget);
    expect(find.text(Currency.format(200000)), findsOneWidget);
  });

  testWidgets('indique clairement ce qui n’a pas été déclaré', (tester) async {
    await _pumpDashboard(tester);
    expect(find.text('Aucune'), findsNWidgets(2)); // épargne et dettes
    expect(find.text('Non renseignés'), findsOneWidget); // revenus
  });

  testWidgets('propose les trois actions rapides', (tester) async {
    await _pumpDashboard(tester);

    expect(find.text('Dépense'), findsOneWidget);
    expect(find.text('Objectif'), findsOneWidget);
    // L'entrée du simulateur — corrigée dans la spécification 01.6, elle
    // n'existait nulle part auparavant.
    expect(find.text('Simuler'), findsOneWidget);
  });

  testWidgets('accueille l’absence de dépenses par un message encourageant',
      (tester) async {
    await _pumpDashboard(tester);

    expect(find.textContaining('beau début'), findsOneWidget);
    expect(find.text('Noter une dépense'), findsOneWidget);
  });

  testWidgets('adapte son conseil à l’objectif choisi', (tester) async {
    await _pumpDashboard(tester, given: (n) => n.setPrimaryGoal('debts'));
    expect(find.textContaining('Cartographie'), findsOneWidget);

    await _pumpDashboard(tester, given: (n) => n.setPrimaryGoal('invest'));
    expect(find.textContaining('trois mois de dépenses'), findsOneWidget);
  });
}
