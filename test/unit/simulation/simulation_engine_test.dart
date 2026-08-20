import 'package:flutter_test/flutter_test.dart';
import 'package:sira/core/constants/uemoa_rates.dart';
import 'package:sira/features/simulation/domain/simulation_engine.dart';
import 'package:sira/features/simulation/domain/simulation_models.dart';

void main() {
  group('requiredMonthlyContribution', () {
    test('sans intérêts, répartit simplement la cible sur la durée', () {
      final result = SimulationEngine.requiredMonthlyContribution(
        targetAmount: 1000000,
        initialAmount: 100000,
        durationMonths: 12,
        annualRate: 0,
      );

      // (1 000 000 - 100 000) / 12
      expect(result, 75000);
    });

    test('retourne zéro quand l’apport initial suffit déjà', () {
      final result = SimulationEngine.requiredMonthlyContribution(
        targetAmount: 500000,
        initialAmount: 500000,
        durationMonths: 24,
        annualRate: UemoaRates.savingsAccount,
      );

      expect(result, 0);
    });

    test('exige moins avec intérêts que sans', () {
      const target = 2000000;
      const months = 36;

      final sansInterets = SimulationEngine.requiredMonthlyContribution(
        targetAmount: target,
        initialAmount: 0,
        durationMonths: months,
        annualRate: 0,
      );
      final avecInterets = SimulationEngine.requiredMonthlyContribution(
        targetAmount: target,
        initialAmount: 0,
        durationMonths: months,
        annualRate: UemoaRates.treasuryBills1y,
      );

      expect(avecInterets, lessThan(sansInterets));
    });
  });

  group('projectedAmount', () {
    test('suit la formule de la suite de versements', () {
      // 10 000 F par mois pendant 12 mois à 12 % l’an, soit 1 % par mois.
      // Valeur acquise = 10 000 × ((1,01^12 − 1) / 0,01) = 126 825
      final result = SimulationEngine.projectedAmount(
        initialAmount: 0,
        monthlyContribution: 10000,
        durationMonths: 12,
        annualRate: 0.12,
      );

      expect(result, 126825);
    });

    test('sans intérêts, se réduit à une addition', () {
      final result = SimulationEngine.projectedAmount(
        initialAmount: 50000,
        monthlyContribution: 25000,
        durationMonths: 10,
        annualRate: 0,
      );

      expect(result, 50000 + 25000 * 10);
    });
  });

  group('project', () {
    test('le versement calculé permet bien d’atteindre la cible', () {
      const params = SimulationParams(
        targetAmount: 2000000,
        initialAmount: 200000,
        durationMonths: 36,
        annualRate: UemoaRates.treasuryBills1y,
      );

      final result = SimulationEngine.project(params);

      // L’arrondi à l’entier supérieur garantit d’atteindre la cible,
      // sans la dépasser de plus que l’effet d’un franc par mois.
      expect(result.finalAmount, greaterThanOrEqualTo(params.targetAmount));
      expect(result.finalAmount, lessThan(params.targetAmount + 1000));
    });

    test('produit une courbe continue du premier au dernier mois', () {
      const params = SimulationParams(
        targetAmount: 1000000,
        initialAmount: 100000,
        durationMonths: 24,
        annualRate: UemoaRates.savingsAccount,
      );

      final result = SimulationEngine.project(params);

      expect(result.points.length, 25); // mois 0 inclus
      expect(result.points.first.month, 0);
      expect(result.points.first.amount, 100000);
      expect(result.points.last.month, 24);
      expect(result.points.last.amount, result.finalAmount);

      for (var i = 1; i < result.points.length; i++) {
        expect(
          result.points[i].amount,
          greaterThan(result.points[i - 1].amount),
          reason: 'Le capital doit croître au mois ${result.points[i].month}',
        );
      }
    });

    test('sépare les versements des intérêts', () {
      const params = SimulationParams(
        targetAmount: 3000000,
        durationMonths: 60,
        annualRate: UemoaRates.brvmAverage,
      );

      final result = SimulationEngine.project(params);

      expect(
        result.totalContributed,
        result.monthlyContribution * params.durationMonths,
      );
      expect(result.interestEarned, greaterThan(0));
      expect(
        result.totalContributed + result.interestEarned,
        result.finalAmount,
      );
    });

    test('sans intérêts, ne produit aucun gain', () {
      const params = SimulationParams(
        targetAmount: 600000,
        durationMonths: 12,
        annualRate: 0,
      );

      final result = SimulationEngine.project(params);

      expect(result.monthlyContribution, 50000);
      expect(result.interestEarned, 0);
    });
  });

  group('adjustForInflation', () {
    test('érode le capital selon la durée', () {
      // 1 000 000 dans un an à 3 % d’inflation = 1 000 000 / 1,03
      final result = SimulationEngine.adjustForInflation(
        amount: 1000000,
        annualInflation: 0.03,
        durationMonths: 12,
      );

      expect(result, 970874);
    });

    test('laisse le montant intact sans inflation renseignée', () {
      final result = SimulationEngine.adjustForInflation(
        amount: 1000000,
        annualInflation: 0,
        durationMonths: 36,
      );

      expect(result, 1000000);
    });

    test('le rendement réel reste inférieur au rendement nominal', () {
      const params = SimulationParams(
        targetAmount: 5000000,
        durationMonths: 120,
        annualRate: UemoaRates.brvmAverage,
        inflationRate: UemoaRates.inflation,
      );

      final result = SimulationEngine.project(params);

      expect(result.realFinalAmount, lessThan(result.finalAmount));
    });
  });
}
