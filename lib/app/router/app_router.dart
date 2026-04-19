import 'package:go_router/go_router.dart';

import '../../features/onboarding_auth/onboarding_auth_routes.dart';
import '../presentation/home_placeholder_page.dart';
import 'routes.dart';

/// Application router. WS-A registers its subtree via [buildOnboardingAuthRoutes].
final class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.welcome,
    routes: [
      ...buildOnboardingAuthRoutes(),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomePlaceholderPage(),
      ),
    ],
  );
}
