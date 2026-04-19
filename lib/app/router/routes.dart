/// Central route paths (WS-A uses `/auth/*` and `/onboarding/*`).
abstract final class AppRoutes {
  static const welcome = '/welcome';

  static const authLoginReady = '/auth/login-ready';
  static const authLogin = '/auth/login';
  static const authRegister = '/auth/register';
  static const authRegisterOtp = '/auth/register/otp';
  static const authRegisterSuccess = '/auth/register/success';
  static const authForgotEmail = '/auth/forgot/email';
  static const authForgotOtp = '/auth/forgot/otp';
  static const authForgotNewPassword = '/auth/forgot/new-password';

  static const onboardingPersonalInfo = '/onboarding/personal-info';
  static const onboardingAvatar = '/onboarding/avatar';
  static const onboardingImportEmr = '/onboarding/import-emr';
  static const onboardingImportEmrSuccess = '/onboarding/import-emr/success';
  static const onboardingNfcInfo = '/onboarding/nfc-info';
  static const onboardingNfcScan = '/onboarding/nfc-scan';
  static const onboardingNfcSuccess = '/onboarding/nfc-success';

  /// Placeholder for [plans/feature_plan.md] WS-B (Home).
  static const home = '/home';
}
