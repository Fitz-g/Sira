import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/auth/presentation/welcome_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/onboarding/presentation/onboarding_goal_screen.dart';
import '../../features/onboarding/presentation/onboarding_profile_screen.dart';
import '../../features/onboarding/presentation/onboarding_situation_screen.dart';
import '../../features/simulation/domain/simulation_models.dart';
import '../../features/transactions/presentation/expense_entry_screen.dart';
import '../../features/transactions/presentation/expense_list_screen.dart';
import '../../features/simulation/presentation/simulation_result_screen.dart';
import '../../features/simulation/presentation/simulator_screen.dart';

/// Routes de l'application.
abstract final class Routes {
  static const welcome = '/';
  static const register = '/inscription';
  static const login = '/connexion';

  static const onboardingProfile = '/onboarding/profil';
  static const onboardingSituation = '/onboarding/situation';
  static const onboardingGoal = '/onboarding/objectif';

  static const dashboard = '/accueil';
  static const expenses = '/depenses';
  static const expenseNew = '/depenses/ajouter';

  static const simulator = '/simulateur';
  static const simulationResult = '/simulateur/resultat';
}

final appRouter = GoRouter(
  initialLocation: Routes.welcome,
  routes: [
    GoRoute(
      path: Routes.welcome,
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: Routes.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: Routes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: Routes.onboardingProfile,
      builder: (context, state) => const OnboardingProfileScreen(),
    ),
    GoRoute(
      path: Routes.onboardingSituation,
      builder: (context, state) => const OnboardingSituationScreen(),
    ),
    GoRoute(
      path: Routes.onboardingGoal,
      builder: (context, state) => const OnboardingGoalScreen(),
    ),
    GoRoute(
      path: Routes.dashboard,
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: Routes.expenses,
      // `extra` vaut true quand on arrive juste d'enregistrer une dépense.
      builder: (context, state) =>
          ExpenseListScreen(justAdded: state.extra == true),
    ),
    GoRoute(
      path: Routes.expenseNew,
      builder: (context, state) => const ExpenseEntryScreen(),
    ),
    GoRoute(
      path: Routes.simulator,
      builder: (context, state) => const SimulatorScreen(),
    ),
    GoRoute(
      path: Routes.simulationResult,
      builder: (context, state) {
        // Arriver ici sans paramètres n'a pas de sens : on renvoie vers le
        // formulaire plutôt que d'afficher un résultat vide.
        final params = state.extra;
        if (params is! SimulationParams) return const SimulatorScreen();
        return SimulationResultScreen(params: params);
      },
    ),
  ],
);
