import 'data/repositories/health_tracking_repository.dart';
import 'data/services/mock_health_tracking_service.dart';

/// Một repository dùng chung cho toàn feature (giai đoạn UI-only + mock).
final HealthTrackingRepository healthTrackingRepository =
    HealthTrackingRepository(const MockHealthTrackingService());
