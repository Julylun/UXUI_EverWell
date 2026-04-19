import '../../features/onboarding_auth/data/repositories/auth_repository.dart';
import '../../features/onboarding_auth/data/repositories/onboarding_repository.dart';
import '../../features/onboarding_auth/data/services/mock_auth_service.dart';
import '../../features/onboarding_auth/data/services/mock_onboarding_service.dart';

/// Global composition root for UI-only phase (replace with real DI later).
final class AppScope {
  AppScope._();

  static final authRepository = AuthRepository(const MockAuthService());
  static final onboardingRepository = OnboardingRepository(
    const MockOnboardingService(),
  );
}
