import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/auth/presentation/welcome_screen.dart';
import '../../features/simulation/domain/simulation_models.dart';
import '../../features/simulation/presentation/simulation_result_screen.dart';
import '../../features/simulation/presentation/simulator_screen.dart';

/// Routes de l'application.
abstract final class Routes {
  static const welcome = '/';
  static const register = '/inscription';
  static const login = '/connexion';
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
