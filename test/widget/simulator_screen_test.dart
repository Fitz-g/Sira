import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sira/core/constants/uemoa_rates.dart';
import 'package:sira/core/theme/app_theme.dart';
import 'package:sira/core/utils/currency.dart';
import 'package:sira/features/simulation/domain/simulation_engine.dart';
import 'package:sira/features/simulation/presentation/simulator_screen.dart';

Widget _wrap() => MaterialApp(
      theme: AppTheme.light,
      home: const SimulatorScreen(),
    );

void main() {
  testWidgets('l’aperçu reste masqué tant qu’aucun montant n’est saisi',
      (tester) async {
    await tester.pumpWidget(_wrap());

    expect(find.textContaining('Tu dois épargner'), findsNothing);
  });

  testWidgets('saisir un montant fait apparaître le versement calculé',
      (tester) async {
    await tester.pumpWidget(_wrap());

    await tester.enterText(find.byType(TextField), '2000000');
    await tester.pump();

    // La durée par défaut de l'écran est de 24 mois.
    final expected = SimulationEngine.requiredMonthlyContribution(
      targetAmount: 2000000,
      initialAmount: 0,
      durationMonths: 24,
      annualRate: UemoaRates.savingsAccount,
    );

    expect(find.textContaining('Tu dois épargner'), findsOneWidget);
    expect(
      find.textContaining(Currency.format(expected)),
      findsOneWidget,
      reason: 'Le montant affiché doit venir du moteur, pas d’une constante',
    );
  });

  testWidgets('l’hypothèse de rendement est affichée avec le montant',
      (tester) async {
    await tester.pumpWidget(_wrap());

    await tester.enterText(find.byType(TextField), '1000000');
    await tester.pump();

    // Un chiffre financier ne doit jamais apparaître sans son hypothèse.
    expect(find.textContaining('Estimation sur la base'), findsOneWidget);
  });

  testWidgets('allonger la durée réduit le versement mensuel', (tester) async {
    await tester.pumpWidget(_wrap());

    await tester.enterText(find.byType(TextField), '2000000');
    await tester.pump();

    final court = SimulationEngine.requiredMonthlyContribution(
      targetAmount: 2000000,
      initialAmount: 0,
      durationMonths: 24,
      annualRate: UemoaRates.savingsAccount,
    );
    expect(find.textContaining(Currency.format(court)), findsOneWidget);

    // Le curseur passe de 24 à 60 mois.
    final slider = tester.widget<Slider>(find.byType(Slider));
    slider.onChanged!(60);
    await tester.pump();

    final long = SimulationEngine.requiredMonthlyContribution(
      targetAmount: 2000000,
      initialAmount: 0,
      durationMonths: 60,
      annualRate: UemoaRates.savingsAccount,
    );

    expect(long, lessThan(court));
    expect(find.textContaining(Currency.format(long)), findsOneWidget);
  });
}
