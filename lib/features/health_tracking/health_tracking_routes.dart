import 'package:go_router/go_router.dart';

import '../../app/router/routes.dart';
import 'presentation/pages/heart_rate_pages.dart';

List<RouteBase> buildHealthTrackingRoutes() {
  return [
    GoRoute(
      path: AppRoutes.healthHeartInput,
      builder: (context, state) => const HeartRateInputPage(),
    ),
    GoRoute(
      path: AppRoutes.healthHeartDetail,
      builder: (context, state) => const HeartRateDetailPage(),
    ),
  ];
}
