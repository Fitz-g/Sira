import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sira/core/constants/uemoa_rates.dart';
import 'package:sira/core/theme/app_theme.dart';
import 'package:sira/core/utils/currency.dart';
import 'package:sira/features/simulation/domain/simulation_engine.dart';
import 'package:sira/features/simulation/domain/simulation_models.dart';
import 'package:sira/features/simulation/presentation/simulation_result_screen.dart';
import 'package:sira/features/simulation/presentation/widgets/projection_chart.dart';

const _params = SimulationParams(
  targetAmount: 2000000,
  initialAmount: 200000,
  durationMonths: 36,
  annualRate: UemoaRates.treasuryBills1y,
  inflationRate: UemoaRates.inflation,
);

Widget _wrap() => MaterialApp(
      theme: AppTheme.light,
      home: const SimulationResultScreen(params: _params),
    );

void main() {
  testWidgets('met en avant le versement mensuel calculé', (tester) async {
    await tester.pumpWidget(_wrap());

    final expected = SimulationEngine.project(_params).monthlyContribution;

    expect(find.text(Currency.format(expected)), findsOneWidget);
    expect(
      find.text('à épargner chaque mois pour atteindre ton objectif'),
      findsOneWidget,
    );
  });

  testWidgets('affiche la courbe de projection', (tester) async {
    await tester.pumpWidget(_wrap());

    expect(find.byType(ProjectionChart), findsOneWidget);
  });

  testWidgets('détaille versements et intérêts séparément', (tester) async {
    await tester.pumpWidget(_wrap());

    final result = SimulationEngine.project(_params);

    expect(find.text('Total que tu verses'), findsOneWidget);
    expect(find.text(Currency.format(result.totalContributed)), findsOneWidget);
    expect(find.text('Intérêts gagnés'), findsOneWidget);
    expect(find.text(Currency.format(result.interestEarned)), findsOneWidget);
  });

  testWidgets('porte la mention légale obligatoire', (tester) async {
    await tester.pumpWidget(_wrap());

    // UX-DR3 : aucune simulation ne s'affiche sans son avertissement.
    expect(
      find.textContaining('pas un conseil financier'),
      findsOneWidget,
    );
  });

  testWidgets('expose les deux actions de sortie', (tester) async {
    await tester.pumpWidget(_wrap());

    expect(find.text('Créer cet objectif'), findsOneWidget);
    expect(find.text('Modifier les paramètres'), findsOneWidget);
  });
}
