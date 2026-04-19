import 'package:go_router/go_router.dart';

import '../../features/health_tracking/health_tracking_routes.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/medication/medication_routes.dart';
import '../../features/medical_records/medical_records_routes.dart';
import '../../features/onboarding_auth/onboarding_auth_routes.dart';
import 'routes.dart';

/// Application router. WS-A registers its subtree via [buildOnboardingAuthRoutes].
final class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      ...buildOnboardingAuthRoutes(),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomePage(),
      ),
      ...buildMedicalRecordsRoutes(),
      ...buildMedicationRoutes(),
      ...buildHealthTrackingRoutes(),
    ],
  );
}
