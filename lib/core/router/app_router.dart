import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/auth/presentation/welcome_screen.dart';

/// Routes de l'application.
abstract final class Routes {
  static const welcome = '/';
  static const register = '/inscription';
  static const login = '/connexion';
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
  ],
);
